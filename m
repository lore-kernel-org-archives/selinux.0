Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i8MJBXrT004226
	for <selinux@tycho.nsa.gov>; Wed, 22 Sep 2004 15:11:33 -0400 (EDT)
Received: from open.hands.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i8MJBWWF022441
	for <selinux@tycho.nsa.gov>; Wed, 22 Sep 2004 19:11:32 GMT
Date: Wed, 22 Sep 2004 20:22:25 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Russell Coker <russell@coker.com.au>
Cc: SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: fuse
Message-ID: <20040922192225.GE7308@lkcl.net>
References: <20040922005509.GD14303@lkcl.net> <200409230424.55524.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200409230424.55524.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, Sep 23, 2004 at 04:24:55AM +1000, Russell Coker wrote:
> On Wed, 22 Sep 2004 10:55, Luke Kenneth Casson Leighton <lkcl@lkcl.net> wrote:
> > has anyone thought about how fuse (file system in userspace) would fit
> > in with selinux?
> 
> In what way would it be different from any other file system?
 
 oh, sorry, i should have said: fscontext, that sort of thing.

 because it doesn't look like there's a way to pass fscontext
 arguments to the fuse module, and it uses man 2 mount() which
 doesn't take any arguments (except some flags, nothing that
 looks remotely like it could be used to pass an fscontext=),
 only the source and destination of the mount point
 (source = /proc/fs/fuse/dev, dest = /yourmountpoint).


> Naturally you would need appropriate policy for the proxy program, but that 
> should not be difficult to write.

 i'm looking forward to it :)

-- 
--
Truth, honesty and respect are rare commodities that all spring from
the same well: Love.  If you love yourself and everyone and everything
around you, funnily and coincidentally enough, life gets a lot better.
--
<a href="http://lkcl.net">      lkcl.net      </a> <br />
<a href="mailto:lkcl@lkcl.net"> lkcl@lkcl.net </a> <br />


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
