Message-ID: <48BF4023.7010007@manicmethod.com>
Date: Wed, 03 Sep 2008 21:55:47 -0400
From: Joshua Brindle <method@manicmethod.com>
MIME-Version: 1.0
To: noel.ambrose@gmail.com
CC: Stephen Smalley <sds@tycho.nsa.gov>, Daniel J Walsh <dwalsh@redhat.com>,
        Manoj Srivastava <srivasta@debian.org>, Caleb Case <ccase@tresys.com>,
        SE Linux <selinux@tycho.nsa.gov>
Subject: Re: [PATCH][origin/autotools] fix libtool_compat header error
References: <48B6FD13.1000204@windriver.com>
In-Reply-To: <48B6FD13.1000204@windriver.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Vikram Ambrose wrote:
> More stuff:
> 
> 1. Fixed error for libtool_compat.h in libsepol/libselinux
> 2. Renamed pam modules with pamd suffix to prevent overwriting
> corresponding binaries
> 3. Added --enable-test option to libsepol (no Makefile.am yet)
> 4. Added few more autogen.sh scripts
> 5. Added .gitignore file to prevent accidental checkin of autoconf temp
> files
> 
> Note: My SELinux work from now onwards will be unofficial, and any
> correspondence should be to my personal email address,
> noel.ambrose@gmail.com, or you can always catch me on IRC.
> 

(Back on list)

Looks much better, some things: policycoreutils apparently knows how to find libsepol.a by itself but checkpolicy doesn't?

Also, I'm still getting this from libselinux when I build out the optional support:
./configure --disable-rpm --disable-avc --disable-bool --disable-swig --disable-docs

gcc -shared  .libs/compute_member.o .libs/get_default_type.o .libs/lgetfilecon.o .libs/selinux_config.o .libs/compute_relabel.o .libs/getenforce.o .libs/load_policy.o .libs/compute_user.o .libs/getfilecon.o .libs/lsetfilecon.o .libs/setenforce.o .libs/context.o .libs/get_initial_context.o .libs/setfilecon.o .libs/disable.o .libs/getpeercon.o .libs/matchmediacon.o .libs/setrans_client.o .libs/callbacks.o .libs/enabled.o .libs/init.o .libs/matchpathcon.o .libs/seusers.o .libs/canonicalize_context.o .libs/fgetfilecon.o .libs/is_customizable_type.o .libs/policyvers.o .libs/freeconary.o .libs/label.o .libs/procattr.o .libs/check_context.o .libs/freecon.o .libs/label_file.o .libs/query_user_context.o .libs/compute_av.o .libs/fsetfilecon.o .libs/label_media.o .libs/compute_create.o .libs/get_context_list.o .libs/label_x.o .libs/selinux_check_securetty_context.o  -ldl  -Wl,--as-needed -Wl,-soname -Wl,libselinux.so.1 -o .libs/libselinux.so.1.0.0
/usr/bin/ld: .libs/load_policy.o: relocation R_X86_64_PC32 against undefined symbol `security_get_boolean_names_internal' can not be used when making a shared object; recompile with -fPIC
/usr/bin/ld: final link failed: Bad value
collect2: ld returned 1 exit status

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
