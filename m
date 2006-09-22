Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k8MKVCu7000854
	for <selinux@tycho.nsa.gov>; Fri, 22 Sep 2006 16:31:12 -0400
Message-ID: <36282A1733C57546BE392885C0618592015735BD@chaos.tcs.tcs-sec.com>
From: Venkat Yekkirala <vyekkirala@TrustedCS.com>
To: Joshua Brindle <jbrindle@tresys.com>
Cc: Karl MacMillan <kmacmillan@mentalrootkit.com>,
        Stephen Smalley
	 <sds@epoch.ncsc.mil>, Paul Moore <paul.moore@hp.com>,
        latten@austin.ibm.com, jmorris@redhat.com, dwalsh@redhat.com,
        Darrel Goeddel <DGoeddel@TrustedCS.com>,
        Chad Hanson
	 <chanson@TrustedCS.com>, selinux@tycho.nsa.gov
Subject: RE: Labeled networking packets
Date: Fri, 22 Sep 2006 16:30:47 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> -----Original Message-----
> From: Joshua Brindle [mailto:jbrindle@tresys.com]
> Sent: Friday, September 22, 2006 1:52 PM
> To: Venkat Yekkirala
> Cc: Karl MacMillan; Stephen Smalley; Paul Moore; 
> latten@austin.ibm.com;
> jmorris@redhat.com; dwalsh@redhat.com; Darrel Goeddel; Chad Hanson;
> selinux@tycho.nsa.gov
> Subject: RE: Labeled networking packets
> 
> 
> On Fri, 2006-09-22 at 13:23 -0400, Venkat Yekkirala wrote:
> > OK, here's what we will do:
> > 
> > 1. We will have getpeercon() fail if there's no labeled-SA.
> > 
> Also, I still think the getpeercon() answer should be coming from the
> remote machine.

As has been pointed out by Stephen this goes beyond what's available
in the AF_LOCAL case. I believe the name getpeercon() might be throwing
us off here, whether it was consciously named that way or not I don't
know.

> The context can be negotiated by racoon and 
> the SA label
> will continue to be the local socket context.
> 
> If there is ever a reason to get the local socket context (as 
> opposed to
> the remote domain) that could be added but at least I 
> wouldn't care for
> it.
> 
> > 2. We will do a getdatacon() or something similar to retrieve the
> >    secmark (as reconciled in the proposed reconciliation logic, of
> > course).
> > 
> I still don't know how you are handling the management of 
> this. Consider
> 2 machines. One machine has clients (eg., sysadm_mozilla_t,
> sysadm_mysql_client_t, sysadm_ldap_client_t .... and the same 
> for staff
> and user). The server has the corresponding services running.
> 
> For apache to be able to get the appropriate remote context
> (sysadm_mozilla_t, staff_mozilla_t, user_mozilla_t) in order 
> to do some
> sort of access control. There would be a secmark rule for 
> port 80 on the
> server (apache_server_packet_t) and on the client
> (apache_client_packet_t).

The SAs on the server and client can be auto-negotiated by racoon
to be at the respective socket contexts, which I presume in this
case to be the same as the proc contexts?

> There would also be 3 SA's on both 
> the server
> side and the client side. The SA's would be labeled 
> sysadm_mozilla_sa_t
> and so on. 
> 
> So after setting up all that labeling (which I doubt is feasible
> anywhere outside of static MLS setups)

Remember, you haven't done any special rules for the proposed
reconciliation so far uptill this point.

> you'd have to have type
> transition rules for each pair. That comes up to 18 type 
> trans rules for

No transition rules required since you would want getpeercon
to return the peercon which in this case would be coming from the
SA's (which in turn were derived from sockets on the remote end).

If you are NOT using labeled-ipsec, you still wouldn't need to
do any transitions since getpeercon will now fail in the absence
of labeled-SAs.

> 3 services and 3 users and 6 SA's and 2 secmark rules. Start adding in
> more machines and services and this gets ridiculous very fast.
> 
> And after all that it still doesn't seem very useful. If you used
> getpeercon() from 1 racoon could negotiate the correct context (and
> level) and there would be no ambiguity. 
> 
> Once again, I don't think the "ts data coming into a secret SA" makes
> sense.

This won't happen, but having flow control at the entry/exit point
contributes to added assurance.

> If that happens your policy is broken, this data shouldn't be
> allowed in at all let alone having magic level changes to let 
> it happen.

I am not getting it. Where are we letting these level changes happen?

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
