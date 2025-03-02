# Custom overlays
final: prev: {
  # Example: Create a custom package or override an existing one
  # myCustomPackage = prev.callPackage ./packages/custom-package {};
  
  # Example: Override an existing package
  # firefox = prev.firefox.override { ... };
}
