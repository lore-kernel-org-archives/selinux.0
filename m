Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k8RH3GAT024407
	for <selinux@tycho.nsa.gov>; Wed, 27 Sep 2006 13:03:16 -0400
Received: from mail2.sea5.speakeasy.net (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k8RH2Ajj014939
	for <selinux@tycho.nsa.gov>; Wed, 27 Sep 2006 17:02:11 GMT
Date: Wed, 27 Sep 2006 13:03:10 -0400 (EDT)
From: James Morris <jmorris@namei.org>
To: Stephen Smalley <sds@tycho.nsa.gov>
cc: Venkat Yekkirala <vyekkirala@TrustedCS.com>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>,
        Chad Hanson <chanson@TrustedCS.com>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>, selinux@tycho.nsa.gov,
        Darrel Goeddel <DGoeddel@TrustedCS.com>, dwalsh@redhat.com,
        jmorris@redhat.com, latten@austin.ibm.com,
        Paul Moore <paul.moore@hp.com>, Joshua Brindle <jbrindle@tresys.com>
Subject: RE: Labeled networking packets
In-Reply-To: <1159363761.32075.53.camel@moss-spartans.epoch.ncsc.mil>
Message-ID: <Pine.LNX.4.64.0609271301550.14583@d.namei>
References: <36282A1733C57546BE392885C061859201573917@chaos.tcs.tcs-sec.com>
  <Pine.LNX.4.64.0609261835060.5342@d.namei>  <1159357078.32075.20.camel@moss-spartans.epoch.ncsc.mil>
  <Pine.LNX.4.64.0609270853420.12766@d.namei> <1159363761.32075.53.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 27 Sep 2006, Stephen Smalley wrote:

> In short, nothing really changes from the earlier secid reconciliation
> patches except for dealing with your earlier comments.  And then we also
> need the other patches mentioned in that thread, like labeling the SAs
> from the socket rather than the spd so that we no longer need per-domain
> spd rules, and setting the peer sid on TCP sockets to the reconciled
> secmark.

In terms of need, it may be useful if someone could distinguish what is 
required for LSPP cert and for a full implementation, given that we are on 
a very short lead for the cert.


-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
