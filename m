Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i67KmRrT008848
	for <selinux@tycho.nsa.gov>; Wed, 7 Jul 2004 16:48:27 -0400 (EDT)
Received: from epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i67Km8Cu003976
	for <selinux@tycho.nsa.gov>; Wed, 7 Jul 2004 20:48:09 GMT
Subject: Re: latest LVM policy
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Russell Coker <russell@coker.com.au>
Cc: SE Linux <selinux@tycho.nsa.gov>, Daniel J Walsh <dwalsh@redhat.com>
In-Reply-To: <200407050030.57905.russell@coker.com.au>
References: <200407050030.57905.russell@coker.com.au>
Content-Type: text/plain
Message-Id: <1089233290.1774.266.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Wed, 07 Jul 2004 16:48:11 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 2004-07-04 at 10:30, Russell Coker wrote:
> I have attached my latest policy for LVM.  It works for cryptsetup as well as 
> other LVM stuff.
> 
> With this policy I have a machine mounting a LVM file system and using 
> encrypted swap.
> 
> Steve, please commit this to SF.

Merged.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
