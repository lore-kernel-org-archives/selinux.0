Subject: Re: Patch to policycoreutils
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SELinux <SELinux@tycho.nsa.gov>
In-Reply-To: <41FE4B16.1050206@redhat.com>
References: <1106927779.32737.59.camel@moss-spartans.epoch.ncsc.mil>
	 <41FA6861.6080505@redhat.com>
	 <1106941913.32737.138.camel@moss-spartans.epoch.ncsc.mil>
	 <41FA9FA8.7010008@redhat.com>
	 <1107180899.24654.67.camel@moss-spartans.epoch.ncsc.mil>
	 <41FE4B16.1050206@redhat.com>
Content-Type: text/plain
Message-Id: <1107185236.24654.97.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Mon, 31 Jan 2005 10:27:16 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2005-01-31 at 10:13, Daniel J Walsh wrote:
> >1) The first sed substitution changes:
> >/var/tmp/vi\.recover  -d      system_u:object_r:tmp_t
> >to:
> >/var/tmp/vi*
> >
> >  
> >
> This looks good.

i.e. We can drop the first substitution entirely, right?  Shell will
correctly handle \. as is.

> >2) The second sed substitution changes:
> >/usr/lib(64)?/[^/]*thunderbird[^/]*/thunderbird --      system_u:object_r:bin_t
> >to:
> >/usr/lib*
> >
> >This is due to sed itself performing regex matching for the .* sequence,
> >i.e. it consumes anything after an open parens.  Possibly you could
> >escape it if that is what you intended, e.g. \.\*.
> >
> >  
> >
> Huh?   you need to match both /usr/lib/ and /usr/lib64/  So I don't see 
> anyway of doing this withoug /usr/lib*

Possibly /usr/lib{64,}/*thunderbird*/thunderbird.  The point being that
we don't need to relabel all of /usr/lib here.

> >Similar issues with the other substitutions that are using .*, I think,
> >e.g. changing:
> >/usr/bin/[xgkw]dm     --      system_u:object_r:xdm_exec_t
> >to:
> >/usr/bin/*
> >
> >But the shell would have correctly handled /usr/bin/[xgkw]dm without any
> >change at all.
> >
> >  
> >
> But there are lots of other stuff that could be in between the [] correct?

Yes, we would have to distinguish the cases that can be handled by the
shell vs. the use of other regex metacharacters within the brackets.

> Yes, good catch.  First off we should remove /u?dev and switch to /dev 
> in policy since this was
> only a pre-fc3 problem.  But as in other message any sed experts who can 
> change
> 
> /u*dev --> /{u,}dev

More generally, we would want to replace x? or (x)? with {x,}.  Might be
easier to do in perl or other languages than just sed.

-- 
Stephen Smalley <sds@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
