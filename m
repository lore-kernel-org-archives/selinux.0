Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u7GAw2BC026121
 for <selinux@tycho.nsa.gov>; Tue, 16 Aug 2016 06:58:02 -0400
Received: by mail-wm0-f42.google.com with SMTP id o80so159041545wme.1
 for <selinux@tycho.nsa.gov>; Tue, 16 Aug 2016 03:57:42 -0700 (PDT)
Received: from ?IPv6:2a02:8428:4da:9800:d18e:4cd5:a616:57e8?
 (2a02-8428-04da-9800-d18e-4cd5-a616-57e8.rev.sfr.net.
 [2a02:8428:4da:9800:d18e:4cd5:a616:57e8])
 by smtp.googlemail.com with ESMTPSA id s6sm26081543wjm.25.2016.08.16.03.57.40
 for <selinux@tycho.nsa.gov>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 16 Aug 2016 03:57:40 -0700 (PDT)
From: Nicolas Iooss <nicolas.iooss@m4x.org>
Subject: libselinux Python wrapper and SWIG 3.0.10
To: selinux@tycho.nsa.gov
Message-ID: <a87a04a3-f175-0869-ac5e-654ac9206f5e@m4x.org>
Date: Tue, 16 Aug 2016 12:57:39 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Hello all,

The last SWIG release (3.0.10, release in June) introduced an
incompatibility in the way the Python wrapper loads its C module, as
described in SWIG ChangeLog [1]. This breaks "import selinux" on systems
running Arch Linux:

    $ python
    Python 3.5.2 (default, Jun 28 2016, 08:46:01)
    [GCC 6.1.1 20160602] on linux
    Type "help", "copyright", "credits" or "license" for more information.
    >>> import selinux
    Traceback (most recent call last):
    File "/usr/lib/python3.5/site-packages/selinux/__init__.py", line
18, in swig_import_helper
        return importlib.import_module(mname)
      File "/usr/lib/python3.5/importlib/__init__.py", line 126, in
import_module
        return _bootstrap._gcd_import(name[level:], package, level)
      File "<frozen importlib._bootstrap>", line 986, in _gcd_import
      File "<frozen importlib._bootstrap>", line 969, in _find_and_load
      File "<frozen importlib._bootstrap>", line 956, in
_find_and_load_unlocked
    ImportError: No module named '_selinux'

As far as I understand, SWIG no longer supports that its generated
Python module is renamed "__init__.py": the generated function
swig_import_helper() tries to import _selinux right outside of the
selinux module instead of importing "selinux._selinux" (cf. [2] for the
code of this function). When I replace "return
importlib.import_module(mname)" with "return
importlib.import_module('selinux._selinux')" it works as expected.

In short, renaming selinux.py to __init__.py in install-pywrap target
[3] no longer works. The most simple way to fix this seems to be to keep
the SWIG-generated selinux.py named selinux.py and to create a new
__init__.py file in $(PYLIBDIR)/site-packages/selinux/ with "from
selinux.selinux import *" in it. Would such a fix be acceptable?

Thanks,
Nicolas

[1] https://github.com/swig/swig/blob/rel-3.0.10/CHANGES.current
[2]
https://github.com/swig/swig/blob/rel-3.0.10/Source/Modules/python.cxx#L822-L873
[3]
https://github.com/SELinuxProject/selinux/blob/libselinux-2.5/libselinux/src/Makefile#L160
