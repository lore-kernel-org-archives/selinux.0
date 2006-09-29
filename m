Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k8TGB2I6025128
	for <selinux@tycho.nsa.gov>; Fri, 29 Sep 2006 12:11:02 -0400
Received: from mail2.sea5.speakeasy.net (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k8TG9ti6001079
	for <selinux@tycho.nsa.gov>; Fri, 29 Sep 2006 16:09:56 GMT
Date: Fri, 29 Sep 2006 12:10:59 -0400 (EDT)
From: James Morris <jmorris@namei.org>
To: Paul Moore <paul.moore@hp.com>
cc: Stephen Smalley <sds@tycho.nsa.gov>, Joshua Brindle <method@gentoo.org>,
        Venkat Yekkirala <vyekkirala@TrustedCS.com>, netdev@vger.kernel.org,
        selinux@tycho.nsa.gov, kmacmillan@mentalrootkit.com
Subject: Re: [PATCH 7/7] secid reconciliation-v03: Enforcement for SELinux
In-Reply-To: <451D4475.3020003@hp.com>
Message-ID: <Pine.LNX.4.64.0609291209150.5698@d.namei>
References: <451C85F4.7000406@trustedcs.com>  <451C9897.6030306@gentoo.org>
  <1159534759.8496.1.camel@moss-spartans.epoch.ncsc.mil>
 <1159538414.3592.5.camel@twoface.columbia.tresys.com>
 <1159540113.8496.59.camel@moss-spartans.epoch.ncsc.mil>
 <Pine.LNX.4.64.0609291030520.5023@d.namei> <1159540754.8496.62.camel@moss-spartans.epoch.ncsc.mil>
 <451D4475.3020003@hp.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 29 Sep 2006, Paul Moore wrote:

> Unless I'm confusing something, there still may be a need for transitions
> if we want to support both IPsec and NetLabel labeling on the same
> connection.

I'd prefer not to support this, as it's too complicated, and CIPSO is a 
legacy protocol.

Normal IPsec protection applied to CIPSO: yes, but not IPsec labeling and 
CIPSO labeling on the same connection.



- James
-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
