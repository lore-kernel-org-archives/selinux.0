Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i08E94Rb021467
	for <selinux@tycho.nsa.gov>; Thu, 8 Jan 2004 09:09:04 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i08E93iV008342
	for <selinux@tycho.nsa.gov>; Thu, 8 Jan 2004 14:09:03 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
        by jazzband.ncsc.mil  with ESMTP id i08E9106008339 for <selinux@tycho.nsa.gov>; Thu, 8 Jan 2004 14:09:02 GMT
Subject: Re: post_create:  setxattr failed, rc=122 (dev=09:03 ino=992086)
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Russell Coker <russell@coker.com.au>
Cc: SE Linux <selinux@tycho.nsa.gov>, Stephen Tweedie <sct@redhat.com>
In-Reply-To: <200401080958.42958.russell@coker.com.au>
References: <200401080958.42958.russell@coker.com.au>
Content-Type: text/plain
Message-Id: <1073570910.28727.34.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Thu, 08 Jan 2004 09:08:30 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2004-01-07 at 17:58, Russell Coker wrote:
> What is the meaning of the above error?

errno 122 == EDQUOT, quota exceeded.  So SELinux was unable to set the
attribute value on a newly created file because of a quota restriction
on the creating process.  So the inode on disk is left unlabeled,
although the SID on the incore inode will be set correctly.  Not clear
that MAC labels should count against quotas, although a failure at the
same point would still be possible due to other reasons, e.g. no free
space on the filesystem or an I/O error when trying to write the
attribute value. 

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
