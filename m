Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hAJJK7Rb020151
	for <selinux@tycho.nsa.gov>; Wed, 19 Nov 2003 14:20:08 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id hAJJK7qY020171
	for <selinux@tycho.nsa.gov>; Wed, 19 Nov 2003 19:20:07 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
        by jazzband.ncsc.mil  with ESMTP id hAJJK60o020168 for <selinux@tycho.nsa.gov>; Wed, 19 Nov 2003 19:20:06 GMT
Subject: Re: Extended attributes and ACLs in SELinux
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Carlos =?ISO-8859-1?Q?An=EDsio?= Monteiro <monteiro@ipen.br>
Cc: selinux <selinux@tycho.nsa.gov>
In-Reply-To: <3FBBB2F1.6020505@ipen.br>
References: <3FBBB2F1.6020505@ipen.br>
Content-Type: text/plain; charset=UTF-8
Message-Id: <1069269598.25899.70.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Wed, 19 Nov 2003 14:19:58 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2003-11-19 at 13:14, Carlos Anísio Monteiro wrote:
> Please, I need of a information, how SELinux use "extended attributes 
> and ACLs". Thus, I will can understand why enable this options in the 
> kernel configuration.

SELinux doesn't use ACLs.  It does use extended attributes now to store
file security contexts on disk.  In the past, it used its own custom
persistent label mapping on the disk.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
