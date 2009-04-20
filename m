Subject: Re: access(2) vs. SELinux
From: James Carter <jwcart2@epoch.ncsc.mil>
Reply-To: jwcart2@epoch.ncsc.mil
To: Eric Paris <eparis@redhat.com>
Cc: Joshua Brindle <method@manicmethod.com>,
        Chad Sellers <csellers@tresys.com>,
        Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov,
        James Morris <jmorris@namei.org>, Eric Paris <eparis@parisplace.org>,
        Daniel J Walsh <dwalsh@redhat.com>
In-Reply-To: <1240240273.2562.67.camel@localhost.localdomain>
References: <C60D0537.A684E%csellers@tresys.com>
	 <49EC8841.7050305@manicmethod.com>
	 <1240240273.2562.67.camel@localhost.localdomain>
Content-Type: text/plain
Date: Mon, 20 Apr 2009 14:55:27 -0400
Message-Id: <1240253727.2841.53.camel@moss-lions.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2009-04-20 at 11:11 -0400, Eric Paris wrote:
> On Mon, 2009-04-20 at 10:35 -0400, Joshua Brindle wrote:
> > Chad Sellers wrote:
> > > On 4/16/09 2:10 PM, "Eric Paris" <eparis@redhat.com> wrote:
> > >> He's some concerns/thoughts.
> > >>
> > >> domain_t calls access(W_OK) on file_t.
> > >>
> > >> This generates a denial
> > >>
> > >> denied  { access_write } scontext=domain_t tcontext=file_t tclass=file
> > >>
> > >> Which audit2allow will gladly turn into:
> > >>
> > >> allow domain_t file_t:file { access_write }
> > >>
> > >> Load that module and then, POP the next time
> > >>
> > >> denied { write } scontext=domain_t tcontext=file_t tclass=file
> > >>
> > >> So somewhere we need some sort of synchronization.
> > >>
> > >> ---
> > >>
> > >> I suggested to Dan that audit2allow should should, given the above
> > >> access_write denial output:
> > >> allow domain_t file_t:file { write }
> > >>
> > >> and the tool chain just automatically maps all write rule to both allow
> > >> bits for BOTH write and access_write.
> > >>
> > >> ---
> > >>
> > >> We could also have the tool chain just run in both directions and leave
> > >> audit2allow alone.  Any rule with access_write would cause the tool
> > >> chain to add write and any rule with write would cause us to add
> > >> access_write.
> > >>
> > >>> From the point of view of policy analysis I think think that makes
> > >> things worse.  Now the access_write rule really means something.  That's
> > >> fine with me, but I have a feeling the people who care about policy
> > >> analysis might not like that idea.....
> > >>
> > > I think these issues point to how inelegant this solution is. Relying on the
> > > toolchain to special case this and modify all results is going to be
> > > painful. Another example of this comes up when applying analysis tools to
> > > the policy. SETools will now show rules in a binary policy that can only be
> > > traced back to the source policy if you understand how the compiler mangling
> > > works. Managed policy has allowed us to decrease the amount of policy
> > > mangling we do, and this strategy seems to be going the other direction.
> > > 
> > > I'd like to put in a vote for having access call the _noaudit interface to
> > > suppress the audit record. I agree with Alexey though that it would need to
> > > have something in /selinux to toggle this on/off. Then, when debugging a
> > > policy and not getting denials, you'd throw this switch when to the point of
> > > disabling dontaudits. We could even have semodule -D toggle this as well, if
> > > we really want to bake this into the toolchain somewhere. As far as probing
> > > attacks go, systems with more stringent security requirements that want to
> > > see all possible probing attacks could turn this flag on all the time.
> > > 
> > > 
> > 
> > I agree with this, Eric's description of what needs to happen above makes me 
> > cringe. There is very limited utility to having 2 parallel sets of permissions 
> > that need to be synchronized by the toolchain and quite a bit of potential pain.
> > 
> > One example of horrific pain would be if both the access_write and write rules 
> > were present in policy, and someone wanted to remove the write access. They do 
> > the necessary searching and find where write is granted, remove it and viola - 
> > nothing happens, write access is still granted. Very confusing, I could see even 
> > experienced policy writers getting bitten by this enough to curse the day these 
> > permissions were added.
> 
> I strongly and vehemently oppose any solution that is a blanket
> dontaudit on access calls, even if there is a flag to dontdonaudit.
> This might be fine in "secure" shops where everyone understands and is
> willing to suffer some extra SELinux pain but not here.  If SELinux gets
> in the way it better scream to high heavens for my customers.
> 

I think that what we need is a check to see if the domain is allowed to
call access() on the object.  If it is not allowed, then a denial is
generated; if it is, then the results of the desired permission check is
returned, but denials are not audited.

This would better reflect what is actually happening.  When a domain
calls access(), it is really reading the security properties of the
object.

I don't really see the need of access_read and friends either.  One
permission (Dan had suggested getattrmac in the Bugzilla) should be
enough.  In the policy all domains would be allowed to call access() on
all objects marked with the non_security_file_type attribute.

Let's not make the toolchain even more brittle than it already is.

> I agree that having bi-directional synchronization is a difficult idea.
> That's why I suggested audit2allow never output access_* permissions,
> and I can make the tool chain reject any allow rules that include
> access_* permissions (even with a nice message telling you to not use
> access_* in allow rules).
> 
> But maybe people would like a more kernel centric solution?  I don't,
> because i think the userspace tool chain is the right place to do this.
> And it'll be ugly as @#$^ but I'm sure I could fine some atrocious way
> to get the kernel to check permission on "read" output denials that say
> "read" but on access() call it would check dontaudit rules for
> "access_read"     allow or auditallow rules with any of the access_*
> permissions would be meaningless.  Something tells me sds and jmorris
> are going to hate the level of encapsulation and layering violations
> this is going to take....
> 
> I pretty strongly prefer a one way synch from "read" -> "access_read"
> when going from the text to a binary policy and having the tool chain
> reject any rules with access_* set in other types of rules.  But I think
> audit2allow/why should automagically convert the other way for easy of
> use.
> 
> Doesn't make policy analysis any harder since access_* basically means
> nothing at all, solves the problem of us having to dontaudit
> hot/dangerous code paths, doesn't screw up policy writers since you
> can't have both types of permissions in the text version of policy....
> 
> Does it seem too fragile?
> 
> -Eric
> 
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
-- 
James Carter <jwcart2@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
