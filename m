Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id MAA05830
	for <selinux@tycho.nsa.gov>; Thu, 18 Apr 2002 12:20:51 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id QAA28413
	for <selinux@tycho.nsa.gov>; Thu, 18 Apr 2002 16:19:09 GMT
Received: from nox.lemuria.org ([213.191.86.30])
	by jazzswing.ncsc.mil  with ESMTP id QAA28409
	for <selinux@tycho.nsa.gov>; Thu, 18 Apr 2002 16:19:08 GMT
Date: Thu, 18 Apr 2002 18:21:38 +0200
From: Tom <tom@lemuria.org>
To: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: policy question
Message-ID: <20020418182137.A7029@lemuria.org>
References: <20020418171532.B6551@lemuria.org> <Pine.GSO.4.33.0204181124100.5560-100000@raven>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.GSO.4.33.0204181124100.5560-100000@raven>; from sds@tislabs.com on Thu, Apr 18, 2002 at 11:32:07AM -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, Apr 18, 2002 at 11:32:07AM -0400, Stephen Smalley wrote:
> Immunix's SubDomain provides a mechanism for confining "subprocesses" for
> web servers.  Read their paper for the details.
> 
> IMHO, if you truly want to confine these "scripts" differently than the
> main apache process, they should run in separate processes.

Of course. The real-life problem is that I would prefer to reach this
goal without major changes to apache or the environment. The regular
workings of apache don't allow for anything like this, if for no other
reason then the fact that the children "hang around" after they have
one request done to handle the next ones. Anything else and you drown
in fork() overhead.



-- 
http://web.lemuria.org/pubkey.html
pub  1024D/D88D35A6 2001-11-14 Tom Vogt <tom@lemuria.org>
     Key fingerprint = 276B B7BB E4D8 FCCE DB8F  F965 310B 811A D88D 35A6

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
