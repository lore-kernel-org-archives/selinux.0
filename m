Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j59McFgA014623
	for <selinux@tycho.nsa.gov>; Thu, 9 Jun 2005 18:38:16 -0400 (EDT)
Received: from mail.nagafix.co.uk (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j59MULFL002858
	for <selinux@tycho.nsa.gov>; Thu, 9 Jun 2005 22:30:21 GMT
Subject: Re: http://www.golden-gryphon.com/software/security/selinux.xhtml
From: antoine <antoine@nagafix.co.uk>
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Cc: SE-Linux <selinux@tycho.nsa.gov>, debian-devel@lists.debian.org,
   Blaisorblade <blaisorblade@yahoo.it>, Jeff Dike <jdike@addtoit.com>
In-Reply-To: <20050609192026.GM8525@lkcl.net>
References: <20050609192026.GM8525@lkcl.net>
Content-Type: text/plain
Date: Thu, 09 Jun 2005 23:42:00 +0100
Message-Id: <1118356920.10190.175.camel@localhost>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2005-06-09 at 20:20 +0100, Luke Kenneth Casson Leighton wrote:
> manoj, hi,
> 
> i am delighted to see the above web page re: selinux.
Err?
> 
> i notice you mention that there is an effort underway to make
> a uml-selinux.
> 
> perhaps i should mention that it is utterly trivial to set up
> a xen system with a guest domain running pretty much any kind
> of kernel - including selinux enabled ones.
We have been running selinux guest kernels in uml for years, that was
not the issue here, or are you just doing xen advocacy?
The question was about ensuring proper containment of the UML kernel
process *from outside*, with regards to the way uml handles tmpfs (which
it uses as a ram backing store with execute attributes).

> people who are not happy about using or waiting for uml-selinux
> might want to consider either temporarily or permanently
> utilising xen instead.
Running uml-selinux guests is not a problem, and xen is not necessarily
the right approach for everything: the system virtualisation does not
happen at the same os level. Can you control your xen instance from
within a selinux controlled system? (note: I am not talking about
running selinux from within a xen instance)

> l.
> 
> p.s. xen's a lot damn quicker, too.  quick enough so that you can
> seriously consider just doing apt-get update, blah blah.
uml on x86 with the skas3 patch is very fast.
We've been running debian guests (inc apt-get) just fine for years.

Antoine


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
