Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i6P0I3rT018357
	for <selinux@tycho.nsa.gov>; Sat, 24 Jul 2004 20:18:03 -0400 (EDT)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i6P0HXUX001693
	for <selinux@tycho.nsa.gov>; Sun, 25 Jul 2004 00:17:34 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Subject: Re: [idea] multiple contexts.
Date: Sun, 25 Jul 2004 10:17:49 +1000
Cc: SE-Linux <selinux@tycho.nsa.gov>
References: <20040724231154.GE3437@lkcl.net>
In-Reply-To: <20040724231154.GE3437@lkcl.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200407251017.49201.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 25 Jul 2004 09:11, Luke Kenneth Casson Leighton <lkcl@lkcl.net> wrote:
> note the plus sign: this means "whenever a user executes the executable
> program kdeinit, then instead of transitioning TO the kde_user_t
> context, they get an EXTRA context kde_user_t".

Nothing that you could do with kdeinit will give a good result.

kdeinit is a hack to avoid the time taken for loading shared objects (less 
than 1 second of CPU time on a P3-650).  Like most hacks it causes problems 
for other things, in this case for security systems of which SE Linux is only 
one example.

If you get a 1GHz machine (one of those cheap new VIA systems or a cheap 
second-hand system) then you probably won't mind the small extra overhead of 
loading shared objects.  Also removing the kdeinit hack will probably avoid 
most of the problems of KDE acting weird when you upgrade your system while 
still logged in.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
