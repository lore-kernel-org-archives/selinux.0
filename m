Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id IAA14240
	for <selinux@tycho.nsa.gov>; Mon, 27 Jan 2003 08:13:32 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id NAA15749
	for <selinux@tycho.nsa.gov>; Mon, 27 Jan 2003 13:10:34 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id NAA15745
	for <selinux@tycho.nsa.gov>; Mon, 27 Jan 2003 13:10:33 GMT
Message-Id: <200301271320.IAA05862@moss-shockers.ncsc.mil>
Date: Mon, 27 Jan 2003 08:20:51 -0500 (EST)
From: "Stephen D. Smalley" <sds@epoch.ncsc.mil>
Reply-To: "Stephen D. Smalley" <sds@epoch.ncsc.mil>
Subject: Re: tmpfs_t
To: selinux@tycho.nsa.gov, russell@coker.com.au
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> I have been looking into using tmpfs as /tmp .
> 
> Currently tmpfs is labeled tmpfs_t and there is no policy for allowing file 
> creation under it.  So I have experimented with labelling it as tmp_t and 
> changing the tmp_domain() macro to have the following rule:
> allow $1_tmp_t tmp_t:filesystem associate;
> 
> To do this properly I would also have to change every
> allow whatever fs_t:filesystem getattr;
> to:
> allow whatever { fs_t tmp_t }:filesystem getattr;
> 
> Or should I instead leave the tmpfs filesystem labelled as tmpfs_t and add 
> appropriate file_type_auto_trans() rules for it?

The problem is that tmpfs is also used for the kernel internal mount
for System V shared memory and shared anonymous mappings.  The current
fs_use configuration and the existing $1_tmpfs_t types and rules are
oriented toward that usage of tmpfs.  Distinguishing different instances
of tmpfs mounts and providing different labeling behaviors and contexts
for those different instances would require further changes to SELinux. 

--
Stephen Smalley, NSA
sds@epoch.ncsc.mil


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
