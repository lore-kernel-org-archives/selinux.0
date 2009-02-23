Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n1NHbubj027651
	for <selinux@tycho.nsa.gov>; Mon, 23 Feb 2009 12:37:56 -0500
Received: from g5t0008.atlanta.hp.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id n1NHYTe3028691
	for <selinux@tycho.nsa.gov>; Mon, 23 Feb 2009 17:34:29 GMT
From: Paul Moore <paul.moore@hp.com>
To: Joe Nall <joe@nall.com>
Subject: Re: [refpolicy] [PATCH] refpolicy: Add missing network related MLS constraints
Date: Mon, 23 Feb 2009 12:37:51 -0500
Cc: refpolicy@oss.tresys.com, selinux@tycho.nsa.gov
References: <20090212211531.619341973@hp.com> <C85AF158-A39C-46FC-9447-D15E19910D16@nall.com>
In-Reply-To: <C85AF158-A39C-46FC-9447-D15E19910D16@nall.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200902231237.51308.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Friday 20 February 2009 08:37:30 pm Joe Nall wrote:
> How do processes talk to each other on local netlabel interfaces? lo
> for example is s0-s15:c1.c1023, any process above s0 would fail the
> test above communicating on localhost. I don't think that was the
> intent.

I suppose first things first: did you see the new patch posted on Friday 
(February 20th)?  It changed the constraints quite a bit based on feedback on 
the lists.  Please take a look at that patch and see if it looks okay to you, 
if not please yell loudly :)

-- 
paul moore
linux @ hp


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
