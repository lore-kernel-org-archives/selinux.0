Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7PNpwrT009958
	for <selinux@tycho.nsa.gov>; Wed, 25 Aug 2004 19:51:59 -0400 (EDT)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i7PNp9LV007436
	for <selinux@tycho.nsa.gov>; Wed, 25 Aug 2004 23:51:11 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Subject: Re: policy patch for tunable "/dev/hdc is removable drive"
Date: Thu, 26 Aug 2004 09:51:48 +1000
Cc: SE-Linux <selinux@tycho.nsa.gov>
References: <20040823214228.GA13677@lkcl.net> <200408252357.08855.russell@coker.com.au> <20040825162035.GA7260@lkcl.net>
In-Reply-To: <20040825162035.GA7260@lkcl.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200408260951.48939.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 26 Aug 2004 02:20, Luke Kenneth Casson Leighton <lkcl@lkcl.net> wrote:
> > udev uses the same file_contexts file, so it should work.  The only
> > possible problem I can think of is that if you have a machine which boots
> > without IDE disk access and which has no IDE modules loaded at the time
> > that it has the file_contexts file generated then this would not work
> > (think of servers that have IDE CD-ROM or DVD drives but hardware RAID or
> > SCSI for main storage).
> >
> > Of course this is not necessarily a problem, Fedora kernels have the IDE
> > drivers statically linked into the kernel, and there were some issues
> > last time I tried building a Debian kernel with IDE as a module so the
> > number of people who might get hit by this is very small.
>
>  ... initrd.  initial ramdisk.  contains all ide drivers, 'n'stuff.

Last time I was doing this there were some kernel bugs related to IDE drivers.  
One of which was having two drivers which need symbols that the other exports 
(so it was impossible to load them).  At the time almost no testing was being 
done on this and it didn't seem that the problem was going to be fixed in a 
reasonable amount of time.

I gave up using an initrd in Debian at about the same time.  The problem was 
that the Debian mkinitrd program tried to work out too many things about the 
system by itself.  This made it difficult if it's guesses were wrong, or if 
you wanted to prepare an initrd for a different configuration (either for a 
significant configuration change or making an initrd for use on another 
machine).

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
