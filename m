Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id KAA01186
	for <selinux@tycho.nsa.gov>; Tue, 8 Oct 2002 10:42:00 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id OAA03706
	for <selinux@tycho.nsa.gov>; Tue, 8 Oct 2002 14:40:08 GMT
Received: from nox.lemuria.org ([213.191.86.30])
        by jazzband.ncsc.mil  with ESMTP id OAA03694 for <selinux@tycho.nsa.gov>; Tue, 8 Oct 2002 14:40:06 GMT
Date: Tue, 8 Oct 2002 16:41:53 +0200
From: Tom <tom@lemuria.org>
To: selinux@tycho.nsa.gov
Subject: Re: /proc file context
Message-ID: <20021008164153.A5549@lemuria.org>
References: <20021008162610.B5457@lemuria.org> <Pine.GSO.4.33.0210081035310.25356-100000@raven>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.GSO.4.33.0210081035310.25356-100000@raven>; from sds@tislabs.com on Tue, Oct 08, 2002 at 10:36:38AM -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, Oct 08, 2002 at 10:36:38AM -0400, Stephen Smalley wrote:
> If you aren't using procfs, why would you have /proc entries at all?
> procfs contexts are handled via genfs_contexts.  It doesn't make sense to
> have file contexts entries for /proc, as they are only used for creating
> persistent label mappings on persistent filesystems.

You're right. In fact, I get easily confused with virtual filesystem
stuff.



-- 
PGP/GPG key: http://web.lemuria.org/pubkey.html
pub  1024D/2D7A04F5 2002-05-16 Tom Vogt <tom@lemuria.org>
     Key fingerprint = C731 64D1 4BCF 4C20 48A4  29B2 BF01 9FA1 2D7A 04F5

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
