Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iB21kXIi029001
	for <selinux@tycho.nsa.gov>; Wed, 1 Dec 2004 20:46:34 -0500 (EST)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id iB21iuYO015964
	for <selinux@tycho.nsa.gov>; Thu, 2 Dec 2004 01:44:58 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "Christopher R. Hertel" <crh@ubiqx.mn.org>
Subject: Re: dynamic context transitions
Date: Thu, 2 Dec 2004 12:46:13 +1100
Cc: Simo Sorce <idra@samba.org>, Andrew Bartlett <abartlet@samba.org>,
   Darrel Goeddel <dgoeddel@TrustedCS.com>, James Morris <jmorris@redhat.com>,
   Chad Hanson <chanson@TrustedCS.com>, Stephen Smalley <sds@epoch.ncsc.mil>,
   Multiple recipients of list SAMBA-TECHNICAL <samba-technical@samba.org>,
   tng-technical@samba-tng.org, SE-Linux <selinux@tycho.nsa.gov>
References: <418662EE.5090001@trustedcs.com> <20041114215428.GP5031@lkcl.net> <20041201231224.GD5862@Favog.ubiqx.mn.org>
In-Reply-To: <20041201231224.GD5862@Favog.ubiqx.mn.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200412021246.23614.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thursday 02 December 2004 10:12, "Christopher R. Hertel" <crh@ubiqx.mn.org> 
wrote:
> I've been asking about this in different places.  I've heard theories,
> mostly.  This is happening in Linux (dunno if it's been tested elsewhere)
> and one theory is that the forked process speeds are good because Linux
> basically does a really good job with those.  Meanwhile, thread speed is
> bad because the multiple threads are all within a single process and the
> single process gets only it's own share of processor time.

I believe that in Linux with the NPTL each thread gets scheduled independently 
by default.  Also if the threads were scheduled together then that would only 
cause problems if there were other programs using CPU time, in the case of a 
server running only a multi-threaded daemon it should not cause any problems.

> I don't know much about thread handling on Linux, but I would also imagine
> that there is a bit of an impact on all threads when one thread makes a
> system call.

For thread libraries that have application code implementing threads on top of 
a non-threaded libc or kernel (Green Threads for Java and every Ada runtime 
for DOS are the two best examples that I can think of) then a blocking system 
call in one thread will block all the other threads.

One problem with threads is that certain libc calls use locking when linked in 
a multi-threaded manner.  In version 1.9x of my Bonnie++ benchmark suite I 
have a test program called getc_putc to test this.  On older versions of 
glibc the performance difference between non-threaded and threaded versions 
of a program when calling getc() and putc() was significant.  Now it seems 
that there's hardly any difference.  I suspect that because of these changes 
to glibc and other changes that presumably accompanied them the difference 
betwen threaded and non-threaded programs for such things is much less than 
it used to be.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
