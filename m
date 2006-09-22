Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k8MIqXnp030401
	for <selinux@tycho.nsa.gov>; Fri, 22 Sep 2006 14:52:33 -0400
Received: from twoface.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k8MIpXEW017577
	for <selinux@tycho.nsa.gov>; Fri, 22 Sep 2006 18:51:34 GMT
Subject: RE: Labeled networking packets
From: Joshua Brindle <jbrindle@tresys.com>
To: Venkat Yekkirala <vyekkirala@TrustedCS.com>
Cc: Karl MacMillan <kmacmillan@mentalrootkit.com>,
        Stephen Smalley <sds@epoch.ncsc.mil>, Paul Moore <paul.moore@hp.com>,
        latten@austin.ibm.com, jmorris@redhat.com, dwalsh@redhat.com,
        Darrel Goeddel <DGoeddel@TrustedCS.com>,
        Chad Hanson <chanson@TrustedCS.com>, selinux@tycho.nsa.gov
In-Reply-To: <36282A1733C57546BE392885C061859201573525@chaos.tcs.tcs-sec.com>
References: <36282A1733C57546BE392885C061859201573525@chaos.tcs.tcs-sec.com>
Content-Type: text/plain
Date: Fri, 22 Sep 2006 14:52:21 -0400
Message-Id: <1158951141.17541.53.camel@twoface.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2006-09-22 at 13:23 -0400, Venkat Yekkirala wrote:
> OK, here's what we will do:
> 
> 1. We will have getpeercon() fail if there's no labeled-SA.
> 
Also, I still think the getpeercon() answer should be coming from the
remote machine. The context can be negotiated by racoon and the SA label
will continue to be the local socket context.

If there is ever a reason to get the local socket context (as opposed to
the remote domain) that could be added but at least I wouldn't care for
it.

> 2. We will do a getdatacon() or something similar to retrieve the
>    secmark (as reconciled in the proposed reconciliation logic, of
> course).
> 
I still don't know how you are handling the management of this. Consider
2 machines. One machine has clients (eg., sysadm_mozilla_t,
sysadm_mysql_client_t, sysadm_ldap_client_t .... and the same for staff
and user). The server has the corresponding services running.

For apache to be able to get the appropriate remote context
(sysadm_mozilla_t, staff_mozilla_t, user_mozilla_t) in order to do some
sort of access control. There would be a secmark rule for port 80 on the
server (apache_server_packet_t) and on the client
(apache_client_packet_t). There would also be 3 SA's on both the server
side and the client side. The SA's would be labeled sysadm_mozilla_sa_t
and so on. 

So after setting up all that labeling (which I doubt is feasible
anywhere outside of static MLS setups) you'd have to have type
transition rules for each pair. That comes up to 18 type trans rules for
3 services and 3 users and 6 SA's and 2 secmark rules. Start adding in
more machines and services and this gets ridiculous very fast.

And after all that it still doesn't seem very useful. If you used
getpeercon() from 1 racoon could negotiate the correct context (and
level) and there would be no ambiguity. 

Once again, I don't think the "ts data coming into a secret SA" makes
sense. If that happens your policy is broken, this data shouldn't be
allowed in at all let alone having magic level changes to let it happen.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
