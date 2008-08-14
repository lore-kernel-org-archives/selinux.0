Message-ID: <48A47719.3020007@windriver.com>
Date: Thu, 14 Aug 2008 14:19:05 -0400
From: Vikram Ambrose <Vikram.Ambrose@windriver.com>
MIME-Version: 1.0
To: Joshua Brindle <method@manicmethod.com>
CC: Stephen Smalley <sds@tycho.nsa.gov>, SELinux@tycho.nsa.gov
Subject: Re: New SELinux toolchain build system
References: <48A04E61.3090506@windriver.com> <48A1F6D4.7000909@manicmethod.com>
In-Reply-To: <48A1F6D4.7000909@manicmethod.com>
Content-Type: multipart/mixed;
 boundary="------------080400010508070206080205"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------080400010508070206080205
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Joshua Brindle wrote:
> Vikram Ambrose wrote:
>   
>> Attached to this email is a tarball snapshot of a new build system
>> for the SELinux toolchain that I have been working on for the last
>> couple of months.
>>
>> This autoconf/automake build system has many advantages over the
>> current Makefiles.
>>
>> 1) It is capable of correctly cross compiling all libraries and
>>  tools, including the python wrappers.
>> 2) It allows the distro maintainer to set sysconfdir, prefix,
>>  pamdir, startupdir etc..
>> 3) It employs no "hacks", it is to-the-book, clean, GNU Automake,
>>  Autoconf code, formatted to ~80 char line length.
>> 4) It lets RPM spec and .deb control take advantage of the autoconf
>>  infrastructure already built into these package formats, allowing
>>  distro maintainers to quickly and effortlessly build distro
>>  packages.
>> 5) It is completely self dependent, ie. one can build the complete
>>  toolchain now resolving dependencies within the build, without
>>  needing to link against a system wide library.
>>
>> Due to an incompatibility with libtool, related to the current
>> naming convention of the python wrappers and classes, a patch is
>> supplied to rename:
>>  *) _selinux.so to libpyselinux.so
>>  *) _semanage.so to libpysemanage.so
>>  *) _audit2why.so to libpyaudit2why.so
>>
>> Similarily, the update also renames:
>>  *) selinux.py to __init__.py
>>  *) semanage.py to __init__.py
>> and installs these plugins into their own sub site-packages folder.
>>
>> For Example: libselinux/src/Makefile.am
>> line 35 # When the upstream tree is patched this should be removed
>> line 36 # and selinux.py must be renamed to __init__.py
>> line 37 __init__.py : selinux.py
>> line 38        cp selinux.py $@
>>
>> A similar measure is taken in libsemanage/src/Makefile.am for semanage.py.
>>
>> On a similar note, the code currently uses a macro called SHARED,
>> which is currently being wrapped with a forced -include libtool_compat.h
>> using -DPIC (a libtool defined macro). This too can be removed if the code
>> can be reformatted.
>>
>> This build system has been thoroughly tested to function correctly.
>> Compiling natively for localhost, as well as cross compiling for
>> the following platforms:
>>  *) PPC32
>>  *) PPC64
>>  *) ARM (Versatile family)
>>  *) Common PC X86_64
>>
>> It has also been tested on mainstream Linux distributions such
>> as Ubuntu 8.04 and Fedora 9.
>>
>> This new build system is a replacement for the existing build system.
>> They cannot be used concurrently. I leave no guarantee on backward
>> compatibility after applying this update.
>>
>> Recently a Ruby wrapper was added to the SELinux trunk, this build
>> system does not build it. Though with the current infrastructure in
>> place, it is a very simple procedure for anyone familiar with ruby
>> to include it.
>>
>> This contribution comes out of the integration efforts WindRiver has
>> recently taken to add a SELinux feature to WindRiver Linux. It comes
>> with no obligation or indemnity from WindRiver or myself. Distributed
>> as not copyrighted, public domain software, in accordance with
>> libselinux.
>>
>> I ask if this update can be merged into the main SELinux trunk.
>> I will help coordinate the merge if necessary.
>>
>>     
>
> I've just started looking at this. We need to be sure that it covers current make targets like make swigify which generate the c wrappers from swig interface files (we run this before checkins). Also make test needs to work.
>
> Also there is no top level ./configure so this won't let you build the entire repo. I'd like something (even if it was just the makefile that ran ./configure in each dir.
>
> I also get a failure:
> [root@misterfreeze libsepol]# autoreconf -iv
> autoreconf: Entering directory `.'
> autoreconf: configure.ac: not using Gettext
> autoreconf: running: aclocal 
> autoreconf: configure.ac: tracing
> autoreconf: configure.ac: not using Libtool
> autoreconf: running: /usr/bin/autoconf
> autoreconf: running: /usr/bin/autoheader
> autoreconf: running: automake --add-missing --copy --no-force
> configure.ac:17: installing `./compile'
> configure.ac:6: installing `./install-sh'
> configure.ac:6: installing `./missing'
> include/Makefile.am:2: whitespace following trailing backslash
> include/Makefile.am:5: whitespace following trailing backslash
> include/Makefile.am:8: whitespace following trailing backslash
> include/Makefile.am:9: whitespace following trailing backslash
> include/Makefile.am:11: whitespace following trailing backslash
> include/Makefile.am:14: whitespace following trailing backslash
> include/Makefile.am:20: whitespace following trailing backslash
> src/Makefile.am:10: Libtool library used but `LIBTOOL' is undefined
> src/Makefile.am:10:   The usual way to define `LIBTOOL' is to add `AC_PROG_LIBTOOL'
> src/Makefile.am:10:   to `configure.ac' and run `aclocal' and `autoconf' again.
> src/Makefile.am:10:   If `AC_PROG_LIBTOOL' is in `configure.ac', make sure
> src/Makefile.am:10:   its definition is in aclocal's search path.
> src/Makefile.am: installing `./depcomp'
> Makefile.am: installing `./INSTALL'
> Makefile.am: required file `./NEWS' not found
> Makefile.am: required file `./README' not found
> Makefile.am: required file `./AUTHORS' not found
> autoreconf: automake failed with exit status: 1
>
>
>   
Formatting error caused by the sanitation process. An updated tarball is 
attached to this email, with the following changes from the previous:

1) Fixed trailing white space in libsepol/src/Makefile.am
2) Added --enable-swig option to libselinux and libsemanage to regenerate
   c-wrapper
3) Added very very basic top level makefile, proof-of-concept to build 
entire
   trunk. make -f Makefile.toolchain PREFIX=/some/where (Requested by 
Joshua.B)
4) Minor python related cleanups in configure.ac for libselinux and
   libsemanage


Vikram

-- 
Vikram Ambrose | Linux Products Division | WindRiver Corporation


--------------080400010508070206080205
Content-Type: application/x-bzip;
 name="selinux-autotools-14082008.tar.bz2"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="selinux-autotools-14082008.tar.bz2"

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
--------------080400010508070206080205--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
