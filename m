Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i85HNirT018223
	for <selinux@tycho.nsa.gov>; Sun, 5 Sep 2004 13:23:44 -0400 (EDT)
Received: from open.hands.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i85HNht0002438
	for <selinux@tycho.nsa.gov>; Sun, 5 Sep 2004 17:23:43 GMT
Date: Sun, 5 Sep 2004 18:34:52 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Erich Schubert <erich@debian.org>
Cc: russell@coker.com.au, selinux@tycho.nsa.gov
Subject: Re: Additional rule files
Message-ID: <20040905173452.GH4084@lkcl.net>
References: <1094260356.29689.44.camel@wintermute.xmldesign.de> <200409052031.05813.russell@coker.com.au> <1094392498.22073.19.camel@wintermute.xmldesign.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1094392498.22073.19.camel@wintermute.xmldesign.de>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, Sep 05, 2004 at 03:54:58PM +0200, Erich Schubert wrote:
> Hi,
> 
> > Why does fnord need a different policy?  Are the actions of different web 
> > servers that different?  (this is a serious question not a rhetorical 
> > question)
> 
> Well, apache contains a lot of stuff. Fnord and tcpserver are much
> smaller applications that would allow a fine-grained definition of
> rules. (one of the reasons i don't like apache that much is that it
> contains a huge amount of stuff you usually do not use)
 
 apache is modular: i assume that at some point the apache policy
 would reflect this modularity [with tunables/apache_modules.te?]

 l.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
