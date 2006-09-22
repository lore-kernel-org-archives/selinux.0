Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k8MLtqBK003449
	for <selinux@tycho.nsa.gov>; Fri, 22 Sep 2006 17:55:52 -0400
Received: from tcsfw4.tcs-sec.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k8MLtI3K004860
	for <selinux@tycho.nsa.gov>; Fri, 22 Sep 2006 21:55:21 GMT
Message-ID: <36282A1733C57546BE392885C0618592015735C9@chaos.tcs.tcs-sec.com>
From: Venkat Yekkirala <vyekkirala@TrustedCS.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov, Chad Hanson <chanson@TrustedCS.com>,
        Darrel Goeddel <DGoeddel@TrustedCS.com>, dwalsh@redhat.com,
        jmorris@redhat.com, latten@austin.ibm.com,
        Paul Moore <paul.moore@hp.com>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>,
        Joshua Brindle
	 <jbrindle@tresys.com>
Subject: RE: Labeled networking packets
Date: Fri, 22 Sep 2006 17:55:13 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> On Fri, 2006-09-22 at 13:23 -0400, Venkat Yekkirala wrote:
> > OK, here's what we will do:
> > 
> > 1. We will have getpeercon() fail if there's no labeled-SA.
> > 
> > 2. We will do a getdatacon() or something similar to retrieve the
> >    secmark (as reconciled in the proposed reconciliation 
> logic, of course).
> > 
> > Comments?
> 
> I think that just moves the problem.

We put a design doc out 3 months or so back (alerting selinux list
at least 2 times 
http://marc.theaimsgroup.com/?l=linux-netdev&m=115136637800361&w=2),
thought got the buy in, and went ahead and implemented
it.

What baffles me is that people even had problems using secmark as it
currently exists, just a few days back. It tells me people look at what
has come along, and THEN find (lack of) uses for it.

Let's go back to the drawing board, first of all define the problems
we are trying to solve, and come up with a design.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
