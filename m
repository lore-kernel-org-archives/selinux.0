Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k8MJGdOW031236
	for <selinux@tycho.nsa.gov>; Fri, 22 Sep 2006 15:16:39 -0400
Subject: RE: Labeled networking packets
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Joshua Brindle <jbrindle@tresys.com>
Cc: Karl MacMillan <kmacmillan@mentalrootkit.com>,
        Venkat Yekkirala <vyekkirala@TrustedCS.com>,
        Paul Moore <paul.moore@hp.com>, latten@austin.ibm.com,
        jmorris@redhat.com, dwalsh@redhat.com,
        Darrel Goeddel <DGoeddel@TrustedCS.com>,
        Chad Hanson <chanson@TrustedCS.com>, selinux@tycho.nsa.gov
In-Reply-To: <1158933001.17541.18.camel@twoface.columbia.tresys.com>
References: 
	 <6FE441CD9F0C0C479F2D88F959B01588443997@exchange.columbia.tresys.com>
	 <1158929251.7748.224.camel@moss-spartans.epoch.ncsc.mil>
	 <1158931612.14644.36.camel@localhost.localdomain>
	 <1158933001.17541.18.camel@twoface.columbia.tresys.com>
Content-Type: text/plain
Date: Fri, 22 Sep 2006 15:17:54 -0400
Message-Id: <1158952674.19877.22.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2006-09-22 at 09:50 -0400, Joshua Brindle wrote:
> I don't know about this either. I was under the impression that
> reconciliation was for multiple *data* labels (e.g., using ipsec and
> cipso at the same time). I don't know how secmark ever got pulled into
> this mess, secmark is for labeling packet objects, we never ask (or
> probably care) what the label on an individual packet is.

secmark is the only available means at present to propagate security
state with the skb.  Thus it was viewed as a way to recapture paradise
lost when the generic skb security field was rejected.

Also, when secmark is used to label packets based on their origin (e.g.
receiving NIC or source address), it can be viewed as a data label,
similar to the no-longer-used default message context defined by
netifcon statements.  Part of the confusion here is that the sample
usage of secmark in refpolicy and netfilter_contexts is labeling packets
based on their destination (e.g. destined for httpd) rather than their
source.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
