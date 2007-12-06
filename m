Subject: RE: [patch 0/2] policy capability support
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Todd Miller <Tmiller@tresys.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>,
        Joshua Brindle <method@manicmethod.com>,
        Paul Moore <paul.moore@hp.com>, selinux@tycho.nsa.gov,
        Daniel J Walsh <dwalsh@redhat.com>
In-Reply-To: <6FE441CD9F0C0C479F2D88F959B0158801455FEE@exchange.columbia.tresys.com>
References: <20071205184848.180973622@tresys.com>
	 <200712051421.39624.paul.moore@hp.com>
	 <6FE441CD9F0C0C479F2D88F959B0158801455FBA@exchange.columbia.tresys.com>
	 <1196883697.16006.103.camel@moss-spartans.epoch.ncsc.mil>
	 <4757073B.70907@manicmethod.com>
	 <1196886844.16006.117.camel@moss-spartans.epoch.ncsc.mil>
	 <6FE441CD9F0C0C479F2D88F959B0158801455FEE@exchange.columbia.tresys.com>
Content-Type: text/plain
Date: Thu, 06 Dec 2007 10:44:42 -0500
Message-Id: <1196955882.12626.50.camel@gorn.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2007-12-05 at 16:41 -0500, Todd Miller wrote:
> Stephen Smalley wrote:
> > Yes, I'm still against (automatic, default) unioning of the
> > capabilities by the linker - that is clearly not a safe default. 
> > semodule could possibly override that behavior based on an option
> > though, at which point the %post scriptlet in the policy rpm could
> > use that option if we wanted to force it w/o user intervention.
> 
> What do we want the behavior of this option to be?  As I see it we
> have two choices:
> 
> 1) perform a union instead of requiring equivalence
> 
> 2) add capabilities as needed to binary modules in the store.
> 
> The advantage of 2) is that it would only need to happen once which
> makes it more "upgrade friendly".

I now think that the answer is intersection (with a little change to the
userland design).

1. capabilities are enabled only if the policy _fully_ supports them
union: no
intersection: yes
equivalence: yes

2. modules with mismatched capability sets can be inserted (eg upgrade)
union: yes; all defined caps are enabled
intersection: yes; common caps are enabled (warnings on disabled caps)
equivalence: no

3. policy writing implication
union: only modules that care about the cap will enable it
intersection: all modules must enable it
equivalence: all modules must enable it

Going along with this, I think the way caps are handled should be
augmented.  There should be conditional blocks, which allows relevant
policy to be affected

ifcap(fine_grained_netlink) {
	allow foo_t self:netlink_selinux_socket create;
} else {
	allow foo_t self:netlink_socket create;
}

I don't imagine this will be a common case, so most of the time we
wouldn't be using the conditional part of the support.  For the peersid
example, we'd just add the rules and turn on the capability in
refpolicy.  If a 3rd party module doesn't have the capability, the
kernel checks turn off and we have a few extra rules, which doesn't
hurt.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
