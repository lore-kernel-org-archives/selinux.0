Subject: RE: [patch 0/4] libsemanage: genhomedircon regressions
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Todd Miller <Tmiller@tresys.com>
Cc: dwalsh@redhat.com, selinux@tycho.nsa.gov,
        Joshua Brindle <jbrindle@tresys.com>
In-Reply-To: <6FE441CD9F0C0C479F2D88F959B01588010FFB86@exchange.columbia.tresys.com>
References: <20070927200712.950671948@tresys.com>
	 <1190986603.22078.1.camel@moss-spartans.epoch.ncsc.mil>
	 <1190987098.22078.4.camel@moss-spartans.epoch.ncsc.mil>
	 <6FE441CD9F0C0C479F2D88F959B01588010FFB75@exchange.columbia.tresys.com>
	 <6FE441CD9F0C0C479F2D88F959B01588010FFB86@exchange.columbia.tresys.com>
Content-Type: text/plain
Date: Fri, 28 Sep 2007 10:59:06 -0400
Message-Id: <1190991546.22078.33.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2007-09-28 at 11:00 -0400, Todd Miller wrote:
> Josh just pointed out that unlike file_contexts,
> file_contexts.homedir isn't sorted via semanage_fc_sort().
> 
> This is probably the best solution, though it would mean
> we lose the comments (they get stripped out during the
> sorting for obvious reasons).
> 
> Thoughts?

I'd have assumed that you want the general /home patterns to come first
always (lowest precedence), then the per-user patterns (and no conflicts
among the per-user patterns).  So I'm not sure why you'd want to sort it
heuristically like the rest of the file contexts.  The heuristics could
end up putting the general /home patterns later, which I don't think you
ever want.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
