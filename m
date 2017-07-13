Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v6DNtSWH016902
 for <selinux@tycho.nsa.gov>; Thu, 13 Jul 2017 19:55:28 -0400
To: selinux@tycho.nsa.gov
References: <CAHC9VhS++BnxPSbSdVax9EVELRME63t4YpaMUYLc4QLNHhjLsg@mail.gmail.com>
 <1499960906.624.3.camel@tycho.nsa.gov> <1499961595.624.5.camel@tycho.nsa.gov>
 <20170713165557.GA28835@julius.enp8s0.d30>
 <1499969620.624.16.camel@tycho.nsa.gov>
 <20170713181614.GB28835@julius.enp8s0.d30>
 <1499974196.624.20.camel@tycho.nsa.gov>
 <20170713192843.GB13350@julius.enp8s0.d30>
 <20170713194323.GC13350@julius.enp8s0.d30>
 <1499975969.624.22.camel@tycho.nsa.gov>
 <20170713201152.GD13350@julius.enp8s0.d30>
From: Chris PeBenito <pebenito@ieee.org>
Message-ID: <8a833359-76f6-c67f-e0d4-8d0e9618243a@ieee.org>
Date: Thu, 13 Jul 2017 19:55:14 -0400
MIME-Version: 1.0
In-Reply-To: <20170713201152.GD13350@julius.enp8s0.d30>
Content-Type: text/plain; charset=windows-1252; format=flowed
Subject: Re: [RFC][PATCH] selinux: Introduce a policy capability and
 permission for NNP transitions
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 07/13/2017 04:11 PM, Dominick Grift wrote:
> On Thu, Jul 13, 2017 at 03:59:29PM -0400, Stephen Smalley wrote:
>> On Thu, 2017-07-13 at 21:43 +0200, Dominick Grift wrote:
>>> On Thu, Jul 13, 2017 at 09:28:43PM +0200, Dominick Grift wrote:
>>>> On Thu, Jul 13, 2017 at 03:29:56PM -0400, Stephen Smalley wrote:
>>>>> On Thu, 2017-07-13 at 20:16 +0200, Dominick Grift wrote:
>>>>>> On Thu, Jul 13, 2017 at 02:13:40PM -0400, Stephen Smalley
>>>>>> wrote:
>>>>>>> On Thu, 2017-07-13 at 18:55 +0200, Dominick Grift wrote:
>>>>>>>> On Thu, Jul 13, 2017 at 11:59:55AM -0400, Stephen Smalley
>>>>>>>> wrote:
>>>>>>>>> On Thu, 2017-07-13 at 11:48 -0400, Stephen Smalley wrote:
>>>>>>>>>> On Thu, 2017-07-13 at 09:25 -0400, Paul Moore wrote:
>>>>>>>>>>> On Thu, Jul 13, 2017 at 8:44 AM, Stephen Smalley <sds
>>>>>>>>>>> @tycho
>>>>>>>>>>> .nsa
>>>>>>>>>>> .gov
>>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>> wrote:
>>>>>>>>>>>> On Wed, 2017-07-12 at 20:27 -0400, Chris PeBenito
>>>>>>>>>>>> wrote:
>>>>>>>>>>>>> On 07/12/2017 05:38 PM, Paul Moore wrote:
>>>>>>>>>>>>>> On Wed, Jul 12, 2017 at 9:26 AM, Stephen
>>>>>>>>>>>>>> Smalley <sds
>>>>>>>>>>>>>> @tyc
>>>>>>>>>>>>>> ho.n
>>>>>>>>>>>>>> sa
>>>>>>>>>>>>>> .gov
>>>>>>>>>>>>>>> wrote:
>>>>>>>>>>>>>>> On Tue, 2017-07-11 at 17:00 -0400, Paul Moore
>>>>>>>>>>>>>>> wrote:
>>>>>>>>>>>>>>>> On Mon, Jul 10, 2017 at 4:25 PM, Stephen
>>>>>>>>>>>>>>>> Smalley
>>>>>>>>>>>>>>>> <sds
>>>>>>>>>>>>>>>> @tyc
>>>>>>>>>>>>>>>> ho
>>>>>>>>>>>>>>>> .nsa
>>>>>>>>>>>>>>>> .gov>
>>>>>>>>>>>>>>>> wrote:
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> While I think splitting the NNP/nosuid
>>>>>>>>>>>>>> transition
>>>>>>>>>>>>>> restrictions
>>>>>>>>>>>>>> might
>>>>>>>>>>>>>> be a good idea under the new policy capability,
>>>>>>>>>>>>>> I'm
>>>>>>>>>>>>>> not
>>>>>>>>>>>>>> sure
>>>>>>>>>>>>>> it
>>>>>>>>>>>>>> is
>>>>>>>>>>>>>> worth the cost of a "process2" object class.
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> With that in mind, let's do two things with
>>>>>>>>>>>>>> this
>>>>>>>>>>>>>> patch:
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> * Mention the nosuid restrictions in the patch
>>>>>>>>>>>>>> description.  It
>>>>>>>>>>>>>> doesn't need much text, but something would be
>>>>>>>>>>>>>> good
>>>>>>>>>>>>>> so we
>>>>>>>>>>>>>> have
>>>>>>>>>>>>>> documentation in the git log.
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> * Let's pick a new permission name that is not
>>>>>>>>>>>>>> specific
>>>>>>>>>>>>>> to
>>>>>>>>>>>>>> NNP
>>>>>>>>>>>>>> or
>>>>>>>>>>>>>> nosuid.  IMHO, nnpnosuid_transition is ... less
>>>>>>>>>>>>>> than
>>>>>>>>>>>>>> good.
>>>>>>>>>>>>>> Unfortunately, I'm not sure I'm much better at
>>>>>>>>>>>>>> picking
>>>>>>>>>>>>>> names;
>>>>>>>>>>>>>> how
>>>>>>>>>>>>>> about
>>>>>>>>>>>>>> "protected_transition"?  "restricted_transition
>>>>>>>>>>>>>> "?
>>>>>>>>>>>>>> "enable_transition"?  "override_transition"?
>>>>>>>>>>>>>
>>>>>>>>>>>>> I vote for nnp_transition anyway.  "No New
>>>>>>>>>>>>> Privileges"
>>>>>>>>>>>>> encompasses
>>>>>>>>>>>>> nosuid in my mind.  If the two perms had been
>>>>>>>>>>>>> separated
>>>>>>>>>>>>> I
>>>>>>>>>>>>> would
>>>>>>>>>>>>> have
>>>>>>>>>>>>> been inclined to allow both every time one of
>>>>>>>>>>>>> them was
>>>>>>>>>>>>> needed,
>>>>>>>>>>>>> to
>>>>>>>>>>>>> make
>>>>>>>>>>>>> sure no one was surprised by the behavior
>>>>>>>>>>>>> difference.
>>>>>>>>>>>>
>>>>>>>>>>>> I agree; I'll keep it as nnp_transition and just
>>>>>>>>>>>> document
>>>>>>>>>>>> it
>>>>>>>>>>>> in
>>>>>>>>>>>> the
>>>>>>>>>>>> patch description.
>>>>>>>>>>>
>>>>>>>>>>> Sorry to be a stubborn about this, but nnp_transition
>>>>>>>>>>> makes
>>>>>>>>>>> little
>>>>>>>>>>> sense for the nosuid restriction.  Like it or not,
>>>>>>>>>>> NNP has
>>>>>>>>>>> a
>>>>>>>>>>> concrete
>>>>>>>>>>> meaning which is distinct from nosuid mounts.  We
>>>>>>>>>>> don't
>>>>>>>>>>> have to
>>>>>>>>>>> pick
>>>>>>>>>>> any of the permission names I tossed out, none of
>>>>>>>>>>> those
>>>>>>>>>>> were
>>>>>>>>>>> very
>>>>>>>>>>> good, but I would like to see something that takes
>>>>>>>>>>> both NNP
>>>>>>>>>>> and
>>>>>>>>>>> nosuid
>>>>>>>>>>> into account, or preferably something that doesn't
>>>>>>>>>>> use
>>>>>>>>>>> either
>>>>>>>>>>> name
>>>>>>>>>>> explicitly but still conveys the meaning.
>>>>>>>>>>
>>>>>>>>>> NNP is essentially a superset of nosuid; it applies to
>>>>>>>>>> all
>>>>>>>>>> execve()
>>>>>>>>>> calls by the process and its descendants rather than
>>>>>>>>>> only to
>>>>>>>>>> execve()
>>>>>>>>>> calls on specially marked filesystems.  So I viewed it
>>>>>>>>>> as the
>>>>>>>>>> more
>>>>>>>>>> general term.
>>>>>>>>>>
>>>>>>>>>> If that's not viable, I can't think of anything clearer
>>>>>>>>>> or
>>>>>>>>>> better
>>>>>>>>>> than
>>>>>>>>>> nnp_nosuid_transition.  That clearly links it to what
>>>>>>>>>> it
>>>>>>>>>> means
>>>>>>>>>> (allow
>>>>>>>>>> a
>>>>>>>>>> SELinux domain transition under NNP or nosuid).  It is
>>>>>>>>>> somewhat
>>>>>>>>>> ugly
>>>>>>>>>> and verbose but it is clear in what it means, which I
>>>>>>>>>> think
>>>>>>>>>> is
>>>>>>>>>> more
>>>>>>>>>> important. All of your suggestions IMHO were less clear
>>>>>>>>>> since
>>>>>>>>>> they
>>>>>>>>>> had
>>>>>>>>>> no clear linkage to either NNP or nosuid, and I
>>>>>>>>>> couldn't tell
>>>>>>>>>> from
>>>>>>>>>> reading the permission name what it meant.  The SELinux
>>>>>>>>>> domain
>>>>>>>>>> transition isn't protected, it isn't restricted, it
>>>>>>>>>> isn't
>>>>>>>>>> clear
>>>>>>>>>> what
>>>>>>>>>> enable_transition means versus the regular transition
>>>>>>>>>> or
>>>>>>>>>> dyntransition
>>>>>>>>>> permissions, and we aren't overriding a transition but
>>>>>>>>>> rather
>>>>>>>>>> allowing
>>>>>>>>>> one under NNP/nosuid.
>>>>>>>>>>
>>>>>>>>>> The only other alternative I see is to introduce a
>>>>>>>>>> process2
>>>>>>>>>> class
>>>>>>>>>> and
>>>>>>>>>> use separate nnp_transition and nosuid_transition
>>>>>>>>>> permissions
>>>>>>>>>> (but in
>>>>>>>>>> practice I expect them to be both allowed or denied
>>>>>>>>>> together).  Note
>>>>>>>>>> that this will require two avtab and AVC entries for
>>>>>>>>>> every
>>>>>>>>>> domain
>>>>>>>>>> pair
>>>>>>>>>> (if we allow whichever one ends up going in the
>>>>>>>>>> process2
>>>>>>>>>> class),
>>>>>>>>>> so
>>>>>>>>>> that has an impact on policy and AVC size.  Don't
>>>>>>>>>> really see
>>>>>>>>>> that
>>>>>>>>>> as
>>>>>>>>>> worthwhile.
>>>>>>>>>>
>>>>>>>>>> Other approach would be to make the nosuid transition
>>>>>>>>>> checks
>>>>>>>>>> file-
>>>>>>>>>> based
>>>>>>>>>> instead so that it would go in the file class (while
>>>>>>>>>> the nnp
>>>>>>>>>> one
>>>>>>>>>> would
>>>>>>>>>> remain in the process class), but I don't think that's
>>>>>>>>>> really
>>>>>>>>>> what we
>>>>>>>>>> want either.  Difference between "Can domain D1
>>>>>>>>>> transition
>>>>>>>>>> under
>>>>>>>>>> nosuid
>>>>>>>>>>  to D2?" and "Can domain D1 transition under nosuid
>>>>>>>>>> when
>>>>>>>>>> executing
>>>>>>>>>> file
>>>>>>>>>> with type T1?".
>>>>>>>>>
>>>>>>>>> Just to be clear, we would also be separately checking
>>>>>>>>> regular
>>>>>>>>> transition permission between the old and new contexts on
>>>>>>>>> these
>>>>>>>>> transitions, so you would need both:
>>>>>>>>> allow D1 D2:process transition;
>>>>>>>>> allow D1 T1:file nosuid_transition;
>>>>>>>>> if we took the latter approach.
>>>>>>>>>
>>>>>>>>> So we wouldn't lose entirely on a domain-to-domain check,
>>>>>>>>> but
>>>>>>>>> it
>>>>>>>>> would
>>>>>>>>> no longer be domain-to-domain for the nosuid part.
>>>>>>>>>
>>>>>>>>> Whereas with original approach, we end up requiring:
>>>>>>>>> allow D1 D2:process transition;
>>>>>>>>> allow D1 D2:process nnp_nosuid_transition; # or whatever
>>>>>>>>> permission
>>>>>>>>> name is used
>>>>>>>>
>>>>>>>> I don't know if i understand all the ins-and-outs of the
>>>>>>>> matter
>>>>>>>> but i
>>>>>>>> think i do like the idea of differentiating between
>>>>>>>> nosuid_transition
>>>>>>>> and nnp_transition
>>>>>>>> It provides more flexibility because i might not want to
>>>>>>>> allow
>>>>>>>> one or
>>>>>>>> the other automatically.
>>>>>>>>
>>>>>>>> I do not think it its a good idea to allow a process to
>>>>>>>> transiton
>>>>>>>> on
>>>>>>>> nosuid mounted filesystems just because i am forced to
>>>>>>>> allow it
>>>>>>>> nnp.
>>>>>>>
>>>>>>> Can you provide a real use case where you would need to
>>>>>>> distinguish
>>>>>>> them?
>>>>>>
>>>>>> Nope I cannot, but its easy to merge the two permissions in
>>>>>> policy,
>>>>>> and thereby preserving flexibility. It will be hard to deal
>>>>>> with a
>>>>>> case that might arise that was not foreseen if we cover both
>>>>>> scenarios with a single permission.
>>>>>>
>>>>>>>
>>>>>>> Currently we handle them the same way (i.e. we don't allow
>>>>>>> transitions
>>>>>>> unless bounded for both).  The current patch preserves that
>>>>>>> consistency, and just provides a way to allow transitions
>>>>>>> without
>>>>>>> bounds for both.  Of course, you still have to be allowed the
>>>>>>> usual
>>>>>>> permissions in order to perform the transition at all (Can
>>>>>>> the
>>>>>>> caller
>>>>>>> execute the file? Can the callee be entered (entrypoint) by
>>>>>>> the
>>>>>>> file?
>>>>>>> Can the caller transition to the callee?) in addition to the
>>>>>>> new
>>>>>>> permission check (Can the caller transition under NNP/nosuid
>>>>>>> to the
>>>>>>> callee?).
>>>>>>>
>>>>>>> We can't distinguish them on a domain-to-domain basis without
>>>>>>> introducing a new process2 class, and so far no one has been
>>>>>>> excited
>>>>>>> about that.
>>>>>>
>>>>>> Why is that? Eventually that is going to happen anyway. Besides
>>>>>> we
>>>>>> also have a capability2 and its not like that's a big deal is
>>>>>> it?
>>>>>
>>>>> Adding it is fine if we have a genuine need for it, but it
>>>>> doesn't come
>>>>> for free. It is potentially an extra avtab entry (policy rule)
>>>>> for
>>>>> every allowed domain transition in the policy.  There are far
>>>>> fewer
>>>>> capability2 rules in comparison, since those are always domain-
>>>>> self and
>>>>>  to date the need for those capabilities has also been relatively
>>>>> sparse.
>>>>
>>>> Okay i rest my case, just making sure that this is thought over
>>>> carefully
>>>
>>> Aw heck on more argument:
>>>
>>> How about adding another policycap for that?
>>
>> I doubt we want to require policy writers and analysts to have to check
>> a policy capability to determine whether nosuid transitions depend on
>> their own unique permission or the one shared with nnp transitions.
>> Complexity for no real gain.
>
> Yes well "no real gain" I think basically were just saying: nosuid doesnt apply to selinux anymore
>
> If i have an executable file type for a daemon that uses NNP and two executables one on a nosuid mounted slice and another one on a non-nosuid mounted partition, then basically from an selinux perspective the nosuid is meaningless.

I don't think that situation can be addressed with your proposed change 
because the transition checks are between the two domains, not the 
source domain and the executable.


-- 
Chris PeBenito
