Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h8AJcuLa011549
	for <selinux@tycho.nsa.gov>; Wed, 10 Sep 2003 15:38:56 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h8AJctmw026023
	for <selinux@tycho.nsa.gov>; Wed, 10 Sep 2003 19:38:55 GMT
Received: from chris.pebenito.dhs.org (12-251-184-225.client.attbi.com [12.251.184.225])
        by jazzband.ncsc.mil  with ESMTP id h8AJct9d026017 for <selinux@tycho.nsa.gov>; Wed, 10 Sep 2003 19:38:55 GMT
Subject: Re: rfs xattr's, mkinitrd and other stories
From: Chris PeBenito <pebenito@gentoo.org>
To: Dale Amon <amon@vnl.com>, Stephen Smalley <sds@epoch.ncsc.mil>
Cc: SELinux Mail List <selinux@tycho.nsa.gov>
In-Reply-To: <20030910191015.GQ5397@vnl.com>
References: <20030910164854.GO5397@vnl.com>
	 <1063220599.29764.6.camel@chris.pebenito.net>
	 <20030910191015.GQ5397@vnl.com>
Content-Type: text/plain
Message-Id: <1063222733.29765.19.camel@chris.pebenito.net>
Mime-Version: 1.0
Date: Wed, 10 Sep 2003 14:38:54 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2003-09-10 at 14:10, Dale Amon wrote:
> Hmmm... I shouldn't think it should be too hard to do that,
> assuming the format of handlers is similar. The 2.6 one was
> pretty straight forward.
> 
> I'll take a look. Supper first though :-)

On Wed, 2003-09-10 at 14:11, Stephen Smalley wrote: 
> You should just be able to copy the trusted handler and tweak it
> slightly for the "security." namespace.

This afternoon, I tried using the 2.6 handlers to no avail.  I also
tried copying the trusted one a while back (yes, I remembered to change
the prefix), and removing the capability check, and they all resulted
the same way.  

If you ls --context, it came up null for the context, and if you do a
touch, the process hangs.  I have the appropriate change in super.c and
reiserfs_xattr.h.  I also adjusted the reiserfs_fs_sb.h, as theres a
mention by the trusted handler of making the xattrs 'always on', so I
made sure the xattrs are always on for the security labels too.  I think
there is just some little bit that I'm overlooking.

-- 
Chris PeBenito
<pebenito@gentoo.org>
Developer, SELinux
Hardened Gentoo Linux
 
Public Key: http://pgp.mit.edu:11371/pks/lookup?op=get&search=0xE6AF9243
Key fingerprint = B0E6 877A 883F A57A 8E6A  CB00 BC8E E42D E6AF 9243

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
