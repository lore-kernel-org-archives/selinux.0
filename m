Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i68DF5rT012816
	for <selinux@tycho.nsa.gov>; Thu, 8 Jul 2004 09:15:05 -0400 (EDT)
Received: from epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i68DEl5G005316
	for <selinux@tycho.nsa.gov>; Thu, 8 Jul 2004 13:14:47 GMT
Subject: Re: policy to allow upgrade of nfs-utils
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Russell Coker <russell@coker.com.au>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <200407081319.05138.russell@coker.com.au>
References: <200407081319.05138.russell@coker.com.au>
Content-Type: text/plain
Message-Id: <1089292484.6414.17.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Thu, 08 Jul 2004 09:14:44 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2004-07-07 at 23:19, Russell Coker wrote:
> The attached policy patch is needed to allow nfs-utils to be upgraded to the 
> latest version on a rawhide system.

Should /etc/exports get its own type?

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
