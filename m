Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id IAA07574
	for <selinux@tycho.nsa.gov>; Wed, 19 Jun 2002 08:26:51 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id MAA07572
	for <selinux@tycho.nsa.gov>; Wed, 19 Jun 2002 12:26:27 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id MAA07568
	for <selinux@tycho.nsa.gov>; Wed, 19 Jun 2002 12:26:26 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Stephen Smalley <sds@tislabs.com>
Subject: Re: new policy changes
Date: Wed, 19 Jun 2002 14:26:36 +0200
References: <Pine.GSO.4.33.0206190801120.17899-100000@raven>
In-Reply-To: <Pine.GSO.4.33.0206190801120.17899-100000@raven>
Cc: SE Linux <selinux@tycho.nsa.gov>
MIME-Version: 1.0
Message-Id: <20020619122636.F3AA61C9F@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 19 Jun 2002 14:06, you wrote:
> On Wed, 19 Jun 2002, Russell Coker wrote:
> > /dev/nvram (/dev/misc/nvram) needs a context, I've given it
> > memory_device_t for the moment.
> >
> > Some of the users on my play box discovered this and wrote some random
> > data to it.  They expressed the option that it won't complete it's next
> > boot (I'm now discussing the matter with the hardware vendor).
>
> I'm not sure I follow your statement.  If /dev/nvram (which doesn't exist
> on my systems) lacks a specific context, it should default to device_t
> (normal /dev) or devfs_t (devfs), right?  And no domain has write access
> to chr_file or blk_file files with device_t or devfs_t, right?  So how did
> they write to the device?

Actually on my system it defaults to devfs_t which is the same as all the 
/dev/pts/* files (due to the problems with devpts labelling on devfs).  So I 
enabled writing to devfs_t character devices...

-- 
I do not get viruses because I do not use MS software.
If you use Outlook then please do not put my email address in your
address-book so that WHEN you get a virus it won't use my address in the
>From field.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
