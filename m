Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hAQDWZRb019207
	for <selinux@tycho.nsa.gov>; Wed, 26 Nov 2003 08:32:35 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id hAQDW0p5013564
	for <selinux@tycho.nsa.gov>; Wed, 26 Nov 2003 13:32:00 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id hAQDVxt0013561
	for <selinux@tycho.nsa.gov>; Wed, 26 Nov 2003 13:31:59 GMT
Subject: Re: genfs_contexts file
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Russell Coker <russell@coker.com.au>
Cc: Carlos =?ISO-8859-1?Q?An=EDsio?= Monteiro <monteiro@ipen.br>,
   selinux <selinux@tycho.nsa.gov>
In-Reply-To: <200311261135.09128.russell@coker.com.au>
References: <3FC3CE10.8020307@ipen.br>
	 <200311261135.09128.russell@coker.com.au>
Content-Type: text/plain
Message-Id: <1069853537.30315.8.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Wed, 26 Nov 2003 08:32:18 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2003-11-25 at 19:35, Russell Coker wrote:
> Files/directories that are assigned contexts with genfscon do not have an 
> xattr, so "ls --context" can not show their context.
> 
> This is a known issue.  I don't know if there are plans to change it.

It would be possible to implement a "pseudo" xattr handler for such
filesystems, as we have already done for devpts.  But that has to be
done for every filesystem type where you want to export the labels to
userspace.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
