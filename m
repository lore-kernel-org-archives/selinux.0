Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h9FGUAWt026386
	for <selinux@tycho.nsa.gov>; Wed, 15 Oct 2003 12:30:10 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h9FGU9mR009869
	for <selinux@tycho.nsa.gov>; Wed, 15 Oct 2003 16:30:09 GMT
Received: from mailhost.unt.edu (mailhost.unt.edu [129.120.209.40])
        by jazzband.ncsc.mil  with ESMTP id h9FGU8jp009866 for <selinux@tycho.nsa.gov>; Wed, 15 Oct 2003 16:30:08 GMT
Received: from iatro (localhost.localdomain [127.0.0.1])
	by mail4 (Postfix) with SMTP id A09399392C
	for <selinux@tycho.nsa.gov>; Wed, 15 Oct 2003 11:30:05 -0500 (CDT)
Received: from eaglemail.unt.edu (imp1.private.acs.unt.edu [192.168.221.71])
	by mailhost.unt.edu (Postfix) with ESMTP id 07D8593994
	for <selinux@tycho.nsa.gov>; Wed, 15 Oct 2003 11:29:56 -0500 (CDT)
Message-ID: <1066235396.3f8d7604111ef@eaglemail.unt.edu>
Date: Wed, 15 Oct 2003 11:29:56 -0500
From: Ignacio Tripodi <ijt0003@unt.edu>
To: selinux@tycho.nsa.gov
Subject: Re: Filesystem problems
References: <Xine.LNX.4.44.0310150913020.5796-100000@thoron.boston.redhat.com>
In-Reply-To: <Xine.LNX.4.44.0310150913020.5796-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Quoting James Morris <jmorris@redhat.com>:
> Are you trying to load an initial policy via initrd?

Yes. I patched the mkinitrd script with the patch provided by the setools
package and created a new initrd image for this kernel. Since I haven't modified
any of the rc files myself I assume that's where it's trying to load the policy
from.

Ignacio

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
