Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i4IDVURb001246
	for <selinux@tycho.nsa.gov>; Tue, 18 May 2004 09:31:30 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i4IDVQAR019054
	for <selinux@tycho.nsa.gov>; Tue, 18 May 2004 13:31:26 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
        by jazzband.ncsc.mil  with ESMTP id i4IDVPHn019046 for <selinux@tycho.nsa.gov>; Tue, 18 May 2004 13:31:25 GMT
Subject: Re: list of permissions created by allow2audit: what do i do now?
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Cc: SE-Linux <selinux@tycho.nsa.gov>
In-Reply-To: <1084886403.28966.76.camel@moss-spartans.epoch.ncsc.mil>
References: <20040518104026.GC24333@lkcl.net>
	 <1084884047.28966.59.camel@moss-spartans.epoch.ncsc.mil>
	 <20040518130244.GB24917@lkcl.net>
	 <1084886403.28966.76.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Message-Id: <1084887058.28966.84.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Tue, 18 May 2004 09:30:58 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2004-05-18 at 09:20, Stephen Smalley wrote:
> On Tue, 2004-05-18 at 09:02, Luke Kenneth Casson Leighton wrote:
> >  ah.  then i will try.... xdm, and see what happens.
> > 
> >  (wdm is the patched one from daniel walsh).
> 
> Are you sure?  I'm not aware of any patched wdm from Dan Walsh, just one
> by Tom Vogt that was upstreamed.

BTW, my intent is not to scare you away from using the patched wdm.  I'd
rather see any issues with it worked out so that other people can use it
with SELinux too.

Tom Vogt developed the patch for wdm and upstreamed it.  I think Manoj
developed a patch for xdm and was going to try to upstream it; don't
know if he succeeded.  Dan originally patched gdm for SELinux, but I
think they may have migrated to using pam_selinux for it instead.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
