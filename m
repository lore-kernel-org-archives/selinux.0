Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j8SFLgNs005961
	for <selinux@tycho.nsa.gov>; Wed, 28 Sep 2005 11:21:42 -0400 (EDT)
Received: from gotham.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j8SFGGor009915
	for <selinux@tycho.nsa.gov>; Wed, 28 Sep 2005 15:16:16 GMT
Message-Id: <200509281516.j8SFFwYs010019@gotham.columbia.tresys.com>
From: "Karl MacMillan" <kmacmillan@tresys.com>
To: "'Ivan Gyurdiev'" <ivg2@cornell.edu>
Cc: <selinux@tycho.nsa.gov>, <dwalsh@redhat.com>, <jbrindle@tresys.com>
Subject: RE: [ SEMANAGE ] dbase initialization/semanage_handle stub/fixes
Date: Wed, 28 Sep 2005 11:15:58 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <4339760A.9080300@cornell.edu>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> -----Original Message-----
> From: Ivan Gyurdiev [mailto:ivg2@cornell.edu]
> Sent: Tuesday, September 27, 2005 12:41 PM
> To: Karl MacMillan
> Cc: selinux@tycho.nsa.gov; dwalsh@redhat.com; jbrindle@tresys.com
> Subject: Re: [ SEMANAGE ] dbase initialization/semanage_handle stub/fixes
> 
> 
> >The patches that I sent out yesterday were not on top of these patches. I
> >would be happy to either rebase your patches or give you a hand rebasing
> >them.
> >
> I will take care of that..
> 
> >It looks, however, that you can probably just drop handle.[c,h] in
> >favor of semanage.[c,h] and things should work. Let me know.
> >
> >
> Or...you could drop semanage.[c,h]'s handle functionality in favor of
> handle.[c,h]. I personally like smaller headers, intended to contain one
> thing. Then you can still write the big  umbrella header by including
> others.

This seems to be what Steve will do.

Karl

------
Karl MacMillan
Tresys Technology
http://www.tresys.com



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
