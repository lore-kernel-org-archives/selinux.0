Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iA35pgXZ012693
	for <selinux@tycho.nsa.gov>; Wed, 3 Nov 2004 00:51:42 -0500 (EST)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id iA35oJ4w025929
	for <selinux@tycho.nsa.gov>; Wed, 3 Nov 2004 05:50:20 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Daniel J Walsh <dwalsh@redhat.com>
Subject: Re: Patch to make can_network stronger and remove nscd tunable.
Date: Wed, 3 Nov 2004 16:23:36 +1100
Cc: jwcart2@epoch.ncsc.mil, SELinux <selinux@tycho.nsa.gov>
References: <20041018124332.GA5193@hydrogenium.cip.ifi.lmu.de> <200411030248.49998.russell@coker.com.au> <4187ADEF.5030803@redhat.com>
In-Reply-To: <4187ADEF.5030803@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200411031623.36309.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wednesday 03 November 2004 02:55, Daniel J Walsh <dwalsh@redhat.com> wrote:
> >Then we should have two macros, one that allows outbound connections and
> > one that doesn't.  Increasing the line count in most domains that have
> > network access does no good.
>
> I wanted to treat connect the same way we treat name_bind.  Basically
> you need to explicitly state whether a network daemon is inbout,
> outbound or both.  If we want to add all the macros fine, but having
> can_network default to allowing connect is too loose, think of spammers.

We have to have more macros.  There is no reason for not having all network 
access for a process in a single line in a .te file.  Having multiple lines 
for this makes it more difficult to read and gives more errors.

The question is, do we have can_network() do what it has always done, or do we 
have the new macro give the current functionality of can_network() and have 
can_network() not permit connections.

We don't want to apply a change to all the .te files related to can_network() 
until we resolve this issue.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
