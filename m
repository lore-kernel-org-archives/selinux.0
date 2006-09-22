Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k8MJ6Sps030931
	for <selinux@tycho.nsa.gov>; Fri, 22 Sep 2006 15:06:28 -0400
Subject: RE: Labeled networking packets
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Karl MacMillan <kmacmillan@mentalrootkit.com>
Cc: Joshua Brindle <jbrindle@tresys.com>,
        Venkat Yekkirala <vyekkirala@TrustedCS.com>,
        Paul Moore <paul.moore@hp.com>, latten@austin.ibm.com,
        jmorris@redhat.com, dwalsh@redhat.com,
        Darrel Goeddel <DGoeddel@TrustedCS.com>,
        Chad Hanson <chanson@TrustedCS.com>, selinux@tycho.nsa.gov
In-Reply-To: <1158931612.14644.36.camel@localhost.localdomain>
References: 
	 <6FE441CD9F0C0C479F2D88F959B01588443997@exchange.columbia.tresys.com>
	 <1158929251.7748.224.camel@moss-spartans.epoch.ncsc.mil>
	 <1158931612.14644.36.camel@localhost.localdomain>
Content-Type: text/plain
Date: Fri, 22 Sep 2006 15:07:36 -0400
Message-Id: <1158952056.19877.15.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2006-09-22 at 09:26 -0400, Karl MacMillan wrote:
> On Fri, 2006-09-22 at 08:47 -0400, Stephen Smalley wrote:
> > That may be the right approach given the divergent purposes of secmark
> > vs. labeled networking, but it doesn't resolve what motivated the secid
> > reconciliation work in the first place.
> > 
> 
> Which was? It appears to me that we need to resolve the Netlabel and
> ipsec labels and store the result separately from the secid (or whatever
> the secmark label is). Is that what you are thinking?

That is one possibility, but requires a way to propagate that
information everywhere it is required.  In the absence of a generic skb
security field (ala the old LSM patches and old SELinux), we don't have
that ability other than via the secmark, and the secmark has no
lifecycle management so it can only store a scalar.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
