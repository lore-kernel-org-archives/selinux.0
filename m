Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i4IDiiRb001365
	for <selinux@tycho.nsa.gov>; Tue, 18 May 2004 09:44:45 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i4IDigAR019957
	for <selinux@tycho.nsa.gov>; Tue, 18 May 2004 13:44:42 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
        by jazzband.ncsc.mil  with ESMTP id i4IDigHn019954 for <selinux@tycho.nsa.gov>; Tue, 18 May 2004 13:44:42 GMT
Subject: Re: list of permissions created by allow2audit: what do i do now?
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Cc: SE-Linux <selinux@tycho.nsa.gov>
In-Reply-To: <1084887058.28966.84.camel@moss-spartans.epoch.ncsc.mil>
References: <20040518104026.GC24333@lkcl.net>
	 <1084884047.28966.59.camel@moss-spartans.epoch.ncsc.mil>
	 <20040518130244.GB24917@lkcl.net>
	 <1084886403.28966.76.camel@moss-spartans.epoch.ncsc.mil>
	 <1084887058.28966.84.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Message-Id: <1084887845.28966.87.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Tue, 18 May 2004 09:44:05 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2004-05-18 at 09:30, Stephen Smalley wrote:
> Tom Vogt developed the patch for wdm and upstreamed it.  I think Manoj
> developed a patch for xdm and was going to try to upstream it; don't
> know if he succeeded.  Dan originally patched gdm for SELinux, but I
> think they may have migrated to using pam_selinux for it instead.

Ok, it looks like the SELinux patch for gdm is also upstream.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
