Subject: RE: [RFC][PATCH] extending the libsepol API
From: Stephen Smalley <sds@tycho.nsa.gov>
Reply-To: sds@tycho.nsa.gov
To: Kevin Carr <kcarr@tresys.com>
Cc: selinux@tycho.nsa.gov, SELinux-dev@tresys.com
In-Reply-To: <1143143894.28120.416.camel@moss-spartans.epoch.ncsc.mil>
References: <200603231923.k2NJNMNq014574@gotham.columbia.tresys.com>
	 <1143143894.28120.416.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Fri, 24 Mar 2006 08:37:36 -0500
Message-Id: <1143207456.23788.26.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2006-03-23 at 14:58 -0500, Stephen Smalley wrote:
> No, you don't understand.  There is a stable ABI for libsepol right now.
> You are suggesting deprecating a large chunk of it in favor of your own
> model.  The burden of proof that such deprecation is justified is on
> you, and it needs to be more than just "our proposed API is better
> suited to our particular needs".
<snip>
> Removing the interface once it has gone into a stable OS release (e.g.
> FC5) is very bad form.  And we have to plan that people developing for
> the next generation of distribution releases are looking at the current
> APIs as their basis.  

And to make this a bit stronger:  Even if you can justify the need for
additional interfaces for your specialized needs, that doesn't justify a
wholesale departure from the existing APIs, and your goal should be to
minimize the delta to only what is truly required, making your new
interfaces complement and extend the existing ones rather than replacing
them altogether.  If there are defects in the current interface, then
work on incrementally improving it.  No rewrites, please.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
