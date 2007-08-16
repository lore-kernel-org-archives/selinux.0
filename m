Subject: Re: [patch 2/4] libsemanage: genhomedircon replacement
From: Stephen Smalley <sds@tycho.nsa.gov>
To: tmiller@tresys.com
Cc: selinux@tycho.nsa.gov, Joshua Brindle <method@manicmethod.com>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>
In-Reply-To: <20070815204413.603799822@tresys.com>
References: <20070815204411.705994826@tresys.com>
	 <20070815204413.603799822@tresys.com>
Content-Type: text/plain
Date: Thu, 16 Aug 2007 15:31:43 -0400
Message-Id: <1187292703.909.108.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2007-08-15 at 16:44 -0400, tmiller@tresys.com wrote:
> plain text document attachment (genhomedircon-replacement-initial)
> Remove python script genhomedircon from libsemanage and replace
> with C functionality.
> 
> Note: This code fixes a bug in the orignal genhomedircon python script; the
> following two lines are added to the file contexts whereas the old
> genhomedircon would not add them: 
> 
> /tmp/\.exchange-.*(/.*)?      user_u:object_r:user_evolution_exchange_tmp_t:s0
> /tmp/\.exchange-root(/.*)?    root:object_r:user_evolution_exchange_tmp_t:s0

It'd be nice to get a separate bug fix patch for that in the python
genhomedircon for stable.

I just tried running the patched libsemanage and had it regenerate
(semodule -B) on targeted, strict, and mls.  Offhand, I notice that:
- there is lots of extraneous whitespace lines,
- under strict and mls, it botched the entries for me (added via
semanage login -a -s staff_u sds previously), using sds_home_t instead
of staff_home_t.  Oops!
- it kept some entries that old genhomedircon was dropping, as you noted
above (bad genhomedircon, bad!).

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
