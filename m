Subject: Re: allow tomcat_t self:capability 0x80000000; ??
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Daniel Gil Mayol <Daniel.Gil-Mayol@brunel.de>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <200610191626.40684.Daniel.Gil-Mayol@brunel.de>
References: <200610190933.19483.Daniel.Gil-Mayol@brunel.de>
	 <200610191446.12206.Daniel.Gil-Mayol@brunel.de>
	 <1161263545.14632.109.camel@moss-spartans.epoch.ncsc.mil>
	 <200610191626.40684.Daniel.Gil-Mayol@brunel.de>
Content-Type: text/plain
Date: Thu, 19 Oct 2006 10:48:47 -0400
Message-Id: <1161269327.14632.155.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2006-10-19 at 16:26 +0200, Daniel Gil Mayol wrote:
> I have added "vs_context" in the class capability but don't seems enough, 
> after a "make load" I have the next
> 
> flask/access_vectors:362:ERROR 'too many permissions to fit in an access 
> vector' at token '}' on line 485:
>         vs_context
> }

Hmmm...that was a bug in checkpolicy, but has been fixed for a while, at
least upstream.

> The problem is that currently I can't recompile the kernel. I have written the 
> next (although is not very nice, is temporal until I become a re-compiled 
> kernel):
> 
> dontaudit tomcat_t self:capability *;

Yes, that works too.  But if you can solve the policy problem above (via
newer checkpolicy with that bug fixed), then you can just dontaudit the
vs_context capability even without rebuilding the kernel.  Rebuilding
the kernel is only needed if you want audit messages it generates to
include the string name rather than the numeric value (so that
audit2allow works for you).

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
