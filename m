Message-ID: <1499960906.624.3.camel@tycho.nsa.gov>
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Paul Moore <paul@paul-moore.com>, Chris PeBenito <pebenito@ieee.org>
Cc: selinux@tycho.nsa.gov
Date: Thu, 13 Jul 2017 11:48:26 -0400
In-Reply-To: <CAHC9VhS++BnxPSbSdVax9EVELRME63t4YpaMUYLc4QLNHhjLsg@mail.gmail.com>
References: <20170710202553.20668-1-sds@tycho.nsa.gov>
 <CAHC9VhQ_uQid=iqetWk3mpehn82sts9NW6oeZzFk0Fq3Td7xFA@mail.gmail.com>
 <1499866012.23108.3.camel@tycho.nsa.gov>
 <CAHC9VhTYY-3po8KzYCAKqYX-t2EkMo548dOu2ufe3MODQ=V3QA@mail.gmail.com>
 <7596a965-4283-94ae-eb34-796e5979f288@ieee.org>
 <1499949843.624.0.camel@tycho.nsa.gov>
 <CAHC9VhS++BnxPSbSdVax9EVELRME63t4YpaMUYLc4QLNHhjLsg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Subject: Re: [RFC][PATCH] selinux: Introduce a policy capability and
 permission for NNP transitions
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Thu, 2017-07-13 at 09:25 -0400, Paul Moore wrote:
> On Thu, Jul 13, 2017 at 8:44 AM, Stephen Smalley <sds@tycho.nsa.gov>
> wrote:
> > On Wed, 2017-07-12 at 20:27 -0400, Chris PeBenito wrote:
> > > On 07/12/2017 05:38 PM, Paul Moore wrote:
> > > > On Wed, Jul 12, 2017 at 9:26 AM, Stephen Smalley <sds@tycho.nsa
> > > > .gov
> > > > > wrote:
> > > > > On Tue, 2017-07-11 at 17:00 -0400, Paul Moore wrote:
> > > > > > On Mon, Jul 10, 2017 at 4:25 PM, Stephen Smalley <sds@tycho
> > > > > > .nsa
> > > > > > .gov>
> > > > > > wrote:
> > > > 
> > > > While I think splitting the NNP/nosuid transition restrictions
> > > > might
> > > > be a good idea under the new policy capability, I'm not sure it
> > > > is
> > > > worth the cost of a "process2" object class.
> > > > 
> > > > With that in mind, let's do two things with this patch:
> > > > 
> > > > * Mention the nosuid restrictions in the patch description.  It
> > > > doesn't need much text, but something would be good so we have
> > > > documentation in the git log.
> > > > 
> > > > * Let's pick a new permission name that is not specific to NNP
> > > > or
> > > > nosuid.  IMHO, nnpnosuid_transition is ... less than good.
> > > > Unfortunately, I'm not sure I'm much better at picking names;
> > > > how
> > > > about "protected_transition"?  "restricted_transition"?
> > > > "enable_transition"?  "override_transition"?
> > > 
> > > I vote for nnp_transition anyway.  "No New Privileges"
> > > encompasses
> > > nosuid in my mind.  If the two perms had been separated I would
> > > have
> > > been inclined to allow both every time one of them was needed, to
> > > make
> > > sure no one was surprised by the behavior difference.
> > 
> > I agree; I'll keep it as nnp_transition and just document it in the
> > patch description.
> 
> Sorry to be a stubborn about this, but nnp_transition makes little
> sense for the nosuid restriction.  Like it or not, NNP has a concrete
> meaning which is distinct from nosuid mounts.  We don't have to pick
> any of the permission names I tossed out, none of those were very
> good, but I would like to see something that takes both NNP and
> nosuid
> into account, or preferably something that doesn't use either name
> explicitly but still conveys the meaning.

NNP is essentially a superset of nosuid; it applies to all execve()
calls by the process and its descendants rather than only to execve()
calls on specially marked filesystems.  So I viewed it as the more
general term.

If that's not viable, I can't think of anything clearer or better than
nnp_nosuid_transition.  That clearly links it to what it means (allow a
SELinux domain transition under NNP or nosuid).  It is somewhat ugly
and verbose but it is clear in what it means, which I think is more
important. All of your suggestions IMHO were less clear since they had
no clear linkage to either NNP or nosuid, and I couldn't tell from
reading the permission name what it meant.  The SELinux domain
transition isn't protected, it isn't restricted, it isn't clear what
enable_transition means versus the regular transition or dyntransition
permissions, and we aren't overriding a transition but rather allowing
one under NNP/nosuid.

The only other alternative I see is to introduce a process2 class and
use separate nnp_transition and nosuid_transition permissions (but in
practice I expect them to be both allowed or denied together).  Note
that this will require two avtab and AVC entries for every domain pair
(if we allow whichever one ends up going in the process2 class), so
that has an impact on policy and AVC size.  Don't really see that as
worthwhile.

Other approach would be to make the nosuid transition checks file-based 
instead so that it would go in the file class (while the nnp one would
remain in the process class), but I don't think that's really what we
want either.  Difference between "Can domain D1 transition under nosuid
 to D2?" and "Can domain D1 transition under nosuid when executing file
with type T1?".

On a separate note, I plan to cc luto on the next version of the patch
as I suspect he will have concerns about relaxing this constraint on
NNP and this likely requires updating Documentation/prctl/no_new_privs*
and the man pages that describe NNP behavior.

The other model would be to figure out a way to make the typebounds
logic work cleanly in a manner that preserves the desired NNP/nosuid
invariant _and_ doesn't require leaking unnecessary accesses into the
ancestor domains that make them less secure, plus CIL support for
automatically propagating permissions in the desired way.  But I
haven't yet come up with a way to do that.  We can do it in some cases
by creating typebounds between the object types, e.g.:
typebounds parent_t child_t;
allow child_t self:process execmem;
allow child_t child_exec_t:file entrypoint;
allow child_t child_tmp_t:file create;
can be allowed via:
allow parent_t child_t:process execmem; # an otherwise nonsensical rule
typebounds parent_exec_t child_exec_t;
typebounds parent_tmp_t child_tmp_t;
but this breaks down when there isn't an equivalent type and permission
set already allowed to the parent for every type allowed to the child.
