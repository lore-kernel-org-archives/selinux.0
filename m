Subject: Re: concept of a permissive domain
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Eric Paris <eparis@redhat.com>
Cc: selinux@tycho.nsa.gov, Daniel J Walsh <dwalsh@redhat.com>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>
In-Reply-To: <1189537981.3407.51.camel@localhost.localdomain>
References: <1189537981.3407.51.camel@localhost.localdomain>
Content-Type: text/plain
Date: Thu, 13 Sep 2007 09:11:56 -0400
Message-Id: <1189689116.18713.24.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2007-09-11 at 15:13 -0400, Eric Paris wrote:
> So there was a brief conversation between dan, karl, and myself today
> about implementing a permissive subject domain.  Basically there would
> be some new language construct possibly "permissive httpd_t true;" which
> would then set a flag.  If this flag was set, all denials would be
> logged but the operation would be permitted.  This would make it
> possible to create a type_exec_t and type_t for your new domain, mark it
> as permissive/unconfined and run it as long as you like.  Once you get
> all your new allow rules you just remove the permissive bit.  You didn't
> have to setenforce the whole system.
> 
> First thought from Karl was to use the 'char primary' field of the
> struct type_datum.  Seems reasonable enough, after we have that
> information in kernel it shouldn't take me too much playing around in
> avc_has_perm_noaudit to check if this flag is set on a denial.  I don't
> think slowing down the denial path a little by having to call back in to
> see if this flag was set for a given source sid is that big of deal.
> Maybe I could keep it just about as fast by adding more flags
> audit_allow_once (can't really reuse audit_allow) to the avd or
> something like that, but it seems like a large waste of space to carry
> another set of audit flags that won't be used much.
> 
> Thoughts?  Other ways to implement this?  Problems with the basic premis
> of an unconfined domain?

I used to argue that we didn't need it because you could make a domain
unconfined in policy and then add auditallow statements to generate avc:
granted messages, and then generate policy from those messages.  But it
isn't quite the same thing, as permissive mode does nice things like
only auditing the first occurrence of the denial (otherwise we flood the
audit system), and existing tools only look at avc:  denied messages.
So I'm not fundamentally opposed to the idea.

Is it truly something we want expressed in policy, or something that
should just be controlled via selinuxfs (i.e. create
a /selinux/permissive directory with one node per domain, and let you
write a 0 or 1 to those nodes to make them permissive or enforcing)?
The latter would be more akin to the existing permissive mode and avoid
needing to change anything in policy.  Should be subject to a kernel
config option too, so we can still build kernels with no permissive
support at all.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
