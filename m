Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i83DtdrT007553
	for <selinux@tycho.nsa.gov>; Fri, 3 Sep 2004 09:55:39 -0400 (EDT)
Received: from epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i83DsnFY009187
	for <selinux@tycho.nsa.gov>; Fri, 3 Sep 2004 13:54:49 GMT
Subject: Re: reiferfs in SUSE9.1
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Yuichi Nakamura <himainu-ynakam@miomio.jp>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <200409031338.i83DccKp019984@mms-r01.iijmio.jp>
References: <200409031338.i83DccKp019984@mms-r01.iijmio.jp>
Content-Type: text/plain
Message-Id: <1094219636.19206.135.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Fri, 03 Sep 2004 09:53:56 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2004-09-03 at 09:38, Yuichi Nakamura wrote:
> Some people in Japan(including me) say that they can not use reiserfs in SUSE9.1(selinux enabled).
> 
> In fs_use, we added the following.
> fs_use_xattr reiserfs system_u:object_r:fs_t.
> 
> System boot succeeds but hangs up in init scripts.
> # I forget correct place,sorry because I do not have the environment now...
> 
> We can use SELinux in SUSE9.1 with ext3 filesystem.
> 
> Does anyone use reiserfs in SUSE9.1?

reiserfs is known to not work with SELinux.  There is a deadlock in the
reiserfs xattr code when interacting with SELinux, and there is no way
presently for reiserfs to inform SELinux that it shouldn't try to
mediate access to the internal directories and files used to store the
xattrs.  reiserfs maintainers know about the issues, but not clear that
they care...

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
