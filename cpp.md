# C++ Standards

**⚠️ [warp.md](./warp.md) | [project.md](./project.md)**

**Stack**: C++20/23, CMake 3.25+, Catch2/GoogleTest; CLI: CLI11; TUI: FTXUI; Async: Asio/libcoro

## Standards

**Docs**: Doxygen comments all public APIs (classes, functions, namespaces)
**Test**: Catch2 or GoogleTest, ≥75% overall+per-module, integration for critical paths, exclude main()
**Coverage**: Count src/*, exclude main/examples/generated
**Style**: clang-format (Google/LLVM/Mozilla style), clang-tidy for linting
**Types**: Strong typing, prefer `std::optional`/`std::variant`/`std::expected` over nulls/exceptions

## Commands

```bash
task cpp:build|test|test:coverage|cpp:fmt|cpp:lint|quality|check
cmake -S . -B build -DCMAKE_BUILD_TYPE=Debug -DENABLE_TESTING=ON
cmake --build build
ctest --test-dir build --output-on-failure
lcov --capture --directory build --output-file coverage.info
genhtml coverage.info --output-directory coverage
```

## Workflow

```bash
task cpp:fmt && task cpp:lint && task cpp:build && task test && task check
```

**Tests**: `test_*.cpp` or `*_test.cpp`, ≥75%/module, integration in `tests/integration/`

## Patterns

**TEST_CASE** (Catch2):
```cpp
TEST_CASE("Description", "[tag]") {
    SECTION("case1") {
        auto result = func(input);
        REQUIRE(result == expected);
        REQUIRE_THROWS_AS(func(bad), std::exception);
    }
}
```

**TEST** (GoogleTest):
```cpp
TEST(SuiteName, TestName) {
    EXPECT_EQ(func(input), expected);
    EXPECT_THROW(func(bad), std::exception);
    ASSERT_TRUE(condition);
}
```

**Mocks** (GoogleMock):
```cpp
class MockInterface : public Interface {
public:
    MOCK_METHOD(ReturnType, MethodName, (Args...), (override));
};
TEST(Test, Mock) {
    MockInterface mock;
    EXPECT_CALL(mock, MethodName(testing::_)).WillOnce(testing::Return(value));
}
```

**RAII**: Always use smart pointers (`std::unique_ptr`, `std::shared_ptr`), avoid raw `new`/`delete`
**Error Handling**: Prefer `std::expected<T, E>` (C++23) or `std::optional<T>` + out-params over exceptions for expected errors
**Containers**: Use `std::vector`, `std::array`, `std::span`; avoid C arrays
**String Views**: Use `std::string_view` for read-only string params

## CMakeLists.txt

```cmake
cmake_minimum_required(VERSION 3.25)
project(ProjectName VERSION 1.0.0 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

# Options
option(ENABLE_TESTING "Enable testing" ON)
option(ENABLE_COVERAGE "Enable coverage" OFF)

# Compiler warnings
add_compile_options(
    -Wall -Wextra -Wpedantic -Werror
    $<$<CONFIG:Debug>:-g -O0>
    $<$<CONFIG:Release>:-O3 -DNDEBUG>
)

# Coverage flags
if(ENABLE_COVERAGE)
    add_compile_options(--coverage)
    add_link_options(--coverage)
endif()

# Dependencies
find_package(Catch2 3 REQUIRED)  # or GTest

# Library
add_library(${PROJECT_NAME} src/lib.cpp)
target_include_directories(${PROJECT_NAME}
    PUBLIC
        $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>
        $<INSTALL_INTERFACE:include>
)

# Executable
add_executable(${PROJECT_NAME}_app src/main.cpp)
target_link_libraries(${PROJECT_NAME}_app PRIVATE ${PROJECT_NAME})

# Tests
if(ENABLE_TESTING)
    enable_testing()
    add_subdirectory(tests)
endif()
```

## tests/CMakeLists.txt

```cmake
# Catch2
add_executable(tests test_module.cpp)
target_link_libraries(tests PRIVATE ${PROJECT_NAME} Catch2::Catch2WithMain)
catch_discover_tests(tests)

# GoogleTest
add_executable(tests test_module.cpp)
target_link_libraries(tests PRIVATE ${PROJECT_NAME} GTest::gtest_main)
gtest_discover_tests(tests)
```

## .clang-format

```yaml
BasedOnStyle: Google  # or LLVM, Mozilla
IndentWidth: 2
ColumnLimit: 100
PointerAlignment: Left
DerivePointerAlignment: false
```

## .clang-tidy

```yaml
Checks: 'clang-diagnostic-*,clang-analyzer-*,cppcoreguidelines-*,modernize-*,performance-*,readability-*,-readability-magic-numbers'
WarningsAsErrors: '*'
HeaderFilterRegex: '.*'
```

## Idioms

**Rule of Zero/Five**: Let compiler generate special members OR define all 5 (copy ctor, copy assign, move ctor, move assign, dtor)
**Const Correctness**: Mark methods `const` when they don't modify state; use `const&` for input params
**Namespaces**: Organize code in namespaces, avoid `using namespace` in headers
**Modern Loops**: `for (const auto& item : container)` instead of iterators
**Initialization**: Use brace-init `{}` over `()` to avoid narrowing/most-vexing-parse
**Templates**: Use concepts (C++20) to constrain template parameters

## Compliance

Doxygen all public APIs, Catch2/GoogleTest, ≥75% coverage, clang-format+clang-tidy, `task check` before commit
