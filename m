Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id OAA03662
	for <selinux@tycho.nsa.gov>; Thu, 23 Aug 2001 14:46:44 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id SAA13740
	for <selinux@tycho.nsa.gov>; Thu, 23 Aug 2001 18:45:28 GMT
Received: from albatross.prod.itd.earthlink.net (albatross.mail.pas.earthlink.net [207.217.120.120])
	by jazzswing.ncsc.mil  with ESMTP id SAA13736
	for <selinux@tycho.nsa.gov>; Thu, 23 Aug 2001 18:45:27 GMT
Received: from zion (CBL-dataefx.hs.earthlink.net [207.217.173.155])
	by albatross.prod.itd.earthlink.net (EL-8_9_3_3/8.9.3) with SMTP id LAA29198
	for <selinux@tycho.nsa.gov>; Thu, 23 Aug 2001 11:46:41 -0700 (PDT)
From: "JohnScroggins" <dataefx@earthlink.net>
To: <selinux@tycho.nsa.gov>
Subject: FW: New Development Site
Date: Thu, 23 Aug 2001 11:39:48 -0700
Message-ID: <AGEMJJFIEKIAAOJCCEIGIEGICEAA.dataefx@earthlink.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov



-----Original Message-----
From: JohnScroggins [mailto:dataefx@earthlink.net]
Sent: Wednesday, August 22, 2001 12:00 PM
To: Jonathan Day
Subject: RE: New Development Site


Hi,

I hope you've not taken over the -whole- of Sourceforge. That could be most
awkward for the 10,000 or so other projects hosted there. :)

Aww, they'll get used to it sooner or later ;)

Seriously, I thought someone had -already- mirrored SELinux over on
Sourceforge. Not that it really does any good, as 99.999% of the development
work, at this point, is being done behind the scenes, anyway.

Someone has, and we are using the site that you are talking about..
The kernel development is going forward, but my concern was the remaining
work tasks. I have talked with Stephen Smalley, and indicated an interest in
providing the guidance documentation for the project, that portion of the
project lays dormant.

IMHO, there's a right time for everything, and right now, that seems to be
to examine the new infrastructure that's going to be used. Will it mean that
the next version of SELinux will be more restricted? More flexible? How
secure is the infrastructure itself? The new version of SELinux will be
using external code - has it been audited? What else can it do?

I believe the timing is good on this ramp up effort.. what better than to
have people waiting to test the next release? I would not recommend this(or
any other) development kernel be used in a real time environ, but if there
are people that are willing to run it on test boxes, and provide input and
help make the administrative tasks simpler (which means more people may use
it as a part of their solution), I think this puts the project further down
the road. maybe?

Until the SELinux group is cleared to release the new code, mirroring the
old stuff may be more harmful than good. For a start, it might give the
impression that it -is- the new code, which would NOT be good.

Since there is a v2.4.2 listed on the site now, I would have to say: that
was not my plan. If this is hazardous overall, then a link to the NSA's
website for download would be sufficient? It's already there in the mirror,
just eliminate the CVS option.

Also, if there are multiple mirrors (especially multiple mirrors on
Sourceforge), consolidation and/or arrangement might be a good idea. If the
mirrors are all manual, for example, how is anybody to know, at any given
time, what mirrors hold what versions of what? Perhaps you might want to
look into a "meta-mirror", which allows people to see this information.

there seems to be only one site on S/F for selinux, and we are using that
one to build on.

thanks for the input, really ...:)

--JS

Just some thoughts




------------------------------------------------------------
--== Sent via Deja.com ==--
http://www.deja.com/

--
You have received this message because you are subscribed to the selinux
list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov
with
the words "unsubscribe selinux" without quotes as the message.


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
