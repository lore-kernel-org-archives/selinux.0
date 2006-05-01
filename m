Subject: Re: [1/4] Labeling only policy for fireflier
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: =?ISO-8859-1?Q?T=F6r=F6k?= Edwin <edwin@gurde.com>
Cc: selinux@tycho.nsa.gov, Stephen Smalley <sds@tycho.nsa.gov>,
        Joshua Brindle <jbrindle@tresys.com>,
        fireflier-devel@lists.sourceforge.net
In-Reply-To: <200605011917.54954.edwin@gurde.com>
References: <200604021240.21290.edwin@gurde.com>
	 <200604262113.01211.edwin@gurde.com>
	 <1146079604.28745.183.camel@moss-spartans.epoch.ncsc.mil>
	 <200605011917.54954.edwin@gurde.com>
Content-Type: text/plain; charset=ISO-8859-1
Date: Mon, 01 May 2006 14:55:38 -0400
Message-Id: <1146509739.20331.47.camel@sgc>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2006-05-01 at 19:17 +0300, Török Edwin wrote:
> Hi,
> [I have split this mail in several parts for easier reading.]
> 
> I have create a stripped down policy for use with fireflier. 
> (for those who didn't read the entire thread: the purpose of this policy is to 
> provide labels for sockets, to be used with skfilter/secmark)

It would be better if you could give the source files and/or a diff from
reference policy, rather than expanded base.conf, etc.  It'll be much
simpler to understand.

> This policy doesn't intend to protect from the actions of root (since as 
> Stephen Smalley suggested that would eventually lead me closer to the strict 
> policy).
> 
> So I made many types aliases, but I left the flask classess,

Just so you know, you definitely wouldn't want to change the classes;
they need to match up with the kernel.

>  initial sids, 
> genfs intact.

I think this can answer your remaining questions: SELinux checks are in
addition to the regular linux DAC; thus, users can, at most, do the same
things they can do on a regular linux system.  If something is denied by
linux DAC it won't even get to the SELinux checks.

> If a user is not root is he able to override the security context of a 
> process/file/socket? (relabel, or otherwise change context)
> 
> Furthermore, if a user is not root, load_policy/restorecon/setfiles won't 
> function, am I right? Even if the user recompiles them (to remove any uid==0 
> checks)?
> 
> I've also seen a capability named dac_override, it is needed when root needs 
> to override dac (creating a file in the user's home directory, for example), 
> but a user can't gain that capability, right? (IOW if DAC denies something, 
> selinux won't allow it either)
> 
> So if I intend to provide no protection from root, I could use an even simpler 
> base policy?

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
