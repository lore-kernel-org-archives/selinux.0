Message-ID: <48B2BC4D.7010901@windriver.com>
Date: Mon, 25 Aug 2008 10:06:05 -0400
From: Vikram Ambrose <Vikram.Ambrose@windriver.com>
MIME-Version: 1.0
To: Joshua Brindle <method@manicmethod.com>
CC: Stephen Smalley <sds@tycho.nsa.gov>, SELinux@tycho.nsa.gov,
        Daniel J Walsh <dwalsh@redhat.com>,
        Manoj Srivastava <srivasta@debian.org>, Caleb Case <ccase@tresys.com>
Subject: Re: New SELinux toolchain build system
References: <48A04E61.3090506@windriver.com> <48A1F6D4.7000909@manicmethod.com> <48A47719.3020007@windriver.com> <48B20816.8030502@manicmethod.com>
In-Reply-To: <48B20816.8030502@manicmethod.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Joshua Brindle wrote:
> Vikram Ambrose wrote:
>   
>> Joshua Brindle wrote:
>>     
>>> Vikram Ambrose wrote:
>>>  
>>>       
>>>> Attached to this email is a tarball snapshot of a new build system
>>>> for the SELinux toolchain that I have been working on for the last
>>>> couple of months.
>>>>
>>>> This autoconf/automake build system has many advantages over the
>>>> current Makefiles.
>>>>
>>>> 1) It is capable of correctly cross compiling all libraries and
>>>>  tools, including the python wrappers.
>>>> 2) It allows the distro maintainer to set sysconfdir, prefix,
>>>>  pamdir, startupdir etc..
>>>> 3) It employs no "hacks", it is to-the-book, clean, GNU Automake,
>>>>  Autoconf code, formatted to ~80 char line length.
>>>> 4) It lets RPM spec and .deb control take advantage of the autoconf
>>>>  infrastructure already built into these package formats, allowing
>>>>  distro maintainers to quickly and effortlessly build distro
>>>>  packages.
>>>> 5) It is completely self dependent, ie. one can build the complete
>>>>  toolchain now resolving dependencies within the build, without
>>>>  needing to link against a system wide library.
>>>>
>>>> Due to an incompatibility with libtool, related to the current
>>>> naming convention of the python wrappers and classes, a patch is
>>>> supplied to rename:
>>>>  *) _selinux.so to libpyselinux.so
>>>>  *) _semanage.so to libpysemanage.so
>>>>  *) _audit2why.so to libpyaudit2why.so
>>>>
>>>> Similarily, the update also renames:
>>>>  *) selinux.py to __init__.py
>>>>  *) semanage.py to __init__.py
>>>> and installs these plugins into their own sub site-packages folder.
>>>>
>>>> For Example: libselinux/src/Makefile.am
>>>> line 35 # When the upstream tree is patched this should be removed
>>>> line 36 # and selinux.py must be renamed to __init__.py
>>>> line 37 __init__.py : selinux.py
>>>> line 38        cp selinux.py $@
>>>>
>>>> A similar measure is taken in libsemanage/src/Makefile.am for
>>>> semanage.py.
>>>>
>>>> On a similar note, the code currently uses a macro called SHARED,
>>>> which is currently being wrapped with a forced -include libtool_compat.h
>>>> using -DPIC (a libtool defined macro). This too can be removed if the
>>>> code
>>>> can be reformatted.
>>>>
>>>> This build system has been thoroughly tested to function correctly.
>>>> Compiling natively for localhost, as well as cross compiling for
>>>> the following platforms:
>>>>  *) PPC32
>>>>  *) PPC64
>>>>  *) ARM (Versatile family)
>>>>  *) Common PC X86_64
>>>>
>>>> It has also been tested on mainstream Linux distributions such
>>>> as Ubuntu 8.04 and Fedora 9.
>>>>
>>>> This new build system is a replacement for the existing build system.
>>>> They cannot be used concurrently. I leave no guarantee on backward
>>>> compatibility after applying this update.
>>>>
>>>> Recently a Ruby wrapper was added to the SELinux trunk, this build
>>>> system does not build it. Though with the current infrastructure in
>>>> place, it is a very simple procedure for anyone familiar with ruby
>>>> to include it.
>>>>
>>>> This contribution comes out of the integration efforts WindRiver has
>>>> recently taken to add a SELinux feature to WindRiver Linux. It comes
>>>> with no obligation or indemnity from WindRiver or myself. Distributed
>>>> as not copyrighted, public domain software, in accordance with
>>>> libselinux.
>>>>
>>>> I ask if this update can be merged into the main SELinux trunk.
>>>> I will help coordinate the merge if necessary.
>>>>
>>>>     
>>>>         
>>> I've just started looking at this. We need to be sure that it covers
>>> current make targets like make swigify which generate the c wrappers
>>> from swig interface files (we run this before checkins). Also make
>>> test needs to work.
>>>
>>> Also there is no top level ./configure so this won't let you build the
>>> entire repo. I'd like something (even if it was just the makefile that
>>> ran ./configure in each dir.
>>>
>>> I also get a failure:
>>> [root@misterfreeze libsepol]# autoreconf -iv
>>> autoreconf: Entering directory `.'
>>> autoreconf: configure.ac: not using Gettext
>>> autoreconf: running: aclocal autoreconf: configure.ac: tracing
>>> autoreconf: configure.ac: not using Libtool
>>> autoreconf: running: /usr/bin/autoconf
>>> autoreconf: running: /usr/bin/autoheader
>>> autoreconf: running: automake --add-missing --copy --no-force
>>> configure.ac:17: installing `./compile'
>>> configure.ac:6: installing `./install-sh'
>>> configure.ac:6: installing `./missing'
>>> include/Makefile.am:2: whitespace following trailing backslash
>>> include/Makefile.am:5: whitespace following trailing backslash
>>> include/Makefile.am:8: whitespace following trailing backslash
>>> include/Makefile.am:9: whitespace following trailing backslash
>>> include/Makefile.am:11: whitespace following trailing backslash
>>> include/Makefile.am:14: whitespace following trailing backslash
>>> include/Makefile.am:20: whitespace following trailing backslash
>>> src/Makefile.am:10: Libtool library used but `LIBTOOL' is undefined
>>> src/Makefile.am:10:   The usual way to define `LIBTOOL' is to add
>>> `AC_PROG_LIBTOOL'
>>> src/Makefile.am:10:   to `configure.ac' and run `aclocal' and
>>> `autoconf' again.
>>> src/Makefile.am:10:   If `AC_PROG_LIBTOOL' is in `configure.ac', make
>>> sure
>>> src/Makefile.am:10:   its definition is in aclocal's search path.
>>> src/Makefile.am: installing `./depcomp'
>>> Makefile.am: installing `./INSTALL'
>>> Makefile.am: required file `./NEWS' not found
>>> Makefile.am: required file `./README' not found
>>> Makefile.am: required file `./AUTHORS' not found
>>> autoreconf: automake failed with exit status: 1
>>>
>>>
>>>   
>>>       
>> Formatting error caused by the sanitation process. An updated tarball is
>> attached to this email, with the following changes from the previous:
>>
>> 1) Fixed trailing white space in libsepol/src/Makefile.am
>> 2) Added --enable-swig option to libselinux and libsemanage to regenerate
>>   c-wrapper
>> 3) Added very very basic top level makefile, proof-of-concept to build
>> entire
>>   trunk. make -f Makefile.toolchain PREFIX=/some/where (Requested by
>> Joshua.B)
>> 4) Minor python related cleanups in configure.ac for libselinux and
>>   libsemanage
>>
>>     
>
> Dan, Manoj, Caleb, you can skip to the bottom of this email
>
> I have a branch with the latest patch, my current observations:
> * checkpolicy/test isn't built (this is included on fedora and must be built)
>   

That was done intentionally, I don't use it, so I didn't build it. That 
doesn't mean no one else can add 3 lines to a new Makefile.am.
> * when I generated the configure scripts in a fresh repo apparently it felt the need to relicense libselinux as gplv3 (added a COPYING file)
>   
If you do not provide a COPYING file, autoconf will generate one for 
you, so I suggest a COPYING, and any other dist file (eg, Changelog, 
NEWS, AUTHORS etc..) be made by hand and placed in the tree.
> * the CFLAGS we previously had have been completely removed, we need those back, particularly the warning ones and they aren't necessarily consistent:
> libsepol/src/Makefile:CFLAGS ?= -Werror -Wall -W -Wundef -Wshadow -Wmissing-noreturn -Wmissing-format-attribute
> libsemanage/src/Makefile:CFLAGS ?= -Wall -W -Wundef -Wshadow -Wmissing-noreturn -Wmissing-format-attribute -Wno-unused-parameter
> checkpolicy/Makefile:CFLAGS ?= -g -Wall -Werror -Wshadow -O2 -pipe -fno-strict-aliasing
> libselinux/src/Makefile:CFLAGS ?= -Werror -Wall -W -Wundef -Wshadow -Wmissing-noreturn -Wmissing-format-attribute
>
> Also, we filter out Werror from generated files (parser and lexer files, swig generated files) because they often cause warnings and we can't help it
>
>   
there is a libblah_la_CFLAGS = in each Makefile.am, you can tack those 
onto it. But i strongly suggest you only add the necessary, eg  -g, -O2 
etc.. are not mandatory, and should not be forced on the package 
builder. autoconf has support for such by adding them on the configure 
line,
eg ./configure CFLAGS="-Werror -pipe -Wall" --prefix=/blah etc..

> * make clean from the top doesn't actually clean anything, it just removes the makefiles
>
> * there is no way to distclean from the top level, eg., make the repository look like it will when we package up a release
>   
The top level makefile was just a proof-of-concept. If you need a top 
level makefile, then write one. The one i supplied was only intended to 
show that the tree builds.
> * Why doesn't configure automatically find python? the vast majority of selinux installations are going to require the python bits so it should default to on and I'm not sure what the use of the autotools infrastructure is if it can't find the resources we need automatically
>   
This is actually quite a complicated topic. Python is not very good at 
being used in a cross platform environment. And thus autoconf cannot be 
blamed for not being able to use python correctly in this manner. 
Autoconf depends on the "python" interpreter for information on which 
version and where python is installed. Now the problem with this is 
that, the build machine must have an identical python to your target 
machine, which is not possible on eg, x86_32 and ppc_64, as python 
generates arch dependent C-headers instead of #ifdef'ing the various 
architectures. There are more intricate problems that I could write a 
paper on, but i doubt you're interested. (eg Building on Linux for 
Windows, BSD, Solaris or vice versa, Or broken build systems like that 
of Redhat/Fedora)

To cut a long story short: No, you cannot build python wrappers outside 
your target _properly_ without explicitly telling the build system which 
python to use. To counter this, I have got autoconf to pick up the local 
python and suggest it to the user, this way autoconf doesn't guess and 
then get blamed for doing the "wrong thing". The user is the only one to 
blame if the package doesn't build.
> * configure is currently doing alot of tests for unnecessary things, such as a fortran compiler. This is one of the problems I have using autotools, it takes time and adds complexity for no reason
>   
I'll look into it, but a lot of it is done implicitly.
> * building an embedded libselinux (--disable-rpm --disable-avc --disable-bool) fails:
> 	/usr/bin/ld: .libs/libselinux_la-load_policy.o: relocation R_X86_64_PC32 against undefined symbol `security_get_boolean_names_internal' can not be used when making a shared object; recompile with -fPIC
>
>   
Yup, i'll look at that too.
> I think that is probably enough for now..
>
> --
>
> I created an autotools branch on the upstream git repo so all new patches should be based on that instead of a tarball. 
>
> Also, I'd like distributions to start testing this branch as they are less likely to be affected by the issues raised above. Distributions will likely be mostly affected by the change of python bindings from _*.so to libpy*.so, and also will need to run configure with --with-python=/usr/include/python2.5 to have a useful build
>   
yes, and --enable-swig too. As the pre-generated .c file will not be 
patched.


Working hard over the weekend hey method? give me svn write access to 
your autotools branch, this will speed up the initial ground work. I am 
moving onto other wild and wonderful things next week and would like to 
get this working for you guys as soon as possible.

Vikram.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
