Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hB1E6iRb006535
	for <selinux@tycho.nsa.gov>; Mon, 1 Dec 2003 09:06:44 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id hB1E64p5001893
	for <selinux@tycho.nsa.gov>; Mon, 1 Dec 2003 14:06:04 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id hB1E64t0001890
	for <selinux@tycho.nsa.gov>; Mon, 1 Dec 2003 14:06:04 GMT
Subject: Re: Installation of packages
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Carlos =?ISO-8859-1?Q?An=EDsio?= Monteiro <monteiro@ipen.br>
Cc: selinux <selinux@tycho.nsa.gov>
In-Reply-To: <3FC5E6EA.30409@ipen.br>
References: <3FC5E6EA.30409@ipen.br>
Content-Type: text/plain; charset=UTF-8
Message-Id: <1070287593.12270.44.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Mon, 01 Dec 2003 09:06:33 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2003-11-27 at 06:58, Carlos Anísio Monteiro wrote:
> I would like to know what packages (patches for linux utilities,
> login, coreutils, procps, shadow ...) are essentials to system and if
> there is a sequence of installation this packages.

If you are working from our last public release on nsa.gov, then the
most important ones are:
- util-linux (patched login program to set the user security context)
- openssh (patched sshd to set the user security context)
- vixie-cron (patched crond to set the user security context)

If you are working from Dan's packages
(ftp://people.redhat.com/dwalsh/SELinux), then the most important ones
are:
- SysVinit (patched init program to perform the initial policy load,
obsoletes the need to modify your initrd)
- pam (pam_selinux module and other SELinux modifications to pam)
- util-linux (login pam configuration modified to use pam_selinux)
- openssh (patched sshd)
- vixie-cron (patched crond)

The patched coreutils and procps are certainly useful, but they aren't
essential to basic system operation.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
