Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h8AGmvLa010091
	for <selinux@tycho.nsa.gov>; Wed, 10 Sep 2003 12:48:57 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h8AGmumw012961
	for <selinux@tycho.nsa.gov>; Wed, 10 Sep 2003 16:48:56 GMT
Received: from crisium.vnl.com (crisium.vnl.com [194.46.8.33])
        by jazzband.ncsc.mil  with ESMTP id h8AGmt9d012958 for <selinux@tycho.nsa.gov>; Wed, 10 Sep 2003 16:48:55 GMT
Date: Wed, 10 Sep 2003 17:48:54 +0100
From: Dale Amon <amon@vnl.com>
To: SELinux Mail List <selinux@tycho.nsa.gov>
Subject: rfs xattr's, mkinitrd and other stories
Message-ID: <20030910164854.GO5397@vnl.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

If anyone is interested, I've worked with Jeff Mahoney 
and Steve Smalley and between us we've got what should
be the necessary patches for using selinux with
reiserfs on 2.6.0 kernels. They are availabe here and
possibly on the Suse site by now:

 http://www.unixthugs.org/~jeffm/technical/reiserfs/aclea/2.6.0-test4/

So I'm on to the next phase of getting a debian 
system working with 2.6.0 (with devfs and a 
reiserfs root)

I've got to sort out the initrd next. I've not needed
it before so I'm on a cold start. First question is
how to do the least damage to the debian setup. If I
just replace /usr/sbin/mkinitrd, it is going to get
overwritten the next time I do an upgrade.

Secondly, all of the examples I find are somewhat
different. Steve's patch in the HOWTO is for a
very different looking RH file so it's hard to
tell what he actually needs. Colin's July 17 looks
reasonable and I'll probably start with that... but
I am worried about the issues with debian packages.

Colin? Russ? What approach do you suggest?

BTW: I'm using Colin's policy default with a few
fixes to let syslog-ng work. Russell's set is too
divergent from Colin's for me to use it unless they've
synced up recently.

-- 
------------------------------------------------------
       IN MY NAME:            Dale Amon, CEO/MD
  No Mushroom clouds over     Islandone Society
    London and New York.      www.islandone.org
------------------------------------------------------

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
