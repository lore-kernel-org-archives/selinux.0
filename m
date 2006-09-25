Subject: RE: Labeled networking packets
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Venkat Yekkirala <vyekkirala@TrustedCS.com>, selinux@tycho.nsa.gov,
        Chad Hanson <chanson@TrustedCS.com>,
        Darrel Goeddel <DGoeddel@TrustedCS.com>, dwalsh@redhat.com,
        jmorris@redhat.com, latten@austin.ibm.com,
        Paul Moore <paul.moore@hp.com>, Joshua Brindle <jbrindle@tresys.com>
In-Reply-To: <1158958648.19877.89.camel@moss-spartans.epoch.ncsc.mil>
References: <36282A1733C57546BE392885C061859201573525@chaos.tcs.tcs-sec.com>
	 <1158958648.19877.89.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Mon, 25 Sep 2006 10:30:50 -0400
Message-Id: <1159194650.3775.2.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2006-09-22 at 16:57 -0400, Stephen Smalley wrote:
> On Fri, 2006-09-22 at 13:23 -0400, Venkat Yekkirala wrote:
> > OK, here's what we will do:
> > 
> > 1. We will have getpeercon() fail if there's no labeled-SA.
> > 
> > 2. We will do a getdatacon() or something similar to retrieve the
> >    secmark (as reconciled in the proposed reconciliation logic, of course).
> > 
> > Comments?
> 
> I think that just moves the problem.  The question is still whether we
> can have a coherent policy using that reconciliation logic for both
> users of secmark.

This is one of my primary concerns as we are one of the groups that will
attempt to package all of this up, present it to users in a coherent
way, and explain to customers why what they thought is happening is not
happening.

<snip>

>  So we now have multiple rules on packet class to
> achieve the same goal via different mechanisms, and getdatacon() can
> potentially return any of these types.
> 

Exactly. We need _one_ policy regardless of the labeling mechanism that
is used.

Karl


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
