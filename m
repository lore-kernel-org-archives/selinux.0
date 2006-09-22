Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k8MJ1GTu030724
	for <selinux@tycho.nsa.gov>; Fri, 22 Sep 2006 15:01:16 -0400
Subject: RE: Labeled networking packets
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Joshua Brindle <jbrindle@tresys.com>
Cc: Venkat Yekkirala <vyekkirala@TrustedCS.com>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>,
        Paul Moore <paul.moore@hp.com>, latten@austin.ibm.com,
        jmorris@redhat.com, dwalsh@redhat.com,
        Darrel Goeddel <DGoeddel@TrustedCS.com>,
        Chad Hanson <chanson@TrustedCS.com>, selinux@tycho.nsa.gov
In-Reply-To: <1158930147.17541.10.camel@twoface.columbia.tresys.com>
References: 
	 <6FE441CD9F0C0C479F2D88F959B01588443997@exchange.columbia.tresys.com>
	 <1158929251.7748.224.camel@moss-spartans.epoch.ncsc.mil>
	 <1158930147.17541.10.camel@twoface.columbia.tresys.com>
Content-Type: text/plain
Date: Fri, 22 Sep 2006 15:02:21 -0400
Message-Id: <1158951742.19877.7.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2006-09-22 at 09:02 -0400, Joshua Brindle wrote:
> On Fri, 2006-09-22 at 08:47 -0400, Stephen Smalley wrote:
> > If you just mean that the SA context would come from the flow's
> > context
> > rather than the SPD rule, then I think we all agreed to that.  But the
> > context is still ultimately stored in the SA and obtained from it by
> > getpeercon().  That doesn't change.
> > 
> This scheme has a new label that is negotiated by racoon and is used as
> the subject label returned by getpeercon(), it is different from what we
> are already doing.

AFAICT, that is no different than what has already been agreed to.
Understand that the this new label / subject label is still the label of
the SA; the only difference is how the SA label is computed.  getpeercon
_has_ to get the label from the SA when using IPSEC-based labeling.  At
most, one might introduce multiple labels stored in the SA, with one
indicating the "peer" and one indicating the "data", but that goes
beyond what we have even in the AF_LOCAL case.

>  The rest would basically be the same, there would be
> no reconciliation. The only thing I'm not sure of here is the
> interaction of the label negotiated by racoon and a cipso label. It
> almost seems like we need to disallow using them at the same time, I
> suspect people might not like this limitation though.

No, that would be an unwise and unnecessary limitation; fine-grained
labeling via CIPSO within an authorized range for an IPSEC SA would be
quite useful.  The fact that TE doesn't yet understand a notion of
"ranges" is just a limitation of the present TE implementation ;)

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
