Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id HAA19368
	for <selinux@tycho.nsa.gov>; Wed, 20 Nov 2002 07:54:45 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id MAA13397
	for <selinux@tycho.nsa.gov>; Wed, 20 Nov 2002 12:52:44 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
        by jazzband.ncsc.mil  with ESMTP id MAA13393 for <selinux@tycho.nsa.gov>; Wed, 20 Nov 2002 12:52:44 GMT
Message-Id: <200211201301.IAA16963@moss-shockers.ncsc.mil>
Date: Wed, 20 Nov 2002 08:01:57 -0500 (EST)
From: "Stephen D. Smalley" <sds@epoch.ncsc.mil>
Reply-To: "Stephen D. Smalley" <sds@epoch.ncsc.mil>
Subject: Re: allow a_domain_t fs_t:filesystem getattr;
To: selinux@tycho.nsa.gov, russell@coker.com.au
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> It seems that almost everything wants to check for free space on file systems 
> occasionally.
> 
> Is there any reason for not changing macros such as daemon_base_domain() and 
> general_domain_access() to include it instead?

It is already in general_file_read_acess(), as 'allow $1 fs_type:filesystem 
getattr;'.

--
Stephen Smalley, NSA
sds@epoch.ncsc.mil


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
