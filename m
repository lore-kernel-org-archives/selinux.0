Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h8AMZDLa012481
	for <selinux@tycho.nsa.gov>; Wed, 10 Sep 2003 18:35:14 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h8AMZCmw007979
	for <selinux@tycho.nsa.gov>; Wed, 10 Sep 2003 22:35:12 GMT
Received: from monk.verbum.org (monk.debian.net [216.226.142.128])
        by jazzband.ncsc.mil  with ESMTP id h8AMZB9d007970 for <selinux@tycho.nsa.gov>; Wed, 10 Sep 2003 22:35:12 GMT
Subject: Re: rfs xattr's, mkinitrd and other stories
From: Colin Walters <walters@verbum.org>
To: Dale Amon <amon@vnl.com>
Cc: SELinux Mail List <selinux@tycho.nsa.gov>
In-Reply-To: <20030910164854.GO5397@vnl.com>
References: <20030910164854.GO5397@vnl.com>
Content-Type: text/plain
Message-Id: <1063233012.27358.11.camel@columbia>
Mime-Version: 1.0
Date: Wed, 10 Sep 2003 18:30:12 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2003-09-10 at 12:48, Dale Amon wrote:

> I've got to sort out the initrd next. I've not needed
> it before so I'm on a cold start. First question is
> how to do the least damage to the debian setup. If I
> just replace /usr/sbin/mkinitrd, it is going to get
> overwritten the next time I do an upgrade.

That shouldn't be necessary if you're using the Debian mkinitrd scripts
I wrote.  It has hooks for dropping things in like this.

> Secondly, all of the examples I find are somewhat
> different. Steve's patch in the HOWTO is for a
> very different looking RH file so it's hard to
> tell what he actually needs. Colin's July 17 looks
> reasonable and I'll probably start with that... but
> I am worried about the issues with debian packages.

You shouldn't have to change anything at all, just install
selinux-policy-default.  I noticed there have been a few revisions to
mkinitrd in unstable since then, but last I checked it worked.

> Colin? Russ? What approach do you suggest?
> 
> BTW: I'm using Colin's policy default with a few
> fixes to let syslog-ng work. Russell's set is too
> divergent from Colin's for me to use it unless they've
> synced up recently.

I really need to find some time to do that.  Real life and other
projects have kind of been in the way, but I do hope to do it within a
week or so.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
