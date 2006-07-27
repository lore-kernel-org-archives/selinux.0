Subject: RE: [PATCH] clean up datum cast to uint32
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Joshua Brindle <jbrindle@tresys.com>
Cc: Karl MacMillan <kmacmillan@mentalrootkit.com>, selinux@tycho.nsa.gov
In-Reply-To: <6FE441CD9F0C0C479F2D88F959B0158832A8D1@exchange.columbia.tresys.com>
References: 
	 <6FE441CD9F0C0C479F2D88F959B0158832A8D1@exchange.columbia.tresys.com>
Content-Type: text/plain
Date: Thu, 27 Jul 2006 11:13:21 -0400
Message-Id: <1154013201.27604.121.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2006-07-27 at 10:38 -0400, Joshua Brindle wrote:
> This has the same fragility that the uint32_t cast had since this struct
> has to be first, also the way I did it is pretty standard in the
> library, for example destroy_f[SYM_NUM]. And is intuitive, a simple
> function call returns the value.

Embedding the struct makes the common header explicit, which reduces the
likelihood of accidental divergence.  The method invocation makes sense
when the implementations of those methods are divergent for the
different objects, but in this case, we already have a common header and
don't intend to change that - we just want to make it explicit, and the
implementation is always the same.  And it is heavyweight to require
indirect function call overhead just to access the common header.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
