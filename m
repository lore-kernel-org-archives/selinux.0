Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id JAA14918
	for <selinux@tycho.nsa.gov>; Thu, 11 Jul 2002 09:03:51 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id NAA06378
	for <selinux@tycho.nsa.gov>; Thu, 11 Jul 2002 13:02:20 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
        by jazzband.ncsc.mil  with ESMTP id NAA06374 for <selinux@tycho.nsa.gov>; Thu, 11 Jul 2002 13:02:20 GMT
Date: Thu, 11 Jul 2002 09:03:13 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Debian User <rogelio@evoworks.evoserve.com>
cc: <selinux@tycho.nsa.gov>
Subject: Re: automatic type transitions for pts in devfs
In-Reply-To: <3D2D7BA1.2010304@evoworks.evoserve.com>
Message-ID: <Pine.GSO.4.33.0207110857160.822-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Thu, 11 Jul 2002, Debian User wrote:

> Im having a problem with my X Window devpts entries.  The task sid when
> X Window creates a pty is xdm_t. What should the proper type be? Ssh
> works perfectly now in enforcing mode. X stops when I switch to
> enforcing mode. What are the type transitions when gdm starts X window?

To use an X Display Manager, you need a patched [xgk]dm to set the
security context for the user session, as noted in selinux/README.  We do
not provide a patched [xgk]dm, but I think Russell Coker has a patched kdm
and Mark Westerman has a patched gdm.  If you are using a patched [xgk]dm,
then the pty should be created by a process in the user's domain, not
xdm_t, so it should pick up the proper user_devpts_t or sysadm_devpts_t
type automatically.  At least, that has been my experience.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
