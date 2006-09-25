Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k8PKsdDG028010
	for <selinux@tycho.nsa.gov>; Mon, 25 Sep 2006 16:54:39 -0400
Received: from mail1.sea5.speakeasy.net (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k8PKs4aU010035
	for <selinux@tycho.nsa.gov>; Mon, 25 Sep 2006 20:54:06 GMT
Date: Mon, 25 Sep 2006 16:54:32 -0400 (EDT)
From: James Morris <jmorris@namei.org>
To: Stephen Smalley <sds@tycho.nsa.gov>
cc: Karl MacMillan <kmacmillan@mentalrootkit.com>,
        Venkat Yekkirala <vyekkirala@TrustedCS.com>, selinux@tycho.nsa.gov,
        Chad Hanson <chanson@TrustedCS.com>,
        Darrel Goeddel <DGoeddel@TrustedCS.com>, dwalsh@redhat.com,
        jmorris@redhat.com, latten@austin.ibm.com,
        Paul Moore <paul.moore@hp.com>, Joshua Brindle <jbrindle@tresys.com>
Subject: RE: Labeled networking packets
In-Reply-To: <Pine.LNX.4.64.0609251601500.26346@d.namei>
Message-ID: <Pine.LNX.4.64.0609251649580.26949@d.namei>
References: <36282A1733C57546BE392885C0618592015735C9@chaos.tcs.tcs-sec.com>
  <1159196366.3450.13.camel@localhost.localdomain>
 <1159207118.15305.51.camel@moss-spartans.epoch.ncsc.mil>
 <Pine.LNX.4.64.0609251601500.26346@d.namei>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 25 Sep 2006, James Morris wrote:

> On Mon, 25 Sep 2006, Stephen Smalley wrote:
> 
> > I thin the only real choices are:
> > 1) Add a separate field to the sk_buff for use by labeled networking so
> > that we don't have to overload secmark in this manner, or
> 
> This won't fly upstream.
> 
> One possible option here is to partition the 32-bit secmark internally, so 
> that it can be encoded with two SELinux SIDs.

If we're going to do this, we need to establish some kind of constraint on 
SID values passed as network labels, which could limit to only when 
external labeling is active.

e.g.

a) In the normal case, nothing happens.

b) If external labeling is enabled all SIDs used in the secmark field must 
be less than 2^16 in value, and external SIDs are shifted up to the top 
half of the field.  This is done transparently to the user, and if SIDs 
greater than 2^16-1 are present, then the system must also transparently 
remap them for use over the network.  This can be implemented later, but 
we should perhaps also reserve a bit to indicate a mapped SID.



-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
