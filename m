Subject: Re: [PATCH] pkgconfig support for libsepol, libselinux, and
 libsemanage
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Eamon Walsh <ewalsh@tycho.nsa.gov>
Cc: SELinux List <selinux@tycho.nsa.gov>, Joshua Brindle <jbrindle@tresys.com>,
        Caleb Case <ccase@tresys.com>, srivasta@golden-gryphon.com,
        Daniel J Walsh <dwalsh@redhat.com>
In-Reply-To: <4ADE735D.9020901@tycho.nsa.gov>
References: <4ADE735D.9020901@tycho.nsa.gov>
Content-Type: text/plain
Date: Wed, 21 Oct 2009 08:23:29 -0400
Message-Id: <1256127809.4061.170.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2009-10-20 at 22:35 -0400, Eamon Walsh wrote:
> Add pkgconfig files for libsepol, libselinux, and libsemanage.
> 
> Having a pkgconfig file allows the pkg-config(1) tool to be used to
> query the presence of the library (or a particular version of it),
> and to obtain the C flags and linker arguments required to use it.
> 
> Based on Debian patches by Manoj Srivastava<srivasta@debian.org>.
> 
> Signed-off-by: Eamon Walsh<ewalsh@tycho.nsa.gov>
> ---
> 
> Note that the .pc.in files themselves could use some review to make
> sure the Requires and Libs lines are correct.  The sepol and selinux
> ones are from the Debian repos; the semanage one I wrote myself.

> diff --git a/libselinux/src/libselinux.pc.in b/libselinux/src/libselinux.pc.in
> new file mode 100644
> index 0000000..c9608d9
> --- /dev/null
> +++ b/libselinux/src/libselinux.pc.in
> @@ -0,0 +1,13 @@
> +prefix=@prefix@
> +exec_prefix=${prefix}
> +libdir=${exec_prefix}/lib
> +includedir=@includedir@
> +
> +Name: libselinux
> +Description: SELinux utility library
> +Version: @VERSION@
> +URL: http://www.nsa.gov/research/selinux/
> +Requires.private: libsepol>= 1.12
> +Libs: -L${libdir} -lselinux
> +Libs.private: -pthread
> +Cflags: -I${includedir}

Requires.private only applies to the static lib, right?  In the shared
lib, libsepol is dlopen'd on demand these days and is only needed if
loading a policy file whose version is greater than the version
supported by the kernel.

I'd drop the >= 1.12 or make it more current.  

libpthread should not be necessary any longer (it was temporarily from
libselinux 2.0.82 through 2.0.84); if the program is already linked with
libpthread then libselinux will use pthread_once for lazy
initialization; otherwise it will fall back to a simple test.

Not sure if you should specify libdl or if that is implicitly handled.

> diff --git a/libsemanage/src/libsemanage.pc.in b/libsemanage/src/libsemanage.pc.in
> new file mode 100644
> index 0000000..6d0024c
> --- /dev/null
> +++ b/libsemanage/src/libsemanage.pc.in
> @@ -0,0 +1,12 @@
> +prefix=@prefix@
> +exec_prefix=${prefix}
> +libdir=${exec_prefix}/lib
> +includedir=@includedir@
> +
> +Name: libsemanage
> +Description: SELinux management library
> +Version: @VERSION@
> +URL: http://www.nsa.gov/research/selinux/
> +Requires: libselinux
> +Libs: -L${libdir} -lsemanage
> +Cflags: -I${includedir}

Modern libsemanage requires libsepol, libselinux, libbz2, and libustr.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
