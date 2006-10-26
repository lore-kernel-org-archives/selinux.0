Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k9Q9tS5J023404
	for <selinux@tycho.nsa.gov>; Thu, 26 Oct 2006 05:55:28 -0400
Received: from mailgate1.arcor-ip.de (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k9Q9sfVH004269
	for <selinux@tycho.nsa.gov>; Thu, 26 Oct 2006 09:54:42 GMT
Received: from relay.brunellocal.de (ffmcospub2ffmbrunelfw2lo-cs-nat-mail-server.adm.arcor.net [145.254.28.157])
	by mailgate1.adm.arcor.net (Arcor-CN-MailRelay-l-A) with ESMTP id 280251D774B
	for <selinux@tycho.nsa.gov>; Thu, 26 Oct 2006 11:55:28 +0200 (CEST)
Received: from localhost (unknown [127.0.0.1])
	by relay.brunellocal.de (Postfix) with ESMTP id 749055BC3
	for <selinux@tycho.nsa.gov>; Thu, 26 Oct 2006 09:55:28 +0000 (UTC)
Received: from relay.brunellocal.de ([127.0.0.1])
 by localhost (relay.brunellocal.de [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 04580-08 for <selinux@tycho.nsa.gov>;
 Thu, 26 Oct 2006 11:55:27 +0200 (CEST)
Received: from mail-hv.brunel.de (mail-hv.brunellocal.de [192.168.1.234])
	by relay.brunellocal.de (Postfix) with ESMTP id D9B754C88
	for <selinux@tycho.nsa.gov>; Thu, 26 Oct 2006 11:55:27 +0200 (CEST)
From: Daniel Gil Mayol <Daniel.Gil-Mayol@brunel.de>
To: selinux@tycho.nsa.gov
Subject: Re: vserver and vprocunhide
Date: Thu, 26 Oct 2006 11:55:14 +0200
References: <200610231751.50609.Daniel.Gil-Mayol@brunel.de> <200610251033.18810.Daniel.Gil-Mayol@brunel.de> <1161781638.3987.256.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1161781638.3987.256.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Message-Id: <200610261155.14980.Daniel.Gil-Mayol@brunel.de>
Content-Type: text/plain;
  charset="utf-8"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> On Wed, 2006-10-25 at 10:33 +0200, Daniel Gil Mayol wrote:
> > > > I want to unhide /proc/1 because seems that vserver try to access
> > > > there:
> > >
> > > That isn't clear.  IIUC, you are getting these denials because you are
> > > trying to unhide /proc/1, not the other way around.
> >
> > But the "denied messages" I sent you before, are reported before I try to
> > unhide the /proc/1.
>
> Then let's focus first on just addressing the avc messages, not on
> vprocunhide.
>
> > > Where does this process run?  On the "base" system or
> > > within each vserver instance?
> >
> > Do you mean vserver_ids? I think within each vserver.
>
> Are you sure?  Please verify.  What is its purpose?  Why would you run
> an IDS within each vserver instance, where it can be compromised by a
> process within that vserver instance, vs. running it in the "host
> context" protected from the vserver instances aka "guests"?

I was wrong, it doesn't run in each vserver. There are a vserver only for IDS 
called vserver_ids. So, vserver_ids_t runs only within the vserver 
'vserver_ids'.

> That is a transition from init_t to vserver_ids_t upon executing a file
> labeled vserver_ids_exec_t.  But nothing is yet running in init_t, so
> the rule achieves nothing by itself.
>
> Before playing with an init_t domain, let's just make sure we understand
> what is going on here and what is truly required.  See my questions
> above about vserver_ids_t.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
