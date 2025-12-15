# Titan Workspace

This is a Python workspace managed by `uv`, demonstrating the use of **Namespace
Packages**.

## Structure

The workspace consists of the following packages under the `titan` namespace:

- `package_a`: Provides `mod_a`.
- `package_b`: Provides `mod_b`.
- `titan`: Provides `mod_titan`.

## Development

To set up the environment, ensure you have `uv` installed.

```bash
uv sync
```

## Running Scripts

Each package defines a script entry point:

- `package_a`: `uv run package_a`
- `package_b`: `uv run package_b`
- `titan`: `uv run titan`
