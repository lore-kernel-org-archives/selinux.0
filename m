Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i76B47rT011223
	for <selinux@tycho.nsa.gov>; Fri, 6 Aug 2004 07:04:07 -0400 (EDT)
Received: from mail.c-sam.net (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i76B46O0017854
	for <selinux@tycho.nsa.gov>; Fri, 6 Aug 2004 11:04:06 GMT
Date: Fri, 6 Aug 2004 12:56:15 +0200
From: Andreas Schuldei <andreas@schuldei.org>
To: Russell Coker <rcoker@redhat.com>
Cc: Andreas Schuldei <andreas@schuldei.org>, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: problems with selinux-policy-default 1:1.14-2
Message-ID: <20040806105615.GB3510@lukas.schuldei.com>
References: <20040803233114.GQ1828@markus.schuldei.org> <200408062015.33606.rcoker@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200408062015.33606.rcoker@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

* Russell Coker (rcoker@redhat.com) [040806 12:16]:
> On Wed, 4 Aug 2004 09:31, Andreas Schuldei <andreas@schuldei.org> wrote:
> > lrwxrwxrwx    1 root     root           33 Aug  4 00:57 src ->
> > /usr/share/selinux/policy/current petrus:~# l /usr/share/selinux/policy
> > total 12
> > drwxr-xr-x    3 root     root         4096 Aug  4 00:57 .
> > drwxr-xr-x    3 root     root         4096 Aug  4 00:57 ..
> > drwxr-xr-x    9 root     root         4096 Aug  4 00:57 default
> > ==========================
> >
> > src is a dangeling symlink.
> 
> What happened to the current directory?

i didnt do anything with it. my guess is that it is generated
later during the configuration of the file.

i might attempt to selinux-ize my notebook, i can investigate
more closely then.

> > changing it to point to /usr/share/selinux/policy/default
> 
> Don't do that.  If you do that the upgrading the policy will automatically 
> over-write changes that you have made to your policy.

i changed the symlink back once the current directory was created
and populated. you surely know your installprocess better then i
do. perhaps you could investigate?

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
