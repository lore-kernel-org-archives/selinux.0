Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h4MCAPI4020801
	for <selinux@tycho.nsa.gov>; Thu, 22 May 2003 08:10:25 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h4MCAOtV009336
	for <selinux@tycho.nsa.gov>; Thu, 22 May 2003 12:10:24 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
        by jazzband.ncsc.mil  with ESMTP id h4MCANal009333 for <selinux@tycho.nsa.gov>; Thu, 22 May 2003 12:10:23 GMT
Subject: Re: run_init woes
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Tom <tom@lemuria.org>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <20030522112833.A2615@lemuria.org>
References: <20030522112833.A2615@lemuria.org>
Content-Type: text/plain
Message-Id: <1053605415.4729.1349.camel@moss-huskers.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 22 May 2003 08:10:20 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2003-05-22 at 05:28, Tom wrote:
> I've started writing a policy for PXE daemon, improving tftpd policy,
> etc - when something weird happend to me.
> 
> # run_init /etc/init.d/pxe start
> Authenticating root.
> Password:
> Starting PXE daemon: Intel PXE daemon, PXE-2.0 Beta-1 (build 001)
> Copyright (C) 1999  Intel Corporation
> pxe.
> 
> 
> So far, so good. Except that the pxe daemon dies right away. No debug 
> output either, nothing in the logfiles.

What happens if you do the following (in permissive mode, of course):
	runas system_u:system_r:initrc_t /etc/init.d/pxe start

Are you using the extension to run_init created by Russell Coker to
create a separate pty for the daemon, or just the normal run_init
program?  What happens if you use the upstream run_init without his
modification?   

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
