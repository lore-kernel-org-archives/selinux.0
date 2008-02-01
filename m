MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [patch] libsemanage:  free base immediately after expand
Date: Fri, 1 Feb 2008 11:54:40 -0500
Message-ID: <6FE441CD9F0C0C479F2D88F959B015880181EDC0@exchange.columbia.tresys.com>
In-Reply-To: <1201875066.4568.149.camel@moss-spartans.epoch.ncsc.mil>
References: <1201875066.4568.149.camel@moss-spartans.epoch.ncsc.mil>
From: "Todd Miller" <Tmiller@tresys.com>
To: "Stephen Smalley" <sds@tycho.nsa.gov>, <selinux@tycho.nsa.gov>
Cc: "Joshua Brindle" <method@manicmethod.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> Drop the base module immediately after expanding, so that the memory
> can be reused for the remainder of the transaction.
> 
> Signed-off-by:  Stephen Smalley <sds@tycho.nsa.gov>

Acked-By: Todd C. Miller <tmiller@tresys.com>

 - todd



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
