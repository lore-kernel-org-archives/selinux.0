Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tarius.tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h33Lx0x6003017
	for <selinux@tycho.nsa.gov>; Thu, 3 Apr 2003 16:59:01 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h33Lx0xH021612
	for <selinux@tycho.nsa.gov>; Thu, 3 Apr 2003 21:59:00 GMT
Received: from sat.sws.net.au ([202.5.161.49])
        by jazzband.ncsc.mil  with ESMTP id h33LwvDl021609 for <selinux@tycho.nsa.gov>; Thu, 3 Apr 2003 21:58:58 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: "Stephen D. Smalley" <sds@epoch.ncsc.mil>, selinux@tycho.nsa.gov
Subject: Re: policy
Date: Fri, 4 Apr 2003 07:58:50 +1000
References: <200304032201.RAA25118@moss-shockers.ncsc.mil>
In-Reply-To: <200304032201.RAA25118@moss-shockers.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200304040758.50344.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 4 Apr 2003 08:01, Stephen D. Smalley wrote:
> > allow $1_t sshd_tmp_t:file create_file_perms;
> > The above rule from macros/user_macros.te looks dangerous.  We have the
> > type sshd_tmp_t being used for all user domains.
>
> Agreed, I've removed this from our internal tree.  It appears that this
> is also granted to some program domains, e.g. the su domains and the
> ssh client domains.

That will probably break a few things, but that's fine.  When we break things 
we will then be able to fix them properly, just as long as it doesn't get 
released in the broken version.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
