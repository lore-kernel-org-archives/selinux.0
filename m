Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j6FKFTgA014411
	for <selinux@tycho.nsa.gov>; Fri, 15 Jul 2005 16:15:29 -0400 (EDT)
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j6FKB7Bp007206
	for <selinux@tycho.nsa.gov>; Fri, 15 Jul 2005 20:11:07 GMT
Subject: Re: [RFC] selinux management API
From: Ivan Gyurdiev <gyurdiev@redhat.com>
Reply-To: gyurdiev@redhat.com
To: Joshua Brindle <jbrindle@tresys.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1121457421.28365.42.camel@localhost>
References: <42D7CC53.9030803@tresys.com>
	 <1121442990.4488.87.camel@celtics.boston.redhat.com>
	 <42D7FC9A.7000901@tresys.com>
	 <1121455199.10134.15.camel@celtics.boston.redhat.com>
	 <1121455743.28369.36.camel@localhost>
	 <1121456743.10134.36.camel@celtics.boston.redhat.com>
	 <1121457421.28365.42.camel@localhost>
Content-Type: text/plain
Date: Fri, 15 Jul 2005 16:08:43 -0400
Message-Id: <1121458123.10134.49.camel@celtics.boston.redhat.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> > I think it's all about the implementation details...
> > the interface is a great guideline, but in the end all of this
> > has to be implemented, and it has to be convenient for the caller..
> > 
> 
> thats fine but we want a future proof, stable, scalable API, the
> implementation details will be handled at implementation time.

I was under the impression that you'd want me to help with the
implementation... I already have code that does precisely this.
With some modification, it can be made to work on libsemanage.

====

Anyway, I still don't understand how you plan to do the 
template expansion - you're treating that as an implementation detail,
and I think you shouldn't overlook this concern, because it's
not clear how it will work. 


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
