Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i08ER3Rb021621
	for <selinux@tycho.nsa.gov>; Thu, 8 Jan 2004 09:27:03 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i08EPwxr000641
	for <selinux@tycho.nsa.gov>; Thu, 8 Jan 2004 14:25:59 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id i08EPwYc000638
	for <selinux@tycho.nsa.gov>; Thu, 8 Jan 2004 14:25:58 GMT
Subject: Re: post_create:  setxattr failed, rc=122 (dev=09:03 ino=992086)
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Russell Coker <russell@coker.com.au>
Cc: SE Linux <selinux@tycho.nsa.gov>, Stephen Tweedie <sct@redhat.com>
In-Reply-To: <200401090115.41415.russell@coker.com.au>
References: <200401080958.42958.russell@coker.com.au>
	 <1073570910.28727.34.camel@moss-spartans.epoch.ncsc.mil>
	 <200401090115.41415.russell@coker.com.au>
Content-Type: text/plain
Message-Id: <1073572011.28727.50.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Thu, 08 Jan 2004 09:26:51 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2004-01-08 at 09:15, Russell Coker wrote:
> Can this be changed?  I think that ideally the quota would not be counted for 
> file creation.  But it may be an easier solution for the creation corner 
> cases to have the creat() fail if the label can not be applied.

The post_create hook has no way to abort the create at present, and it
would have to unlink the file as it has already been created at that
point.  Filesystem support for atomic create+setxattr would be nice, but
not likely at this point. 

> What would happen to the file in question?  "find" does not report any file 
> with that Inode in the file system, do I assume that the creating process 
> detected the error about being unable to write any data to the file and then 
> unlinked the zero byte file while the Inode was still in-core?

Probably.  Given that the contexts are small, the program likely failed
upon attempts to write data to the file due to the same quota
restriction and unlinked the file as part of its own cleanup.  If the
program did not unlink it, then the file would stay around, continuing
to be treated as if it has the right SID as long as the inode remained
incore, but reverting to the 'file' SID, i.e. file_t type, if the inode
were evicted and then re-read subsequently or upon a reboot.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
