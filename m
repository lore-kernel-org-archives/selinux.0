Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i67IIOrT007779
	for <selinux@tycho.nsa.gov>; Wed, 7 Jul 2004 14:18:24 -0400 (EDT)
Received: from epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i67II6Cu024136
	for <selinux@tycho.nsa.gov>; Wed, 7 Jul 2004 18:18:06 GMT
Subject: Re: cifs_t
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Russell Coker <russell@coker.com.au>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <200407052352.53439.russell@coker.com.au>
References: <200407052352.53439.russell@coker.com.au>
Content-Type: text/plain
Message-Id: <1089224292.1774.160.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Wed, 07 Jul 2004 14:18:12 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2004-07-05 at 09:52, Russell Coker wrote:
> typealias sambafs_t alias cifs_t;
> 
> What is the benefit of the above?
> 
> If we are going to make cifs_t the new name for what is currently sambafs_t 
> then surely the correct thing to do is to change the declaration of sambafs_t 
> to cifs_t and use the following typealias:
> 
> typealias cifs_t alias sambafs_t;

Looking at the CVS tree, it appears that it was changed from cifs_t to
sambafs_t on 5/4/2004, as part of a merge of a policy diff from Fedora. 
cifs_t was retained as an alias for compatibility, IIRC.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
