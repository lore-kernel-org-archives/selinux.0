Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id NAA04637
	for <selinux@tycho.nsa.gov>; Fri, 5 Oct 2001 13:09:49 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id RAA26666
	for <selinux@tycho.nsa.gov>; Fri, 5 Oct 2001 17:08:06 GMT
Received: from csoc-fire1.csoconline.com (csoc-mail-imc.csoconline.com [140.169.2.142])
	by jazzswing.ncsc.mil  with SMTP id RAA26662
	for <selinux@tycho.nsa.gov>; Fri, 5 Oct 2001 17:08:05 GMT
Message-ID: <72222DC86846D411ABD300A0C9EB08A10152420E@csoc-mail-box.csoconline.com>
From: "Westerman, Mark" <Mark.Westerman@csoconline.com>
To: "'Stephen Smalley'" <sds@tislabs.com>,
        Russell Coker
	 <russell@coker.com.au>
Cc: James Bishop <james.bishop@jrc.it>, selinux@tycho.nsa.gov
Subject: RE: Compiling for SuSE 7.2
Date: Fri, 5 Oct 2001 12:09:54 -0500 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

The gdm program is working, I have modified it for the
lsm-selinux. I any body wi=ould like a copy please let me know.

Work ok for me.

Mark
mark.westerman@csoconline.com

-----Original Message-----
From: Stephen Smalley [mailto:sds@tislabs.com]
Sent: Friday, October 05, 2001 10:35 AM
To: Russell Coker
Cc: James Bishop; selinux@tycho.nsa.gov
Subject: Re: Compiling for SuSE 7.2



On Fri, 5 Oct 2001, Russell Coker wrote:

> /bin/login is for console logins, telnetd, and I think rshd.  sshd doesn't
> use it (but there's a patch to sshd).  X logins use an X program, options
> include xdm, kdm, gdm, and many others.  I intend to develop a patch for
kdm
> after getting everything else working (if no-one beats me to it).

The simplest approach is to obtain the default security context for the
user (via the get_default_user_sid function in libsecure) and use it in
the appropriate exec*_secure call, and then let the user run newrole if
necessary to change roles after login.  Also, as with login, the ?dm
program should set the security context for the user's terminal device.
Mark Westerman experimented with a patch for gdm that is available on
his sourceforge selinux project site, but I'm not sure how far he got.

Note that some policy customization will be necessary to properly support
the use of the ?dm programs.  A separate domain should be defined for
these programs, and some of their helper programs may also need separate
domains to provide least privilege.

Longer term, it would be nice to change ?dm and its helper programs to
permit users to specify a security context upon login.  But this would
be more complicated and require a more invasive patch.

> Initially using startx after logging in on the console is easiest.

Yes, this is what we recommend if you want to run X.  However, please note
that you must uncomment some allow rules in the
policy/domains/program/xserver.te file to grant the X server the necessary
permissions.  And note that this is dangerous - X is far too privileged,
and needs to be restructured to support least privilege.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux
list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov
with
the words "unsubscribe selinux" without quotes as the message.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
