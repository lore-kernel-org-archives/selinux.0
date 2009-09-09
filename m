Subject: Re: MCS and default labels
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Michal Svoboda <michal.svoboda@agents.felk.cvut.cz>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <20090909135940.GG24297@myhost.felk.cvut.cz>
References: <20090908055806.GA24297@myhost.felk.cvut.cz>
	 <1252424128.13634.404.camel@moss-pluto.epoch.ncsc.mil>
	 <20090908163628.GC24297@myhost.felk.cvut.cz>
	 <1252429805.13634.423.camel@moss-pluto.epoch.ncsc.mil>
	 <20090909100647.GE24297@myhost.felk.cvut.cz>
	 <1252498660.13634.618.camel@moss-pluto.epoch.ncsc.mil>
	 <20090909131935.GF24297@myhost.felk.cvut.cz>
	 <1252503271.13634.669.camel@moss-pluto.epoch.ncsc.mil>
	 <20090909135940.GG24297@myhost.felk.cvut.cz>
Content-Type: text/plain
Date: Wed, 09 Sep 2009 10:34:09 -0400
Message-Id: <1252506849.13634.702.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2009-09-09 at 15:59 +0200, Michal Svoboda wrote:
> Stephen Smalley wrote:
> > > Maybe I am not seeing something after all. Suppose I use the full MLS
> > > variant and give a user the labels c1,c2. How exactly would it happen
> > > that in a c1 dir he would automatically create c1 files, and in c1,c2
> > > dir c1,c2 files?
> > 
> > He wouldn't.  The first case would violate MLS write-down restrictions.
> 
> Ah, I see the point now. In some literature, categories are
> discretionary even when sensitivity levels are used. So a s1:c1 process
> can write to s1, but not to s0:c1.
> 
> > Different people have different views of MCS.  And it hasn't really
> > worked out the way it was envisioned.  There has been some discussion of
> > this, including during the SELinux summits (minutes are published).
> 
> Thanks, I guess I need to read more on that. I've googled the 2007
> minutes, but not the other ones. Would you happen to have some links?

I think that is likely the most relevant one.

On the other hand, MCS categories are being used by the SELinux sandbox
tool developed by Dan Walsh and by sVirt as a simple way of separating
multiple instances of sandboxes and virtual machines from one another
without requiring user configuration, while using TE to control the
interactions with the host system.  But note that MCS is being used in
those cases with low==high (single level).

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
