Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j5A0J9gA015027
	for <selinux@tycho.nsa.gov>; Thu, 9 Jun 2005 20:19:09 -0400 (EDT)
Received: from free.hands.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j5A0BDFL009001
	for <selinux@tycho.nsa.gov>; Fri, 10 Jun 2005 00:11:14 GMT
Date: Fri, 10 Jun 2005 00:20:31 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: antoine <antoine@nagafix.co.uk>
Cc: SE-Linux <selinux@tycho.nsa.gov>, debian-devel@lists.debian.org,
   Blaisorblade <blaisorblade@yahoo.it>, Jeff Dike <jdike@addtoit.com>
Subject: Re: http://www.golden-gryphon.com/software/security/selinux.xhtml
Message-ID: <20050609232031.GU8525@lkcl.net>
References: <20050609192026.GM8525@lkcl.net> <1118356920.10190.175.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1118356920.10190.175.camel@localhost>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, Jun 09, 2005 at 11:42:00PM +0100, antoine wrote:
> On Thu, 2005-06-09 at 20:20 +0100, Luke Kenneth Casson Leighton wrote:
> > manoj, hi,
> > 
> > i am delighted to see the above web page re: selinux.
> Err?

 never seen it before :)

> > 
> > i notice you mention that there is an effort underway to make
> > a uml-selinux.
> > 
> > perhaps i should mention that it is utterly trivial to set up
> > a xen system with a guest domain running pretty much any kind
> > of kernel - including selinux enabled ones.

> We have been running selinux guest kernels in uml for years, that was

 _great_.
 
 hm - the above page gives the impression that it hasn't been:

	  "There also has been an interest in creating an
	                                      ^^^^^^^^
	  SELinux UML, since it allows for rapid testing of
	  policies, and packages, and to observe the reaction of
	  the machine to threats and other stimuli. However,
	  it has been tedious, traditionally, to create a
	  UML that can be run in enforcing mode. A recipe for
	  doing so has been created..."

> not the issue here, 

> or are you just doing xen advocacy?

 i was under the impression, from the above, that somehow
 debian cannot run selinux/uml.

 i was therefore recommending an alternative that is, by
 comparison, just... okay: xen takes a source code download,
 two kernel compiles, create a guest-machine-config, and
 a guest-machine-install (unless like me you're prepared to
 copy the drive images of an existing machine and hack it into
 submission from there :) and you're done, up, running.

 by contrast: i once installed uml...

> The question was about ensuring proper containment of the UML kernel
> process *from outside*, with regards to the way uml handles tmpfs (which
> it uses as a ram backing store with execute attributes).
> 
> > people who are not happy about using or waiting for uml-selinux
> > might want to consider either temporarily or permanently
> > utilising xen instead.
> Running uml-selinux guests is not a problem, and xen is not necessarily
> the right approach for everything: the system virtualisation does not
> happen at the same os level. Can you control your xen instance from
> within a selinux controlled system? 

 you're talking about running xen in the domain master, yes?

 known as domain "0".

 in theory, it can be done (and i haven't been mad enough to switch on
 selinux in the xen master domain yet...)

 management of xen (communication between domains) is done
 via a python-based HTTP web server (twisted python) running on a high
 port number.

 want fine-grained control?  ... erk.




> (note: I am not talking about
> running selinux from within a xen instance)
 
 known as a guest domain (i.e not numbered domain 0)

> > l.
> > 
> > p.s. xen's a lot damn quicker, too.  quick enough so that you can
> > seriously consider just doing apt-get update, blah blah.
> uml on x86 with the skas3 patch is very fast.
> We've been running debian guests (inc apt-get) just fine for years.

 hm.  sorry about that - the above URL gives an impression other than
 that.

 l.

--
<a href="http://lkcl.net">http://lkcl.net</a>
--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
