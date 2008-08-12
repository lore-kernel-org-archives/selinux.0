Message-ID: <48A1E61E.1050900@redhat.com>
Date: Tue, 12 Aug 2008 15:35:58 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Vikram Ambrose <Vikram.Ambrose@windriver.com>
CC: ds@tycho.nsa.gov, SELinux@tycho.nsa.gov
Subject: Re: New SELinux toolchain build system
References: <48A04E61.3090506@windriver.com>
In-Reply-To: <48A04E61.3090506@windriver.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Vikram Ambrose wrote:
> Attached to this email is a tarball snapshot of a new build system
> for the SELinux toolchain that I have been working on for the last
> couple of months.
> 
> This autoconf/automake build system has many advantages over the
> current Makefiles.
> 
> 1) It is capable of correctly cross compiling all libraries and
>  tools, including the python wrappers.
> 2) It allows the distro maintainer to set sysconfdir, prefix,
>  pamdir, startupdir etc..
> 3) It employs no "hacks", it is to-the-book, clean, GNU Automake,
>  Autoconf code, formatted to ~80 char line length.
> 4) It lets RPM spec and .deb control take advantage of the autoconf
>  infrastructure already built into these package formats, allowing
>  distro maintainers to quickly and effortlessly build distro
>  packages.
> 5) It is completely self dependent, ie. one can build the complete
>  toolchain now resolving dependencies within the build, without
>  needing to link against a system wide library.
> 
> Due to an incompatibility with libtool, related to the current
> naming convention of the python wrappers and classes, a patch is
> supplied to rename:
>  *) _selinux.so to libpyselinux.so
>  *) _semanage.so to libpysemanage.so
>  *) _audit2why.so to libpyaudit2why.so
> 
> Similarily, the update also renames:
>  *) selinux.py to __init__.py
>  *) semanage.py to __init__.py
> and installs these plugins into their own sub site-packages folder.
> 
> For Example: libselinux/src/Makefile.am
> line 35 # When the upstream tree is patched this should be removed
> line 36 # and selinux.py must be renamed to __init__.py
> line 37 __init__.py : selinux.py
> line 38        cp selinux.py $@
> 
> A similar measure is taken in libsemanage/src/Makefile.am for semanage.py.
> 
> On a similar note, the code currently uses a macro called SHARED,
> which is currently being wrapped with a forced -include libtool_compat.h
> using -DPIC (a libtool defined macro). This too can be removed if the code
> can be reformatted.
> 
> This build system has been thoroughly tested to function correctly.
> Compiling natively for localhost, as well as cross compiling for
> the following platforms:
>  *) PPC32
>  *) PPC64
>  *) ARM (Versatile family)
>  *) Common PC X86_64
> 
> It has also been tested on mainstream Linux distributions such
> as Ubuntu 8.04 and Fedora 9.
> 
> This new build system is a replacement for the existing build system.
> They cannot be used concurrently. I leave no guarantee on backward
> compatibility after applying this update.
> 
> Recently a Ruby wrapper was added to the SELinux trunk, this build
> system does not build it. Though with the current infrastructure in
> place, it is a very simple procedure for anyone familiar with ruby
> to include it.
> 
> This contribution comes out of the integration efforts WindRiver has
> recently taken to add a SELinux feature to WindRiver Linux. It comes
> with no obligation or indemnity from WindRiver or myself. Distributed
> as not copyrighted, public domain software, in accordance with
> libselinux.
> 
> I ask if this update can be merged into the main SELinux trunk.
> I will help coordinate the merge if necessary.
> 
> Sincerely,
> 
> Vikram Ambrose
> 
This sounds good to me. We could use this to clean up some of the spec
files. x86_64 library stuff.  I have no problem fixing the spec files up
to use this if it becomes the new build environment.  Just need to make
sure python - include selinux and friends works.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
