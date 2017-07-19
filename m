Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v6JL2UtG021039
 for <selinux@tycho.nsa.gov>; Wed, 19 Jul 2017 17:02:30 -0400
Received: by mail-lf0-f68.google.com with SMTP id z78so570520lff.2
 for <selinux@tycho.nsa.gov>; Wed, 19 Jul 2017 14:01:54 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <03f326bc-599c-0074-0cc2-7f46808673a1@ieee.org>
References: <20170714164647.6183-1-sds@tycho.nsa.gov>
 <20170716151512.GA4615@meriadoc.perfinion.com>
 <CAHC9VhRe=4N8S74_QD-rwAhRXLF6vceDt=Q0wx8TmTwgy6DNLA@mail.gmail.com>
 <1500383878.18445.1.camel@tycho.nsa.gov>
 <1500405609.18445.14.camel@tycho.nsa.gov>
 <CAHC9VhQz686zC06smDZHf_GYF8EmHpErX5xXnx9bifU51EkwrQ@mail.gmail.com>
 <03f326bc-599c-0074-0cc2-7f46808673a1@ieee.org>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 19 Jul 2017 17:01:44 -0400
Message-ID: <CAHC9VhSK0ZzRye+PxVk4fttA95tFb-WjbWcuB+qWHOLnnVucHw@mail.gmail.com>
To: Chris PeBenito <pebenito@ieee.org>, Stephen Smalley <sds@tycho.nsa.gov>
Cc: Dominick Grift <dac.override@gmail.com>, lvrabec@redhat.com,
 Jason Zaman <jason@perfinion.com>, selinux@tycho.nsa.gov,
 luto@amacapital.net
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [PATCH] selinux: Generalize support for NNP/nosuid
 SELinux domain transitions
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Tue, Jul 18, 2017 at 9:07 PM, Chris PeBenito <pebenito@ieee.org> wrote:
> On 07/18/2017 05:26 PM, Paul Moore wrote:
>>
>> On Tue, Jul 18, 2017 at 3:20 PM, Stephen Smalley <sds@tycho.nsa.gov>
>> wrote:
>>>
>>> On Tue, 2017-07-18 at 09:17 -0400, Stephen Smalley wrote:
>>>>
>>>> On Mon, 2017-07-17 at 15:54 -0400, Paul Moore wrote:
>>>>>
>>>>> On Sun, Jul 16, 2017 at 11:15 AM, Jason Zaman <jason@perfinion.com>
>>>>> wrote:
>>
>>
>> ...
>>
>>>>>> Why do we want to disallow type-bounds to work even with the
>>>>>> capability?
>>>>>> it seems sensible to me to allow typebounds to transition even in
>>>>>> the
>>>>>> future. If we do then we probably dont need the policycap which
>>>>>> seems
>>>>>> less complicated.
>>>>>
>>>>>
>>>>> The suggestion to continue to support bounded domain transitions
>>>>> seems
>>>>> reasonable to me, although we would need to worry about which check
>>>>> to
>>>>> do first (bounded transition or process:nnp_nosuid_transition), and
>>>>> how to limit the auditing/reporting so admins are confused by the
>>>>> first check failing, yet the transition still taking place.  None
>>>>> of
>>>>> these are unsolvable problems, but it will likely need a bit more
>>>>> work.
>>>>>
>>>>> I'm sure Stephen has some thoughts on this as well.
>>>>
>>>>
>>>> Others (e.g. Dominick) seemed to take the opposite view on the
>>>> earlier
>>>> RFC discussion, i.e. that we should only check the new permission if
>>>> the capability is enabled.  I specifically raised that as a question
>>>> there.
>>>>
>>>> I'm willing to change it to fallback to checking for a bounded type,
>>>> but that will mean two audit messages (I don't think we can just hide
>>>> one of them) when neither is allowed.  That said, it is unlikely to
>>>> cause much confusion in practice because users typically only look
>>>> for
>>>> and pay attention to AVC messages, and anyone using audit2allow will
>>>> just end up allowing the permission, not the bounds.
>>>
>>>
>>> As Jason noted, if we fallback to checking for a bounded type, then we
>>> don't strictly need a policy capability for it.
>>
>>
>> It seems as though Dominick is okay with the fallback, what do the
>> rest of the policy folks think about that approach?
>>
>> I'm of the opinion that changes which don't require a new policy
>> capability are slightly more favorable, but since one of the goals
>> with this change is to make policy development easier, I want to make
>> sure we are actually doing that.  It would appear we are, but a few
>> explicit nods from the policy folks would be nice to see.
>
> With my coder hat on, I can see the value of having the existing behavior be
> available for anyone who currently uses it, so it makes sense.
>
> With my policy hat on, I don't have an opinion on a fallback.  What I do
> know is I don't like typebounds, avoid it as much as possible, and strongly
> prefer it not be forced on me.  There are no typebounds in refpolicy.
>
> In fact, I think NNP should not affecting SELinux at all as NNP is
> discretionary and SELinux is mandatory.  NNP makes sense where you start out
> with lots of privileges and have to shed them, (i.e. the Linux
> DAC/capabilities perspective) whereas you have no privileges in SELinux
> except what is explicitly allowed.
>
> Once this permission is implemented I'll likely add the permission across
> most if not all transitions out of systemd.

It seems that falling back to the bounded transition is the best way forward.

Sorry to make you spin another version of the patch Stephen.

-- 
paul moore
www.paul-moore.com
