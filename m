Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id KAA20509
	for <selinux@tycho.nsa.gov>; Wed, 3 Oct 2001 10:01:36 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id NAA19148
	for <selinux@tycho.nsa.gov>; Wed, 3 Oct 2001 13:59:53 GMT
Received: from sentry.gw.tislabs.com (relay.hq.tis.com [192.94.214.100] (may be forged))
	by jazzswing.ncsc.mil  with ESMTP id NAA19144
	for <selinux@tycho.nsa.gov>; Wed, 3 Oct 2001 13:59:52 GMT
Date: Wed, 3 Oct 2001 10:01:11 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: James Bishop <james.bishop@jrc.it>
cc: <selinux@tycho.nsa.gov>
Subject: Re: Compiling for SuSE 7.2
In-Reply-To: <3BBB0FF1.6060309@jrc.it>
Message-ID: <Pine.GSO.4.33.0110030952140.20811-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Wed, 3 Oct 2001, James Bishop wrote:

> This is my first posting to this list, so "hello world!\n".

Welcome to the list.  In case you aren't aware, you can obtain up-to-date
mailing list archives either via email to majordomo@tycho.nsa.gov or
online at http://marc.theaimsgroup.com/?l=selinux.  The hypermail archives
at the NSA web site are only updated when the web site is updated, e.g.
for a new release.

> Compilation of the modified applications in the selinux/utils
> sub-directory required commenting out the contents of the
> fileutils-4.0/m4/isc-posix.m4 file (I don't know m4); and changing the
> Makefile in psmisc to link pstree with the ncurses library instead of
> the termcap library.
>
> Now I'm up against the differences between the RedHat 7.1 and SuSE 7.2
> distributions. The MCONFIG files of the util-linux package are different
> (also SuSE 7.2 uses util-linux-2.11). I know from past experience that
> getting things wrong with util-linux is "a bit of a bore".

Most of the modified daemons and utility programs are not essential to
SELinux but nice to have available.  The most critical one is the modified
login program (to set the security context for user sessions), followed
by the modified sshd and crond.  For non-RedHat distributions, you should
really look into porting the SELinux utility patches to the corresponding
source package provided with that distribution.  Blindly installing our
modified utilities (which were typically based on the RedHat variants)
could break your system.  Even if your distribution uses the same code
base for some of the modified utilities, it may use different
configuration options (e.g. disabling PAM) or its own set of additional
patches, so even these utilities may need customization.

> If I proceed to install the utils package as is, can anyone tell me
> whether login will still work? Or could / should I modify the MCONFIG
> file of SELinux to bring it closer into line with the SuSE 7.2 version?

If you do this, I would definitely recommend modifying the MCONFIG file to
be closer to the SuSE 7.2 version.  But you are likely to have greater
success if you take the time to port the util-linux patch to the SuSE 7.2
version.

> I see that the SELinux Makefile moves the original /bin/login to
> /bin/login.old and then installs the new /bin/login. If I could ensure
> that /bin/login.old was used (perhaps on the basis of the result of the
> uname command - SuSE 7.2 is kernel version 2.4.4)I would feel better.
> How could I do this?

I'm not sure about this, but you should be able to boot singleuser if
necessary to recover.

> Should I remove shadow passwords from the SuSE 7.2 system before
> proceeding, or can I leave them in place?

The SELinux modified login program runs fine on RedHat 7.1 systems with
shadow passwords.  The MCONFIG HAVE_SHADOW=no is simply to force the login
program to be built.  Since the login program uses PAM on RedHat, shadow
passwords are handled transparently.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
