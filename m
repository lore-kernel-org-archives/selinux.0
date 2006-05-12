Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k4CMV3aF021769
	for <selinux@tycho.nsa.gov>; Fri, 12 May 2006 18:31:04 -0400
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k4CMV06C013014
	for <selinux@tycho.nsa.gov>; Fri, 12 May 2006 22:31:01 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Ram Pai <linuxram@us.ibm.com>
Subject: Re: [Fwd: [PATCH 1/1] mount: shared-subtree support for mount]
Date: Sat, 13 May 2006 08:30:59 +1000
Cc: Janak Desai <janak@us.ibm.com>, SE-Linux <selinux@tycho.nsa.gov>
References: <4460A6DA.1040407@us.ibm.com> <44648700.5070002@us.ibm.com> <1147454688.4961.28.camel@localhost>
In-Reply-To: <1147454688.4961.28.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200605130831.02969.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Saturday 13 May 2006 03:24, Ram Pai <linuxram@us.ibm.com> wrote:
> > >I just built mount with that patch and tried it out but it doesn't seem
> > > to work.  I run the following command from root login:
> > >mount --make-private --bind /tmp/tmp.inst-user-user /tmp
> > >
> > >Then when I inspect /tmp from other sessions it seems that the change is
> > >global.
> > >
> > >Does the rawhide kernel 2.6.16-1.2196_FC6 lack support for this or did I
> > > get the command-line wrong?
>
> What is being attempted to accomplish?

The attempt is to have a poly-instantiated version of /tmp where every user 
sees a different version.

> Are u trying to bind /tmp/tmp.inst-user-user to /tmp
> as well as make both of them private?

I want to make the bind mount private and have everything else shared.

> I would make the bind call first and than
> in a separate command  will make the mounts private.

That would not be viable for real use as it has a race condition.

mount --bind /tmp/tmp.inst-user-user /tmp
mount --make-private /tmp

I tried the above commands, but the result was the same.  Even though mount 
returned 0 as the exit code and displayed no error message the --make-private 
command seemed to have no effect.  The result was that /tmp was replaced for 
everyone.

> But in any case I dont know what is being attempted to
> accomplish?  Is /tmp/tmp.inst-user-user has a mount which is already
> shared?

/tmp/tmp.inst-user-user is a subdirectory of /tmp.

> --make-private makes the mount private. It does not mean the contents of
> the mounts at /tmp/tmp.inst-user-user and /tmp will be different. They
> will continue to be same.

What does making the mount private mean if it doesn't prevent it from being 
seen by other sessions?

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
