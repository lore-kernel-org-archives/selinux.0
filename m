Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id JAA12076
	for <selinux@tycho.nsa.gov>; Mon, 8 Oct 2001 09:51:11 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id NAA08122
	for <selinux@tycho.nsa.gov>; Mon, 8 Oct 2001 13:50:41 GMT
Received: from sentry.gw.tislabs.com (relay.hq.tis.com [192.94.214.100] (may be forged))
	by jazzband.ncsc.mil  with ESMTP id NAA08118
	for <selinux@tycho.nsa.gov>; Mon, 8 Oct 2001 13:50:40 GMT
Date: Mon, 8 Oct 2001 09:50:37 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: James Bishop <james.bishop@jrc.it>
cc: <selinux@tycho.nsa.gov>
Subject: Re: Compiling for SuSE 7.2
In-Reply-To: <3BC17C93.9080601@jrc.it>
Message-ID: <Pine.GSO.4.33.0110080939300.9507-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Mon, 8 Oct 2001, James Bishop wrote:

> I can live without X for this project, where we have to implement a root
> certification authority for a system using public key cryptography. I'm
> interested in using Linux for the registration service of the root CA,
> and SELinux appears to be ideal for this task. So, X is neither
> required, nor desirable if it bypasses the login choke-point.

Ok.  However, you can run X after logging into the system via startx if
you uncomment the necessary permissions in your xserver.te file, so  this
is a possibility if you need it.  Also, Mark Westerman has created a
modified gdm and a gdm policy, so you could use that if needed.  But be
aware that either of these choices has risks.

> 1) My modified login does not work on my original SuSE (7.2 running a
> 2.4.4 kernel); I go through the motions of logging in, but just get
> returned to the login screen, as in SELinux.
> 2) The SuSE login uses PAM.

See if you can successfully build and run a pure SuSE 7.2 login using the
original sources from which you started.  Make sure that you are
configuring and building the login program in the same way as rpm would,
in accordance with the RPM spec file.  Verify that your problems aren't
due to the non-FLASK MCONFIG changes.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
