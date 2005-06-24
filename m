Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j5OGuNgA008090
	for <selinux@tycho.nsa.gov>; Fri, 24 Jun 2005 12:56:23 -0400 (EDT)
Received: from gotham.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j5OGtm2B025219
	for <selinux@tycho.nsa.gov>; Fri, 24 Jun 2005 16:55:48 GMT
Message-Id: <200506241656.j5OGuIqc017327@gotham.columbia.tresys.com>
From: "Karl MacMillan" <kmacmillan@tresys.com>
To: "'Casey Schaufler'" <casey@schaufler-ca.com>, <selinux@tycho.nsa.gov>
Subject: RE: file contexts and modularity
Date: Fri, 24 Jun 2005 12:56:19 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-reply-to: <20050624164714.15368.qmail@web31614.mail.mud.yahoo.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> -----Original Message-----
> From: Casey Schaufler [mailto:casey@schaufler-ca.com]
> Sent: Friday, June 24, 2005 12:47 PM
> To: Karl MacMillan; selinux@tycho.nsa.gov
> Subject: RE: file contexts and modularity
> 
> 
> 
> --- Karl MacMillan <kmacmillan@tresys.com> wrote:
> 
> 
> > Let's try to separate out the problems correctly.
> > There are 2 issues:
> >
> > 1) The current kernel avtab makes an inappropriate
> > space / time tradeoff.
> > 2) The current policies are not sufficiently
> > designed and may have too many
> > rules.
> >
> > 1 can be fixed even if 2 is true, which it might be.
> 
> Is it valuable to do 1 in the face of 2?
> Sorry, my pointy hair side can't see doing
> much about 1 in the light of 2.
> 

Yes - I think that there are going to be valid policy usage patterns that will
generate a large number of rules for the foreseeable future. That, coupled with
the very high cache hit ratio, means that work on 1 is valuable.

Karl 

---
Karl MacMillan
Tresys Technology
http://www.tresys.com
(410) 290-1411 ext 134

> 
> 
> Casey Schaufler
> casey@schaufler-ca.com
> 
> 
> 
> __________________________________
> Yahoo! Mail
> Stay connected, organized, and protected. Take the tour:
> http://tour.mail.yahoo.com/mailtour.html



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
