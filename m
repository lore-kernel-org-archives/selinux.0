Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hBHIVdRb003205
	for <selinux@tycho.nsa.gov>; Wed, 17 Dec 2003 13:31:39 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id hBHIUojx017688
	for <selinux@tycho.nsa.gov>; Wed, 17 Dec 2003 18:30:51 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id hBHIUoSR017685
	for <selinux@tycho.nsa.gov>; Wed, 17 Dec 2003 18:30:50 GMT
Subject: Re: policy problem with nfs mounting
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Chris PeBenito <pebenito@gentoo.org>
Cc: SELinux Mail List <selinux@tycho.nsa.gov>,
   Jim Carter <jwcart2@epoch.ncsc.mil>, Russell Coker <russell@coker.com.au>
In-Reply-To: <1070914878.16071.10.camel@chris.pebenito.net>
References: <1070904612.15475.7.camel@chris.pebenito.net>
	 <1070909315.7949.40.camel@moss-spartans.epoch.ncsc.mil>
	 <1070914878.16071.10.camel@chris.pebenito.net>
Content-Type: text/plain
Message-Id: <1071685888.1403.113.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Wed, 17 Dec 2003 13:31:28 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2003-12-08 at 15:21, Chris PeBenito wrote:
> Well I made a mistake on this; I wouldn't have seen this had I not
> missed merging in the two rules at the bottom of mount.te to allow
> mounting of unlabeled fs's.  But since it looks like these other
> interfaces are going to be worked on soon, I put in a rpc_pipefs_t
> anyway, see attached patch.

Thanks, also merged into our CVS tree.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
