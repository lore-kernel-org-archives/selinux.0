Subject: Re: policycoreutils patches
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Daniel J Walsh <dwalsh@redhat.com>, SE Linux <selinux@tycho.nsa.gov>,
        Joshua Brindle <method@manicmethod.com>
In-Reply-To: <1187284917.909.29.camel@moss-spartans.epoch.ncsc.mil>
References: <46B22681.2030107@redhat.com>
	 <1187284917.909.29.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Fri, 17 Aug 2007 09:20:00 -0400
Message-Id: <1187356800.9435.1.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2007-08-16 at 13:21 -0400, Stephen Smalley wrote:
> On Thu, 2007-08-02 at 14:46 -0400, Daniel J Walsh wrote:
> > nsapolicycoreutils_audit2allow_Makefile - Move sepolgen-iggen to sbindir.
> 
> Karl, is moving sepolgen-ifgen fine with you?
> Dan - every time we move something like this, we risk breaking existing
> packages (like .spec file invocation of it), scripts, etc, so let's
> minimize please.
> 

No - I nak'd this forever ago - sepolgen-ifgen is useful for non-root so
it shouldn't be in sbin.

Karl


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
