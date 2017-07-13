Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v6DLNKcE020124
 for <selinux@tycho.nsa.gov>; Thu, 13 Jul 2017 17:23:20 -0400
Received: by mail-lf0-f65.google.com with SMTP id z78so6605838lff.2
 for <selinux@tycho.nsa.gov>; Thu, 13 Jul 2017 13:16:18 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1499960906.624.3.camel@tycho.nsa.gov>
References: <20170710202553.20668-1-sds@tycho.nsa.gov>
 <CAHC9VhQ_uQid=iqetWk3mpehn82sts9NW6oeZzFk0Fq3Td7xFA@mail.gmail.com>
 <1499866012.23108.3.camel@tycho.nsa.gov>
 <CAHC9VhTYY-3po8KzYCAKqYX-t2EkMo548dOu2ufe3MODQ=V3QA@mail.gmail.com>
 <7596a965-4283-94ae-eb34-796e5979f288@ieee.org>
 <1499949843.624.0.camel@tycho.nsa.gov>
 <CAHC9VhS++BnxPSbSdVax9EVELRME63t4YpaMUYLc4QLNHhjLsg@mail.gmail.com>
 <1499960906.624.3.camel@tycho.nsa.gov>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 13 Jul 2017 16:15:15 -0400
Message-ID: <CAHC9VhSdFNXe1pgLtNfA6PQ+-r7Nncy67K3q2xc_-juTJ2kCVg@mail.gmail.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Chris PeBenito <pebenito@ieee.org>, selinux@tycho.nsa.gov
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [RFC][PATCH] selinux: Introduce a policy capability and
 permission for NNP transitions
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Thu, Jul 13, 2017 at 11:48 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On Thu, 2017-07-13 at 09:25 -0400, Paul Moore wrote:
>> Sorry to be a stubborn about this, but nnp_transition makes little
>> sense for the nosuid restriction.  Like it or not, NNP has a concrete
>> meaning which is distinct from nosuid mounts.  We don't have to pick
>> any of the permission names I tossed out, none of those were very
>> good, but I would like to see something that takes both NNP and
>> nosuid
>> into account, or preferably something that doesn't use either name
>> explicitly but still conveys the meaning.
>
> NNP is essentially a superset of nosuid; it applies to all execve()
> calls by the process and its descendants rather than only to execve()
> calls on specially marked filesystems.  So I viewed it as the more
> general term.

While there is clearly similar intent behind the NNP and nosuid
restrictions, they are enabled differently and typically require
differing levels of privilege.  We currently treat them similarly from
a SELinux perspective, but from a user/admin perspective they are
quite different (as Dominick points out as well).

> If that's not viable, I can't think of anything clearer or better than
> nnp_nosuid_transition.  That clearly links it to what it means (allow a
> SELinux domain transition under NNP or nosuid).  It is somewhat ugly
> and verbose but it is clear in what it means, which I think is more
> important.

Yes, it's ugly, but probably the only option we are all likely to agree upon.

> All of your suggestions IMHO were less clear since they had
> no clear linkage to either NNP or nosuid, and I couldn't tell from
> reading the permission name what it meant.

As I said, I wasn't in love with those either, I was just trying to
kickstart some brainstorming on the permission name.

> The only other alternative I see is to introduce a process2 class and
> use separate nnp_transition and nosuid_transition permissions ...

As mentioned earlier, I don't think this is worthy of the process2 overhead.

> Other approach would be to make the nosuid transition checks file-based
> instead so that it would go in the file class (while the nnp one would
> remain in the process class), but I don't think that's really what we
> want either.  Difference between "Can domain D1 transition under nosuid
>  to D2?" and "Can domain D1 transition under nosuid when executing file
> with type T1?".

Not a fan of this option either.

> On a separate note, I plan to cc luto on the next version of the patch
> as I suspect he will have concerns about relaxing this constraint on
> NNP and this likely requires updating Documentation/prctl/no_new_privs*
> and the man pages that describe NNP behavior.

That makes sense (both CC'ing Andy and his expected concerns).

> The other model would be to figure out a way to make the typebounds
> logic work cleanly in a manner that preserves the desired NNP/nosuid
> invariant _and_ doesn't require leaking unnecessary accesses into the
> ancestor domains that make them less secure, plus CIL support for
> automatically propagating permissions in the desired way.

We talked about this in the other thread, this would obviously be my
preferred solution, but it doesn't appear practical at the moment.
The one positive with the proposed solution in this patch is that it
doesn't prevent us from later resolving this with a clever bounded
type solution in the future.

-- 
paul moore
www.paul-moore.com
