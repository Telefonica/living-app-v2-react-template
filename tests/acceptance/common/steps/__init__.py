"""Common init.

Copyright (c) Telefónica Innovación Digital.
Living Apps QA Team <qacdcolivingapps@telefonica.com>
"""

import importlib
import pkgutil

__all__ = []
package_name = __name__
for loader, module_name, is_pkg in pkgutil.walk_packages(__path__, package_name + "."):
    __all__.append(module_name)
    spec = loader.find_spec(module_name)
    if spec is not None:
        _module = importlib.import_module(module_name)
        globals()[module_name] = _module
