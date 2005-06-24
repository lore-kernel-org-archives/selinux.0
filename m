Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j5OHUogA008433
	for <selinux@tycho.nsa.gov>; Fri, 24 Jun 2005 13:30:50 -0400 (EDT)
Received: from gotham.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j5OHUmUD025324
	for <selinux@tycho.nsa.gov>; Fri, 24 Jun 2005 17:30:48 GMT
Message-Id: <200506241730.j5OHUjqc017646@gotham.columbia.tresys.com>
From: "Karl MacMillan" <kmacmillan@tresys.com>
To: "'Casey Schaufler'" <casey@schaufler-ca.com>, <selinux@tycho.nsa.gov>
Subject: RE: Alternative user management approach
Date: Fri, 24 Jun 2005 13:30:47 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-reply-to: <20050624172536.36208.qmail@web31606.mail.mud.yahoo.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> -----Original Message-----
> From: Casey Schaufler [mailto:casey@schaufler-ca.com]
> Sent: Friday, June 24, 2005 1:26 PM
> To: Karl MacMillan; selinux@tycho.nsa.gov
> Subject: RE: Alternative user management approach
> 
> 
> 
> --- Karl MacMillan <kmacmillan@tresys.com> wrote:
> 
> 
> > To make my suggestion more concrete, I think a
> > mapping file in
> > /etc/selinux/policyname that maps from users to
> > SELinux users. The config would
> > be an ordered list of mappings that use username and
> > group information. That
> > means that if the admin wants to use group info they
> > can, otherwise it is
> > ignored. The first match in the ordered list would
> > win. Maybe something like:
> >
> > id:root	sysadm
> > group:wheel staff
> > default	normal
> >
> > There are a lot of possibilities including boolean
> > logic, wildcards, etc. Not
> > certain how much complexity is needed.
> 
> As a thought, how about:
> 
> userid:grouplist:policyname
> 
> where userid or grouplist can be '*' (any) and
> only exact matches count. Most explicit match
> is used.
> 
>     root:*:sysadm
>     fred:wheel:wand
>     *:wheel:staff
>     *:*:normal
> 
> Fred would be in "wand" if only in group wheel,
> in "normal" if in groups wheel and dev. Fun.
> 
> 
> 

Looks reasonable to me - removes ordering which is nice (ordering is so fragile
and error prone). Now if we can just answer the hard question of whether the
whole concept makes sense . . .

Karl

---
Karl MacMillan
Tresys Technology
http://www.tresys.com
(410) 290-1411 ext 134

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
