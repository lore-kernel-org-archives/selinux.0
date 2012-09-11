Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q8BF0BCs025024
	for <selinux@tycho.nsa.gov>; Tue, 11 Sep 2012 11:00:11 -0400
Date: Tue, 11 Sep 2012 16:59:56 +0200
From: Laurent Bigonville <bigon@debian.org>
To: Guido Trentalancia <guido@trentalancia.com>
Cc: SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: Assertion `new_role != ((void *)0) && new_role->flavor == 1'
 when installing modules
Message-ID: <20120911165956.74d94e1e@eldamar.bigon.be>
In-Reply-To: <504F4626.7040303@trentalancia.com>
References: <20120909191000.74e83c73@fornost.bigon.be>
	<1347280786.2480.3.camel@moss-pluto.epoch.ncsc.mil>
	<20120911011349.0ecc2f99@eldamar.bigon.be>
	<20120911063822.GA4390@telmora.telvanni>
	<20120911121903.6ba2825d@eldamar.bigon.be>
	<504F4626.7040303@trentalancia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Le Tue, 11 Sep 2012 16:09:42 +0200,
Guido Trentalancia <guido@trentalancia.com> a écrit :

> On 11/09/2012 12:19, Laurent Bigonville wrote:
> >
> > BUT, it seems that the initial assertion is not completely fixed.
> >
> > I'm still getting:
> >
> > checkmodule: expand.c:700: role_fix_callback: Assertion
> > `new_role != ((void *)0) && new_role->flavor == 1' failed.
> 
> Are you using a recent version of the Reference Policy ?

I'm trying to compile the HEAD of the master branch of the git
repository.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
