Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i4IJtERb004878
	for <selinux@tycho.nsa.gov>; Tue, 18 May 2004 15:55:14 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i4IJqnB2020815
	for <selinux@tycho.nsa.gov>; Tue, 18 May 2004 19:52:50 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id i4IJqnwi020812
	for <selinux@tycho.nsa.gov>; Tue, 18 May 2004 19:52:49 GMT
Subject: Re: list of permissions created by allow2audit: what do i do now?
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Cc: SE-Linux <selinux@tycho.nsa.gov>
In-Reply-To: <20040518185135.GL24917@lkcl.net>
References: <20040518104026.GC24333@lkcl.net>
	 <1084884047.28966.59.camel@moss-spartans.epoch.ncsc.mil>
	 <20040518130244.GB24917@lkcl.net>
	 <1084886403.28966.76.camel@moss-spartans.epoch.ncsc.mil>
	 <20040518151112.GF24917@lkcl.net>
	 <1084900706.28966.110.camel@moss-spartans.epoch.ncsc.mil>
	 <20040518185135.GL24917@lkcl.net>
Content-Type: text/plain
Message-Id: <1084910062.28966.183.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Tue, 18 May 2004 15:54:22 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2004-05-18 at 14:51, Luke Kenneth Casson Leighton wrote:
>tv:/etc/selinux# compute_av system_u:system_r:xdm_xserver_t system_u:system_r:initrc_t shm
> 	allowed= null
> 
>  uhn???

You asked what the X server (started from xdm) (xdm_xserver_t) can do to
a shared memory object (shm) created by a system initialization script
(initrc_t).  And the answer was nothing.  Why is that surprising?

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
