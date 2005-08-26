Subject: Re: [PATCH] remove selinux stacked ops
From: Stephen Smalley <sds@tycho.nsa.gov>
To: serue@us.ibm.com
Cc: Tony Jones <tonyj@suse.de>, Chris Wright <chrisw@osdl.org>,
   linux-security-module@wirex.com, selinux@tycho.nsa.gov
In-Reply-To: <20050826125455.GA10491@sergelap.austin.ibm.com>
References: <20050825221732.GR7991@shell0.pdx.osdl.net>
	 <20050825225104.GC7762@shell0.pdx.osdl.net>
	 <1125056906.5812.32.camel@moss-spartans.epoch.ncsc.mil>
	 <1125057491.5812.38.camel@moss-spartans.epoch.ncsc.mil>
	 <1125059398.5812.53.camel@moss-spartans.epoch.ncsc.mil>
	 <20050826163307.GA32690@immunix.com>
	 <20050826125455.GA10491@sergelap.austin.ibm.com>
Content-Type: text/plain
Date: Fri, 26 Aug 2005 12:55:48 -0400
Message-Id: <1125075348.8692.26.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2005-08-26 at 07:54 -0500, serue@us.ibm.com wrote:
> For conceptual simplicity I think keeping an actual module for it around
> will be best.  Then other module can either stack with it, or not,
> however they prefer.

It seems like the direct use of the cap functions would be the preferred
way of combining other modules with the capability logic given that the
cap functions will now always be built-in.  Not using stacker at all for
that purpose.

> Actually that's not quite the way it works under stacker right now.
> If no module is loaded, then dummy is used, but if a module is loaded,
> then stacker doesn't call dummy__hook if the module doesn't define that
> hook.  (Though there are a few hooks which are specially handled, ie
> __vm_enough)
> 
> So switching from having dummy be the default module when nothing is
> stacked, to having capability, is simple enough.

Hmm...well, with these changes, we are looking at dropping the SELinux
hooks that only call the corresponding cap function, thereby falling
back to the default path in the static inlines (without stacker).  So
we'd expect the same behavior with stacker.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
