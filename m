Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j6LLDTgA000703
	for <selinux@tycho.nsa.gov>; Thu, 21 Jul 2005 17:13:29 -0400 (EDT)
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j6LL83Ba019842
	for <selinux@tycho.nsa.gov>; Thu, 21 Jul 2005 21:08:03 GMT
Subject: Re: [ libsepol 2/6] Ports
From: Ivan Gyurdiev <gyurdiev@redhat.com>
Reply-To: gyurdiev@redhat.com
To: Joshua Brindle <jbrindle@tresys.com>
Cc: Karl MacMillan <kmacmillan@tresys.com>, selinux@tycho.nsa.gov
In-Reply-To: <42E00E51.7050001@tresys.com>
References: <200507212030.j6LKUTvx008177@gotham.columbia.tresys.com>
	 <1121978850.15334.2.camel@celtics.boston.redhat.com>
	 <42E00E51.7050001@tresys.com>
Content-Type: text/plain
Date: Thu, 21 Jul 2005 17:06:25 -0400
Message-Id: <1121979985.15334.5.camel@celtics.boston.redhat.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2005-07-21 at 17:06 -0400, Joshua Brindle wrote:
> Ivan Gyurdiev wrote:
> 
> >>Like I said, I'm not opposed in principal just wondering whether the payoff will
> >>really come.
> >>    
> >>
> >
> >It might, once all the non-parsing code from checkpolicy finds 
> >itself over in libsepol where it belongs. I am now thinking of how
> >to implement an API for adding allow rules on the fly for more
> >dynamic policy customization. 
> >  
> >
> checkpolicy has very little non-parsing code. even the assertion 
> checking which was in there moved to libsepol when we merged modules. 
> What are you specifically talking about that should move?

The rest of it... 

policy_parse.y/define*

All those things the lex parser calls to.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
