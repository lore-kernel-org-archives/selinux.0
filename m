Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iA3JXSXZ017696
	for <selinux@tycho.nsa.gov>; Wed, 3 Nov 2004 14:33:28 -0500 (EST)
Received: from epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id iA3JW64w005835
	for <selinux@tycho.nsa.gov>; Wed, 3 Nov 2004 19:32:06 GMT
Subject: Re: learning about policies/transitions
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Serge Hallyn <serge.hallyn@gmail.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <46ce702f041103084530fe8539@mail.gmail.com>
References: <46ce702f041103084530fe8539@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1099510181.1213.198.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Wed, 03 Nov 2004 14:29:41 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2004-11-03 at 11:45, Serge Hallyn wrote:
> With my basic policy, though, boot_d will not transition to login_d
> on execution of /bin/login.  ls -Z /bin/login shows that it is labeled
> as login_et.  Since logging in doesn't work, I test by booting single
> user mode, and running
> 
> ps -Z
> [everything is running under boot_d]
> /bin/login & ps -Z
> [login is running under boot_d]
> 
> What am I missing in the policy that would enable this automatic
> domain transition to happen?

Your policy looks sufficient for that purpose, although there are some
oddities in it (e.g. you shouldn't be authorizing system_r for object
types, you should be using object_r in file contexts, a file descriptor
is not labeled with a file type).  A possible explanation would be an
inconsistency between the on-disk xattr and the incore inode SID, e.g.
type wasn't defined at the time that the inode was attached to a
dentry.  Try setfilecon system_u:object_r:login_et /bin/login and then
re-trying.  setfiles and chcon tend to not bother setting the context if
it already appears to be correct, but they only can see the on-disk
xattr via the xattr API, not the incore inode context. 

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
