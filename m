Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id DAA13267
	for <selinux@tycho.nsa.gov>; Mon, 27 Jan 2003 03:57:03 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h0R8v2I23123
	for <selinux@tycho.nsa.gov>; Mon, 27 Jan 2003 08:57:02 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
        by jazzband.ncsc.mil  with ESMTP id h0R8v1f23118 for <selinux@tycho.nsa.gov>; Mon, 27 Jan 2003 08:57:01 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Jakob Oestergaard <jakob@unthought.net>
Subject: Re: box is back
Date: Mon, 27 Jan 2003 09:56:52 +0100
Cc: selinux@tycho.nsa.gov
References: <200301211359.35581.russell@coker.com.au> <20030127005630.GA14156@unthought.net>
In-Reply-To: <20030127005630.GA14156@unthought.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200301270956.52956.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 27 Jan 2003 01:56, Jakob Oestergaard wrote:
> On Tue, Jan 21, 2003 at 01:59:35PM +0100, Russell Coker wrote:
> > I have a new SE Linux play machine online.
> > ssh -p 222 root@adsl.coker.com.au
> > Password "1234"
>
> And thanks for putting the box up, for us newbies to toy with  ;)
>
> Two (minor, allright) things that caught my attention;
> 1) One can see dmesg, when in the user_r role. This means, I can see
>    what everyone else tried and did - which may (?) in turn reveil
>    information about which files exist in places I'm not supposed to
>    know about.

True.  You don't want to run a production server in this fashion.  However for 
learning purposes it's best to show such things so that you know why your 
actions were denied.

> 2) One can see all PIDs in /proc
>    Yes, it's not possible to look further than that - but it still gives
>    valuable information (such as, how much logging is this box likely to
>    run - by looking at which low-numbered PIDs exist).  It's a fairly
>    high bandwidth covert channel as well, but I guess that's not really
>    a concern for the moment  ;)

The SE project is not concerned with covert channels, if you search the NSA 
web site enough I think you'll find an official statement to this effect.

As for showing the existance of pids via "ls /proc", this is because read 
access is granted to the /proc (proc_t) directory to allow "ps ax" to show 
your processes.  SE Linux has no facilities to change readdir() in any way, 
it can only permit or deny the action on a particular directory.  This is 
probably one of the most requested features in SE Linux.  However there are 
issues.  With the design of SE Linux we don't want special case code for 
/proc (as OpenWall does).  Having this code for other directories such as 
/tmp brings issues such as the fact that if you suspect /tmp/abc exists then 
a simple creat("/tmp/abc", ...) will verify that fact, doing this properly 
would probably require multiple views of directories.

Multiple views has been discussed in the past, Steve, are there any current 
plans for implementing it?

> I don't know if any of this is a concern - I think the dmesg one is the
> serious one (if I'm not completely mistaken about it).

If you want a seriously secure SE Linux machine then you will run it with more 
default settings, so dmesg will be for sysadm_t only and you will have a 
different Unix UID for each user.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
