Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h98DdRWt018966
	for <selinux@tycho.nsa.gov>; Wed, 8 Oct 2003 09:39:27 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h98DdQ7f021191
	for <selinux@tycho.nsa.gov>; Wed, 8 Oct 2003 13:39:26 GMT
Date: Wed, 8 Oct 2003 09:39:40 -0400 (EDT)
From: James Morris <jmorris@redhat.com>
To: Stephen Smalley <sds@epoch.ncsc.mil>
cc: Joerg Hoh <joerg@devone.org>, <selinux@tycho.nsa.gov>
Subject: Re: [PATCH] Warnings and 64bit
In-Reply-To: <1065619026.8181.83.camel@moss-spartans.epoch.ncsc.mil>
Message-ID: <Pine.LNX.4.44.0310080938580.8758-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 8 Oct 2003, Stephen Smalley wrote:

> constraint_expr structure, so I don't see how that helps.  Changing the
> fields in constraint_expr to uintptr_t as in your patch causes their
> size to vary depending on the architecture, which means that we can't
> use a single binary policy on both 32 bit and 64 bit machines.  
> 
> James, correct me if I'm wrong here, but this is my understanding.

Yes, this could certainly happen.

- James
-- 
James Morris
<jmorris@redhat.com>



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
