Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h56D6PI4003376
	for <selinux@tycho.nsa.gov>; Fri, 6 Jun 2003 09:06:25 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h56D6OtV008471
	for <selinux@tycho.nsa.gov>; Fri, 6 Jun 2003 13:06:24 GMT
Received: from mail.vegaa.de (mail.vegaa.de [213.203.196.181])
        by jazzband.ncsc.mil  with ESMTP id h56D6Nal008458 for <selinux@tycho.nsa.gov>; Fri, 6 Jun 2003 13:06:24 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Carsten Grohmann <carsten.grohmann@raumbildsysteme.de>
To: Russell Coker <russell@coker.com.au>, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: postfix rules
Date: Fri, 6 Jun 2003 15:05:51 +0200
References: <200306041119.15601.carsten.grohmann@raumbildsysteme.de> <200306042033.20756.russell@coker.com.au>
In-Reply-To: <200306042033.20756.russell@coker.com.au>
MIME-Version: 1.0
Message-Id: <200306061505.51960.carsten.grohmann@raumbildsysteme.de>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Am Mittwoch, 4. Juni 2003 12:33 schrieb Russell Coker:
> On Wed, 4 Jun 2003 19:19, Carsten Grohmann wrote:
> > I would add domain_auto_trans(postfix_master_t,
> > postfix_postqueue_exec_t, postfix_postqueue_t)
> > ,but I'm not sure.
> >  What do you thing?
>
> Adding that policy will solve the apparent problem, I've added it
> to my tree.

I'm sorry, but we need domain_auto_trans_read and not 
domain_auto_trans



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
