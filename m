Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id BAA05154
	for <selinux@tycho.nsa.gov>; Fri, 13 Sep 2002 01:36:05 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id FAA04605
	for <selinux@tycho.nsa.gov>; Fri, 13 Sep 2002 05:34:20 GMT
Received: from unicorn.lemuria.org (b116024.adsl.hansenet.de [62.109.116.24])
        by jazzband.ncsc.mil  with ESMTP id FAA04601 for <selinux@tycho.nsa.gov>; Fri, 13 Sep 2002 05:34:19 GMT
Date: Fri, 13 Sep 2002 07:35:53 +0200
From: Tom <tom@lemuria.org>
To: Russell Coker <russell@coker.com.au>
Cc: selinux@tycho.nsa.gov
Subject: Re: uml policy
Message-ID: <20020913073553.D2818@lemuria.org>
References: <20020912201240.B2594@lemuria.org> <200209122046.16947.russell@coker.com.au> <20020912231815.C2625@lemuria.org> <200209130053.55563.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200209130053.55563.russell@coker.com.au>; from russell@coker.com.au on Fri, Sep 13, 2002 at 12:53:55AM +0200
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, Sep 13, 2002 at 12:53:55AM +0200, Russell Coker wrote:
> NB You need separate types for the kernel and the disk image.  The kernel 
> should not be writable...

Yes, and the backing store file should also not be writeable, just the
cow file and the keystroke logger files.


> You possibly don't want the system to run it (but that is debatable), however 
> you certainly want to be able to install a kernel as the administrator and 
> have regular users execute it.

Shouldn't chcon be able to do that?

Ah, I'll find out.


> Chroot is probably too heavy, irc is simpler and easier to copy from.  For 
> keystroke logger files I guess you could make them append-only.  Or you could 
> use the same read-write file you use for the data store.

Definitely append only, but the problem is that they are created on
runtime, not like logfiles where you can assume that it exists when you
execute.
And they are always created in the uml dir. I'll look into the uml
source what exactly is hardcoded there. I would definitely prefer them
to be in their own subdir.

-- 
http://web.lemuria.org/pubkey.html
pub  1024D/2D7A04F5 2002-05-16 Tom Vogt <tom@lemuria.org>
     Key fingerprint = C731 64D1 4BCF 4C20 48A4  29B2 BF01 9FA1 2D7A 04F5

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
