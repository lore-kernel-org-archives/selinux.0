Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i72J2irT015291
	for <selinux@tycho.nsa.gov>; Mon, 2 Aug 2004 15:02:44 -0400 (EDT)
Received: from flame.hosts.ndo.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i72J2hKV022842
	for <selinux@tycho.nsa.gov>; Mon, 2 Aug 2004 19:02:43 GMT
Date: Mon, 2 Aug 2004 20:10:45 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Russell Coker <russell@coker.com.au>
Cc: Erich Schubert <erich@debian.org>, SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: /etc/qt3/.qt*
Message-ID: <20040802191045.GI4194@lkcl.net>
References: <20040801194006.GF20103@lkcl.net> <1091391553.7861.17.camel@wintermute.xmldesign.de> <20040802144542.GC4194@lkcl.net> <200408030210.20528.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200408030210.20528.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, Aug 03, 2004 at 02:10:20AM +1000, Russell Coker wrote:
> On Tue, 3 Aug 2004 00:45, Luke Kenneth Casson Leighton <lkcl@lkcl.net> wrote:
> > > I don't have a /etc/qt3. And if i had it, it certainly would be mode
> > > 0755, so no user can write there (and i don't think running qt apps as
> > > root is a good idea) - something must be wrong with your setup.
> >
> >  this is very strange.
> >
> >  it's kde 3.2.2, bog-standard.
> >
> >  and it's root that's trying to write there (xdm_t and xdm_server_t).
> 
> xdm_t is for kdm as I previously mentioned.
> 
> Is xdm_xserver_t (the X server domain) REALLY trying to write to those files?  
> Or is it just inheriting open file handles from kdm?
 
 i'm on a building site today: i'll check the logs in the next
 couple days.  l.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
