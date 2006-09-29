Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k8TEXFdM022032
	for <selinux@tycho.nsa.gov>; Fri, 29 Sep 2006 10:33:15 -0400
Received: from mail2.sea5.speakeasy.net (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k8TEWeCw026742
	for <selinux@tycho.nsa.gov>; Fri, 29 Sep 2006 14:32:41 GMT
Date: Fri, 29 Sep 2006 10:33:11 -0400 (EDT)
From: James Morris <jmorris@namei.org>
To: Stephen Smalley <sds@tycho.nsa.gov>
cc: Joshua Brindle <method@gentoo.org>,
        Venkat Yekkirala <vyekkirala@TrustedCS.com>, netdev@vger.kernel.org,
        selinux@tycho.nsa.gov, paul.moore@hp.com, kmacmillan@mentalrootkit.com
Subject: Re: [PATCH 7/7] secid reconciliation-v03: Enforcement for SELinux
In-Reply-To: <1159540113.8496.59.camel@moss-spartans.epoch.ncsc.mil>
Message-ID: <Pine.LNX.4.64.0609291030520.5023@d.namei>
References: <451C85F4.7000406@trustedcs.com>  <451C9897.6030306@gentoo.org>
  <1159534759.8496.1.camel@moss-spartans.epoch.ncsc.mil>
 <1159538414.3592.5.camel@twoface.columbia.tresys.com>
 <1159540113.8496.59.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 29 Sep 2006, Stephen Smalley wrote:

> However, since the transition was removed in the flow_out case, it would
> be logical to remove it from the flow_in case as well, and that would
> have the side benefit of less overhead.

How about adding secmark transitions later, if needed, perhaps with an 
/selinux config control ?

It does keep things simpler for now, in terms of getting this code merged, 
deployed into distros and likely certified.


- James
-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
