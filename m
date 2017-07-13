Message-ID: <1499974196.624.20.camel@tycho.nsa.gov>
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Dominick Grift <dac.override@gmail.com>, selinux@tycho.nsa.gov
Date: Thu, 13 Jul 2017 15:29:56 -0400
In-Reply-To: <20170713181614.GB28835@julius.enp8s0.d30>
References: <CAHC9VhQ_uQid=iqetWk3mpehn82sts9NW6oeZzFk0Fq3Td7xFA@mail.gmail.com>
 <1499866012.23108.3.camel@tycho.nsa.gov>
 <CAHC9VhTYY-3po8KzYCAKqYX-t2EkMo548dOu2ufe3MODQ=V3QA@mail.gmail.com>
 <7596a965-4283-94ae-eb34-796e5979f288@ieee.org>
 <1499949843.624.0.camel@tycho.nsa.gov>
 <CAHC9VhS++BnxPSbSdVax9EVELRME63t4YpaMUYLc4QLNHhjLsg@mail.gmail.com>
 <1499960906.624.3.camel@tycho.nsa.gov>
 <1499961595.624.5.camel@tycho.nsa.gov>
 <20170713165557.GA28835@julius.enp8s0.d30>
 <1499969620.624.16.camel@tycho.nsa.gov>
 <20170713181614.GB28835@julius.enp8s0.d30>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Subject: Re: [RFC][PATCH] selinux: Introduce a policy capability and
 permission for NNP transitions
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Thu, 2017-07-13 at 20:16 +0200, Dominick Grift wrote:
> On Thu, Jul 13, 2017 at 02:13:40PM -0400, Stephen Smalley wrote:
> > On Thu, 2017-07-13 at 18:55 +0200, Dominick Grift wrote:
> > > On Thu, Jul 13, 2017 at 11:59:55AM -0400, Stephen Smalley wrote:
> > > > On Thu, 2017-07-13 at 11:48 -0400, Stephen Smalley wrote:
> > > > > On Thu, 2017-07-13 at 09:25 -0400, Paul Moore wrote:
> > > > > > On Thu, Jul 13, 2017 at 8:44 AM, Stephen Smalley <sds@tycho
> > > > > > .nsa
> > > > > > .gov
> > > > > > > 
> > > > > > 
> > > > > > wrote:
> > > > > > > On Wed, 2017-07-12 at 20:27 -0400, Chris PeBenito wrote:
> > > > > > > > On 07/12/2017 05:38 PM, Paul Moore wrote:
> > > > > > > > > On Wed, Jul 12, 2017 at 9:26 AM, Stephen Smalley <sds
> > > > > > > > > @tyc
> > > > > > > > > ho.n
> > > > > > > > > sa
> > > > > > > > > .gov
> > > > > > > > > > wrote:
> > > > > > > > > > On Tue, 2017-07-11 at 17:00 -0400, Paul Moore
> > > > > > > > > > wrote:
> > > > > > > > > > > On Mon, Jul 10, 2017 at 4:25 PM, Stephen Smalley
> > > > > > > > > > > <sds
> > > > > > > > > > > @tyc
> > > > > > > > > > > ho
> > > > > > > > > > > .nsa
> > > > > > > > > > > .gov>
> > > > > > > > > > > wrote:
> > > > > > > > > 
> > > > > > > > > While I think splitting the NNP/nosuid transition
> > > > > > > > > restrictions
> > > > > > > > > might
> > > > > > > > > be a good idea under the new policy capability, I'm
> > > > > > > > > not
> > > > > > > > > sure
> > > > > > > > > it
> > > > > > > > > is
> > > > > > > > > worth the cost of a "process2" object class.
> > > > > > > > > 
> > > > > > > > > With that in mind, let's do two things with this
> > > > > > > > > patch:
> > > > > > > > > 
> > > > > > > > > * Mention the nosuid restrictions in the patch
> > > > > > > > > description.  It
> > > > > > > > > doesn't need much text, but something would be good
> > > > > > > > > so we
> > > > > > > > > have
> > > > > > > > > documentation in the git log.
> > > > > > > > > 
> > > > > > > > > * Let's pick a new permission name that is not
> > > > > > > > > specific
> > > > > > > > > to
> > > > > > > > > NNP
> > > > > > > > > or
> > > > > > > > > nosuid.  IMHO, nnpnosuid_transition is ... less than
> > > > > > > > > good.
> > > > > > > > > Unfortunately, I'm not sure I'm much better at
> > > > > > > > > picking
> > > > > > > > > names;
> > > > > > > > > how
> > > > > > > > > about
> > > > > > > > > "protected_transition"?  "restricted_transition"?
> > > > > > > > > "enable_transition"?  "override_transition"?
> > > > > > > > 
> > > > > > > > I vote for nnp_transition anyway.  "No New Privileges"
> > > > > > > > encompasses
> > > > > > > > nosuid in my mind.  If the two perms had been separated
> > > > > > > > I
> > > > > > > > would
> > > > > > > > have
> > > > > > > > been inclined to allow both every time one of them was
> > > > > > > > needed,
> > > > > > > > to
> > > > > > > > make
> > > > > > > > sure no one was surprised by the behavior difference.
> > > > > > > 
> > > > > > > I agree; I'll keep it as nnp_transition and just document
> > > > > > > it
> > > > > > > in
> > > > > > > the
> > > > > > > patch description.
> > > > > > 
> > > > > > Sorry to be a stubborn about this, but nnp_transition makes
> > > > > > little
> > > > > > sense for the nosuid restriction.  Like it or not, NNP has
> > > > > > a
> > > > > > concrete
> > > > > > meaning which is distinct from nosuid mounts.  We don't
> > > > > > have to
> > > > > > pick
> > > > > > any of the permission names I tossed out, none of those
> > > > > > were
> > > > > > very
> > > > > > good, but I would like to see something that takes both NNP
> > > > > > and
> > > > > > nosuid
> > > > > > into account, or preferably something that doesn't use
> > > > > > either
> > > > > > name
> > > > > > explicitly but still conveys the meaning.
> > > > > 
> > > > > NNP is essentially a superset of nosuid; it applies to all
> > > > > execve()
> > > > > calls by the process and its descendants rather than only to
> > > > > execve()
> > > > > calls on specially marked filesystems.  So I viewed it as the
> > > > > more
> > > > > general term.
> > > > > 
> > > > > If that's not viable, I can't think of anything clearer or
> > > > > better
> > > > > than
> > > > > nnp_nosuid_transition.  That clearly links it to what it
> > > > > means
> > > > > (allow
> > > > > a
> > > > > SELinux domain transition under NNP or nosuid).  It is
> > > > > somewhat
> > > > > ugly
> > > > > and verbose but it is clear in what it means, which I think
> > > > > is
> > > > > more
> > > > > important. All of your suggestions IMHO were less clear since
> > > > > they
> > > > > had
> > > > > no clear linkage to either NNP or nosuid, and I couldn't tell
> > > > > from
> > > > > reading the permission name what it meant.  The SELinux
> > > > > domain
> > > > > transition isn't protected, it isn't restricted, it isn't
> > > > > clear
> > > > > what
> > > > > enable_transition means versus the regular transition or
> > > > > dyntransition
> > > > > permissions, and we aren't overriding a transition but rather
> > > > > allowing
> > > > > one under NNP/nosuid.
> > > > > 
> > > > > The only other alternative I see is to introduce a process2
> > > > > class
> > > > > and
> > > > > use separate nnp_transition and nosuid_transition permissions
> > > > > (but in
> > > > > practice I expect them to be both allowed or denied
> > > > > together).  Note
> > > > > that this will require two avtab and AVC entries for every
> > > > > domain
> > > > > pair
> > > > > (if we allow whichever one ends up going in the process2
> > > > > class),
> > > > > so
> > > > > that has an impact on policy and AVC size.  Don't really see
> > > > > that
> > > > > as
> > > > > worthwhile.
> > > > > 
> > > > > Other approach would be to make the nosuid transition checks
> > > > > file-
> > > > > based 
> > > > > instead so that it would go in the file class (while the nnp
> > > > > one
> > > > > would
> > > > > remain in the process class), but I don't think that's really
> > > > > what we
> > > > > want either.  Difference between "Can domain D1 transition
> > > > > under
> > > > > nosuid
> > > > >  to D2?" and "Can domain D1 transition under nosuid when
> > > > > executing
> > > > > file
> > > > > with type T1?".
> > > > 
> > > > Just to be clear, we would also be separately checking regular
> > > > transition permission between the old and new contexts on these
> > > > transitions, so you would need both:
> > > > allow D1 D2:process transition;
> > > > allow D1 T1:file nosuid_transition;
> > > > if we took the latter approach.
> > > > 
> > > > So we wouldn't lose entirely on a domain-to-domain check, but
> > > > it
> > > > would
> > > > no longer be domain-to-domain for the nosuid part.
> > > > 
> > > > Whereas with original approach, we end up requiring:
> > > > allow D1 D2:process transition;
> > > > allow D1 D2:process nnp_nosuid_transition; # or whatever
> > > > permission
> > > > name is used
> > > 
> > > I don't know if i understand all the ins-and-outs of the matter
> > > but i
> > > think i do like the idea of differentiating between
> > > nosuid_transition
> > > and nnp_transition
> > > It provides more flexibility because i might not want to allow
> > > one or
> > > the other automatically.
> > > 
> > > I do not think it its a good idea to allow a process to transiton
> > > on
> > > nosuid mounted filesystems just because i am forced to allow it
> > > nnp.
> > 
> > Can you provide a real use case where you would need to distinguish
> > them?
> 
> Nope I cannot, but its easy to merge the two permissions in policy,
> and thereby preserving flexibility. It will be hard to deal with a
> case that might arise that was not foreseen if we cover both
> scenarios with a single permission.
> 
> > 
> > Currently we handle them the same way (i.e. we don't allow
> > transitions
> > unless bounded for both).  The current patch preserves that
> > consistency, and just provides a way to allow transitions without
> > bounds for both.  Of course, you still have to be allowed the usual
> > permissions in order to perform the transition at all (Can the
> > caller
> > execute the file? Can the callee be entered (entrypoint) by the
> > file?
> > Can the caller transition to the callee?) in addition to the new
> > permission check (Can the caller transition under NNP/nosuid to the
> > callee?).
> > 
> > We can't distinguish them on a domain-to-domain basis without
> > introducing a new process2 class, and so far no one has been
> > excited
> > about that.
> 
> Why is that? Eventually that is going to happen anyway. Besides we
> also have a capability2 and its not like that's a big deal is it?

Adding it is fine if we have a genuine need for it, but it doesn't come
for free. It is potentially an extra avtab entry (policy rule) for
every allowed domain transition in the policy.  There are far fewer
capability2 rules in comparison, since those are always domain-self and
 to date the need for those capabilities has also been relatively
sparse.

> But again, its not that big of a deal for me.
> 
> > 
> > > So since the stuff is ugly one way or another might as well make
> > > it
> > > consistent with SELinux flexibility goals
> > > 
> > > Just my preference but I dont have a really strong opinion on the
> > > matter
> > > 
> > > > 
> > > > > 
> > > > > On a separate note, I plan to cc luto on the next version of
> > > > > the
> > > > > patch
> > > > > as I suspect he will have concerns about relaxing this
> > > > > constraint
> > > > > on
> > > > > NNP and this likely requires updating
> > > > > Documentation/prctl/no_new_privs*
> > > > > and the man pages that describe NNP behavior.
> > > > > 
> > > > > The other model would be to figure out a way to make the
> > > > > typebounds
> > > > > logic work cleanly in a manner that preserves the desired
> > > > > NNP/nosuid
> > > > > invariant _and_ doesn't require leaking unnecessary accesses
> > > > > into
> > > > > the
> > > > > ancestor domains that make them less secure, plus CIL support
> > > > > for
> > > > > automatically propagating permissions in the desired
> > > > > way.  But I
> > > > > haven't yet come up with a way to do that.  We can do it in
> > > > > some
> > > > > cases
> > > > > by creating typebounds between the object types, e.g.:
> > > > > typebounds parent_t child_t;
> > > > > allow child_t self:process execmem;
> > > > > allow child_t child_exec_t:file entrypoint;
> > > > > allow child_t child_tmp_t:file create;
> > > > > can be allowed via:
> > > > > allow parent_t child_t:process execmem; # an otherwise
> > > > > nonsensical
> > > > > rule
> > > > > typebounds parent_exec_t child_exec_t;
> > > > > typebounds parent_tmp_t child_tmp_t;
> > > > > but this breaks down when there isn't an equivalent type and
> > > > > permission
> > > > > set already allowed to the parent for every type allowed to
> > > > > the
> > > > > child.
> > > 
> > > 
> 
> 
