Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id NAA21722
	for <selinux@tycho.nsa.gov>; Tue, 29 Oct 2002 13:51:13 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id SAA04218
	for <selinux@tycho.nsa.gov>; Tue, 29 Oct 2002 18:49:17 GMT
Received: from unicorn.lemuria.org (b067018.adsl.hansenet.de [62.109.67.18])
        by jazzband.ncsc.mil  with ESMTP id SAA04210 for <selinux@tycho.nsa.gov>; Tue, 29 Oct 2002 18:49:16 GMT
Date: Tue, 29 Oct 2002 19:50:22 +0100
From: Tom <tom@lemuria.org>
To: selinux@tycho.nsa.gov
Subject: Re: New Apache policy
Message-ID: <20021029195021.A16063@lemuria.org>
References: <20021029173606.A28387@lemuria.org> <Pine.GSO.4.33.0210291146020.29605-100000@raven> <20021029184539.A16049@lemuria.org> <200210291937.10550.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200210291937.10550.russell@coker.com.au>; from russell@coker.com.au on Tue, Oct 29, 2002 at 07:37:10PM +0100
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, Oct 29, 2002 at 07:37:10PM +0100, Russell Coker wrote:
> I suggest that you contact the Subversion developers and ask their opinion on 
> what the security policy should be.  Of course we won't necessarily accept 
> what they say, but it will be useful to get some input from them.

That is a good idea, I will try it.


> > Also, I may think about restricting _local_ access for these tools,
> > because they are connecting outwards to potentially hacked and/or
> > malicious servers.
> 
> True.  Of course if you download, compile, and run code from a potentially 
> hacked server then an exploit of a Subversion bug is the least of your 
> worries...

Yes, but you might either not intend to run it (it may not even be
something executable, I keep documentation in CVS, for example) or 
you may execute it in a chroot or other restricted environment (simply 
labeling the resulting binary with some special bin_untrusted_t might 
be what you prefer).

One way or the other, this is the larger question of how to deal with
foreign executables and for now I'd like to leave that to the local 
sysadmin. He may already have a good policy in place.


-- 
http://web.lemuria.org/pubkey.html
pub  1024D/2D7A04F5 2002-05-16 Tom Vogt <tom@lemuria.org>
     Key fingerprint = C731 64D1 4BCF 4C20 48A4  29B2 BF01 9FA1 2D7A 04F5

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
