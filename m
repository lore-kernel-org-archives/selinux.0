Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v6DDfuGS009263
 for <selinux@tycho.nsa.gov>; Thu, 13 Jul 2017 09:41:56 -0400
Received: by mail-lf0-f68.google.com with SMTP id z78so5766057lff.2
 for <selinux@tycho.nsa.gov>; Thu, 13 Jul 2017 06:25:20 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1499949843.624.0.camel@tycho.nsa.gov>
References: <20170710202553.20668-1-sds@tycho.nsa.gov>
 <CAHC9VhQ_uQid=iqetWk3mpehn82sts9NW6oeZzFk0Fq3Td7xFA@mail.gmail.com>
 <1499866012.23108.3.camel@tycho.nsa.gov>
 <CAHC9VhTYY-3po8KzYCAKqYX-t2EkMo548dOu2ufe3MODQ=V3QA@mail.gmail.com>
 <7596a965-4283-94ae-eb34-796e5979f288@ieee.org>
 <1499949843.624.0.camel@tycho.nsa.gov>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 13 Jul 2017 09:25:13 -0400
Message-ID: <CAHC9VhS++BnxPSbSdVax9EVELRME63t4YpaMUYLc4QLNHhjLsg@mail.gmail.com>
To: Stephen Smalley <sds@tycho.nsa.gov>, Chris PeBenito <pebenito@ieee.org>
Cc: selinux@tycho.nsa.gov
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [RFC][PATCH] selinux: Introduce a policy capability and
 permission for NNP transitions
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Thu, Jul 13, 2017 at 8:44 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On Wed, 2017-07-12 at 20:27 -0400, Chris PeBenito wrote:
>> On 07/12/2017 05:38 PM, Paul Moore wrote:
>> > On Wed, Jul 12, 2017 at 9:26 AM, Stephen Smalley <sds@tycho.nsa.gov
>> > > wrote:
>> > > On Tue, 2017-07-11 at 17:00 -0400, Paul Moore wrote:
>> > > > On Mon, Jul 10, 2017 at 4:25 PM, Stephen Smalley <sds@tycho.nsa
>> > > > .gov>
>> > > > wrote:
>> > While I think splitting the NNP/nosuid transition restrictions
>> > might
>> > be a good idea under the new policy capability, I'm not sure it is
>> > worth the cost of a "process2" object class.
>> >
>> > With that in mind, let's do two things with this patch:
>> >
>> > * Mention the nosuid restrictions in the patch description.  It
>> > doesn't need much text, but something would be good so we have
>> > documentation in the git log.
>> >
>> > * Let's pick a new permission name that is not specific to NNP or
>> > nosuid.  IMHO, nnpnosuid_transition is ... less than good.
>> > Unfortunately, I'm not sure I'm much better at picking names; how
>> > about "protected_transition"?  "restricted_transition"?
>> > "enable_transition"?  "override_transition"?
>>
>> I vote for nnp_transition anyway.  "No New Privileges" encompasses
>> nosuid in my mind.  If the two perms had been separated I would have
>> been inclined to allow both every time one of them was needed, to
>> make
>> sure no one was surprised by the behavior difference.
>
> I agree; I'll keep it as nnp_transition and just document it in the
> patch description.

Sorry to be a stubborn about this, but nnp_transition makes little
sense for the nosuid restriction.  Like it or not, NNP has a concrete
meaning which is distinct from nosuid mounts.  We don't have to pick
any of the permission names I tossed out, none of those were very
good, but I would like to see something that takes both NNP and nosuid
into account, or preferably something that doesn't use either name
explicitly but still conveys the meaning.

-- 
paul moore
www.paul-moore.com
