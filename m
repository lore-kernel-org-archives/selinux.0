Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id QAA09703
	for <selinux@tycho.nsa.gov>; Mon, 9 Sep 2002 16:05:06 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id UAA23379
	for <selinux@tycho.nsa.gov>; Mon, 9 Sep 2002 20:03:47 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id UAA23375
	for <selinux@tycho.nsa.gov>; Mon, 9 Sep 2002 20:03:46 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Stephen Smalley <sds@tislabs.com>
Subject: Re: nsa/selinux/policy/domains/program mta.te,1.2,1.3 procmail.te,1.2,1.3 sendmail.te,1.6,1.7 tmpreaper.te,1.3,1.4 (fwd)
Date: Mon, 9 Sep 2002 22:04:47 +0200
References: <Pine.GSO.4.33.0209091530190.21204-100000@raven>
In-Reply-To: <Pine.GSO.4.33.0209091530190.21204-100000@raven>
Cc: SE Linux <selinux@tycho.nsa.gov>
MIME-Version: 1.0
Message-Id: <200209092204.47665.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 9 Sep 2002 21:34, Stephen Smalley wrote:
> On Mon, 9 Sep 2002, Russell Coker wrote:
> > For the procmail rule, we should probably give sendmail_t the attribute
> > mta_delivery_agent and then use the following to cover all mail servers
> > in mta.te:
> >
> > ifdef(`procmail.te', `
> > domain_auto_trans(mta_delivery_agent, procmail_exec_t, procmail_t)
> > ')
>
> Looks like procmail can also be run directly from $1_mail_t for local
> delivery (user runs mail client which runs sendmail which runs procmail
> directly for local delivery).  Should this be left in $1_mail_t (i.e.
> add can_exec rule) or transition to procmail_t?

It seems that $1_mail_t has all the access needed to write the mail so a 
can_exec() rule will work.

Also giving the user less access to procmail_t is probably a good idea as 
currently procmail_t is way too powerful for my liking, and local hostile 
users could potentially use it for an attack.

One thing I have been considering is a procmail wrapper which would determine 
the appropriate domain for the procmail program and change to procmail_user_t 
or whatever is appropriate.  I am not sure how difficult this is (or even if 
it's possible), it's just a general concept I've got for some time when I 
have nothing to do and GCC is handy...

Also we need a separate type for local mail so we can deny procmail access to 
everything else.


So I think that the can_exec() rule is best, but let's see what input we get 
from the list.


Russell Coker


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
