Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h8AJh8La011612
	for <selinux@tycho.nsa.gov>; Wed, 10 Sep 2003 15:43:08 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h8AJfULa029246
	for <selinux@tycho.nsa.gov>; Wed, 10 Sep 2003 19:41:31 GMT
Date: Wed, 10 Sep 2003 20:43:04 +0100
From: Dale Amon <amon@vnl.com>
To: Chris PeBenito <pebenito@gentoo.org>
Cc: Dale Amon <amon@vnl.com>, Stephen Smalley <sds@epoch.ncsc.mil>,
   SELinux Mail List <selinux@tycho.nsa.gov>
Subject: Re: rfs xattr's, mkinitrd and other stories
Message-ID: <20030910194304.GS5397@vnl.com>
References: <20030910164854.GO5397@vnl.com> <1063220599.29764.6.camel@chris.pebenito.net> <20030910191015.GQ5397@vnl.com> <1063222733.29765.19.camel@chris.pebenito.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1063222733.29765.19.camel@chris.pebenito.net>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, Sep 10, 2003 at 02:38:54PM -0500, Chris PeBenito wrote:
> If you ls --context, it came up null for the context, and if you do a
> touch, the process hangs.  I have the appropriate change in super.c and
> reiserfs_xattr.h.  I also adjusted the reiserfs_fs_sb.h, as theres a
> mention by the trusted handler of making the xattrs 'always on', so I
> made sure the xattrs are always on for the security labels too.  I think
> there is just some little bit that I'm overlooking.

Hmmm... Keep in mind that this code, while simple and while eyeballed
by three people, has not been well tested even on 2.6. I do not
consider it out of the question that there is an error. 

I'm still in the alligator pit with 2.6 and Steve just chucked
another one in on me :-)

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
