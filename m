Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id OAA16197
	for <selinux@tycho.nsa.gov>; Tue, 10 Sep 2002 14:51:17 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id SAA23300
	for <selinux@tycho.nsa.gov>; Tue, 10 Sep 2002 18:49:58 GMT
Received: from e3.ny.us.ibm.com (e3.ny.us.ibm.com [32.97.182.103])
	by jazzswing.ncsc.mil  with ESMTP id SAA23296
	for <selinux@tycho.nsa.gov>; Tue, 10 Sep 2002 18:49:57 GMT
Subject: Re: IBM's Multics paper
To: Russell Coker <russell@coker.com.au>
Cc: Tracy R Reed <treed@ultraviolet.org>, SE Linux <selinux@tycho.nsa.gov>,
        Paul A Karger <pkarger@us.ibm.com>
Message-ID: <OF88776F1C.76B38723-ON85256C30.0064EA7F@us.ibm.com>
From: Trent Jaeger <jaegert@us.ibm.com>
Date: Tue, 10 Sep 2002 14:36:46 -0400
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

                                                                                                               
                                                                                                               
                                                                                                               


Another comment on Russell's reply.

Russell replied:
>How can an average sysadmin be expected to determine the details of
policy?
>We are working on ways of allowing them to easily manage things at a high
>level (including policy for certain services etc), and we can also use
macros
>for basic configuration of such services.  But when it comes to issues
such
>as whether a daemon should have an "allow" or an "dontaudit" rule
concerning
>access to the sysadm tty types it's something that none of us can agree on
>yet!  So expecting a typical sysadmin to do the right thing is probably
>expecting too much.

>Securing complex systems is inherantly complex and requires a great
>understanding.

I think that maybe we are talking about different things.

My definition of 'Doing the right thing' for a sysadmin is different.
Sysadmins must be able to say that their systems are secure according to
their criteria.  These criteria must be simple enough to be understood by
sysadmins.  Therefore, these criteria are not the individual permissions of
individual daemons, which I agree is too much.    However, the
implementation of these criteria will likely require changing the SELinux
example policy.  So, sysadmins need an approach by which they can express
and maintain their criteria and ensure that the SELinux policy they use
meets those criteria.

I envision that sysadmins have a simpler expression for their security
criteria, have tools to test them reliably, and then they can work with the
per daemon policy experts to make refinements as necessary.

If sysadmins cannot configure SELinux systems correctly, we have problems.
The rest of my note discussed where I am going with this, but I expect that
others have ideas as well.

Trent.
----------------------------------
Trent Jaeger
IBM T.J. Watson Research Center
19 Skyline Drive
Hawthorne, NY 10532
jaegert@watson.ibm.com
(914) 784-7225, FAX (914) 784-7595




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
