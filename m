Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iA1KTgXZ029930
	for <selinux@tycho.nsa.gov>; Mon, 1 Nov 2004 15:29:42 -0500 (EST)
Received: from epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id iA1KTgfG007383
	for <selinux@tycho.nsa.gov>; Mon, 1 Nov 2004 20:29:42 GMT
Subject: Re: dynamic context transitions
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Cc: James Morris <jmorris@redhat.com>, Darrel Goeddel <dgoeddel@TrustedCS.com>,
   "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>,
   Chad Hanson <chanson@TrustedCS.com>, samba-technical@samba.org,
   tng-technical@samba-tng.org
In-Reply-To: <20041101203524.GJ9643@lkcl.net>
References: <418662EE.5090001@trustedcs.com>
	 <Xine.LNX.4.44.0411011508210.5409-100000@thoron.boston.redhat.com>
	 <20041101203524.GJ9643@lkcl.net>
Content-Type: text/plain
Message-Id: <1099340721.21386.223.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Mon, 01 Nov 2004 15:25:21 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2004-11-01 at 15:35, Luke Kenneth Casson Leighton wrote:
>  no there is no reason why [a helper application should] not [be used].
>  
>  i am not sure if the simple solution [that andrew and russell
>  came up with] was fully enumerated: it involves exec'ing a
>  per-user helper application which does a setuid.
>  
>  the helper application opens files as-and-when they are needed,
>  [and also does mkdirs? and rmdirs?] and then passes the file
>  descriptor over a unix-domain-socket to the smbd process,
>  which NEVER itself does file opens under a user context.
> 
>  i believe it then no longer becomes necessary for smbd to
>  call become_user().

Except that SELinux mediates access to file descriptors upon transfer
via local socket IPC as well as attempted use for read/write, so SELinux
is still going to apply a permission check to the parent smbd process in
that situation.  Not to mention that this no doubt has a significant
cost.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
