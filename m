Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u7GBDjJM028595
 for <selinux@tycho.nsa.gov>; Tue, 16 Aug 2016 07:13:45 -0400
Received: by mail-pa0-f66.google.com with SMTP id vy10so5137217pac.0
 for <selinux@tycho.nsa.gov>; Tue, 16 Aug 2016 04:13:38 -0700 (PDT)
Date: Tue, 16 Aug 2016 19:13:34 +0800
From: Jason Zaman <jason@perfinion.com>
To: Nicolas Iooss <nicolas.iooss@m4x.org>
Cc: selinux@tycho.nsa.gov
Subject: Re: libselinux Python wrapper and SWIG 3.0.10
Message-ID: <20160816111334.GA13313@meriadoc.perfinion.com>
References: <a87a04a3-f175-0869-ac5e-654ac9206f5e@m4x.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <a87a04a3-f175-0869-ac5e-654ac9206f5e@m4x.org>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Tue, Aug 16, 2016 at 12:57:39PM +0200, Nicolas Iooss wrote:
> Hello all,
> 
> The last SWIG release (3.0.10, release in June) introduced an
> incompatibility in the way the Python wrapper loads its C module, as
> described in SWIG ChangeLog [1]. This breaks "import selinux" on systems
> running Arch Linux:

This should be fixed in the git repo already, just gotta apply that patch.

commit a9604c30a5e2f71007d31aa6ba41cf7b95d94822
Author: Petr Lautrbach <plautrba@redhat.com>
Date:   Mon Jun 27 16:46:13 2016

    libselinux: Change the location of _selinux.so
    
    There was a change in swig-3.10 to use importlib instead of imp. While
    the implementation with imp looked for _selinux.so also into the same directory
    as __init__.py is, a new module with importlib searchs only standard paths.
    It means that we need to move _selinux.so from $(PYLIBDIR)/site-packages/selinux/
    to $(PYLIBDIR)/site-packages/.

-- Jason


>     $ python
>     Python 3.5.2 (default, Jun 28 2016, 08:46:01)
>     [GCC 6.1.1 20160602] on linux
>     Type "help", "copyright", "credits" or "license" for more information.
>     >>> import selinux
>     Traceback (most recent call last):
>     File "/usr/lib/python3.5/site-packages/selinux/__init__.py", line
> 18, in swig_import_helper
>         return importlib.import_module(mname)
>       File "/usr/lib/python3.5/importlib/__init__.py", line 126, in
> import_module
>         return _bootstrap._gcd_import(name[level:], package, level)
>       File "<frozen importlib._bootstrap>", line 986, in _gcd_import
>       File "<frozen importlib._bootstrap>", line 969, in _find_and_load
>       File "<frozen importlib._bootstrap>", line 956, in
> _find_and_load_unlocked
>     ImportError: No module named '_selinux'
> 
> As far as I understand, SWIG no longer supports that its generated
> Python module is renamed "__init__.py": the generated function
> swig_import_helper() tries to import _selinux right outside of the
> selinux module instead of importing "selinux._selinux" (cf. [2] for the
> code of this function). When I replace "return
> importlib.import_module(mname)" with "return
> importlib.import_module('selinux._selinux')" it works as expected.
> 
> In short, renaming selinux.py to __init__.py in install-pywrap target
> [3] no longer works. The most simple way to fix this seems to be to keep
> the SWIG-generated selinux.py named selinux.py and to create a new
> __init__.py file in $(PYLIBDIR)/site-packages/selinux/ with "from
> selinux.selinux import *" in it. Would such a fix be acceptable?
> 
> Thanks,
> Nicolas
> 
> [1] https://github.com/swig/swig/blob/rel-3.0.10/CHANGES.current
> [2]
> https://github.com/swig/swig/blob/rel-3.0.10/Source/Modules/python.cxx#L822-L873
> [3]
> https://github.com/SELinuxProject/selinux/blob/libselinux-2.5/libselinux/src/Makefile#L160
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to Selinux-request@tycho.nsa.gov.
