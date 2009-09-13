Received: from msux-gh1-uea02.nsa.gov (msux-gh1-uea02.nsa.gov [63.239.67.2])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n8DHZBWE027488
	for <selinux@tycho.nsa.gov>; Sun, 13 Sep 2009 13:35:11 -0400
Received: from mail.seekline.net (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id n8DHaXDw002629
	for <selinux@tycho.nsa.gov>; Sun, 13 Sep 2009 17:36:34 GMT
Subject: Re: how to use require and gen_require properly
From: Stefan Schulze Frielinghaus <stefan@seekline.net>
To: Chris PeBenito <pebenito@gentoo.org>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1252671388.2937.4.camel@defiant.pebenito.net>
References: <1252663263.2491.38.camel@vogon.seekline.net>
	 <1252671388.2937.4.camel@defiant.pebenito.net>
Content-Type: text/plain
Date: Sun, 13 Sep 2009 19:34:57 +0200
Message-Id: <1252863297.2486.8.camel@vogon.seekline.net>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2009-09-11 at 08:16 -0400, Chris PeBenito wrote:
[...]
> > What is the actual difference between require and gen_require? Is it
> > allowed to write such statements at the top of the policy or in general
> > is this good practice or not? What was the actual intention of having
> > two require statements? I guess the gen_require was especially for
> > interfaces. But which one should be used if no interface is used?
> 
> gen_require() is just a require{} block.  The only difference is that it
> disappears in the global scope of the base module or the global scope of
> the monolithic policy since require{} blocks are not allowed in those
> places.  If you are using a loadable module, using either require{} or
> gen_require() is fine.

Ah, OK, this explains a lot. Thanks! Now I know what to do ;-)


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
