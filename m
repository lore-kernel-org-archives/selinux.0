Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v7SNVBdA015320
 for <selinux@tycho.nsa.gov>; Mon, 28 Aug 2017 19:31:11 -0400
Received: by mail-pf0-f177.google.com with SMTP id z87so4909628pfi.3
 for <selinux@tycho.nsa.gov>; Mon, 28 Aug 2017 15:18:01 -0700 (PDT)
To: jwcart2 <jwcart2@tycho.nsa.gov>, selinux@tycho.nsa.gov
Cc: dcashman@google.com, jeffv@google.com
References: <20170817180425.141871-1-dcashman@android.com>
 <0a409e77-1d1a-5bf7-e95a-2aea6332d36c@tycho.nsa.gov>
From: Dan Cashman <dcashman@android.com>
Message-ID: <60fa2f98-5d57-d95d-7e05-2ad2c582e327@android.com>
Date: Mon, 28 Aug 2017 15:17:59 -0700
MIME-Version: 1.0
In-Reply-To: <0a409e77-1d1a-5bf7-e95a-2aea6332d36c@tycho.nsa.gov>
Content-Type: text/plain; charset=utf-8; format=flowed
Subject: Re: [PATCH 0/1] RFC: Allow for multiple cil declarations.
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Thanks for the response and sorry for the delay; I was on a long 
excursion to experience less sunlight than in a typical week (went on 
vacation to see the eclipse, among other things), without much connectivity.

On 08/18/2017 10:38 AM, jwcart2 wrote:
> On 08/17/2017 02:04 PM, Daniel Cashman wrote:
>> From: Dan Cashman <dcashman@google.com>
>>
>> In Android O, the SELinux policy was split from a monolithic policy
>> created at build-time for each device into two main components, one
>> on /system and one on /vendor, which get combined at boot.  This
>> introduced several new challenges, including the creation of a need
>> to maintain compatibility between the two policies, i.e. new policy
>> on the /system image needs to work with the /vendor policy that is
>> based on the policy it's replacing, and updates to the /vendor policy
>> need to work with the /system policy.
>>
>> The ultimate goal of this is to allow updates to /system without
>> changing /vendor.  Android currently accomplishes this by exporting
>> 'public' policy types that /vendor policy can use. It makes sure that
>> changes in object labels don't break the /vendor policy by changing all
>> public types into attributes, copying the public policy into the /vendor
>> policy and keepign a mapping between public types and the attributes
>> that are included in the /vendor policy.
>>
>> This leads to complications, though, when trying to use different /system
>> images with the same /vendor image: the /vendor policy might rely on a
>> /system policy to provide a type definition or an attribute definition,
>> but another, non-customized /system policy might not provide it.
>>
> 
> I can see were this can help prevent the policy failing to compile, but 
> it seems like there can still be run time problems. If one system policy 
> defines type A and has rules for type A and another doesn't, then, even 
> if the vendor policy defines type A (so there is no compile error), it 
> would still be missing the right allow rules and it could experience 
> runtime denials.
> 
> That being said, this could be useful in some cases, such as virus 
> scanning in Fedora's policy, where multiple modules would like to use 
> the same type and it might be possible to have more than one of them 
> loaded.
> 
> Jim

We hope to avoid runtime issues by copying the 'public' policy on which 
the policy in the /vendor image may rely into that policy directly.  As 
a result, the allow rules are copied over as well (but the types are 
converted to attributes to attempt to prevent other run-time breakage 
due to changing labels). As an aside, "attribute-izing" can be seen in 
the modifications to cil in libsepol here: 
https://android.googlesource.com/platform/external/selinux/+/master/libsepol/cil/include/cil/android.h 
which I'd also like to begin the process of upstreaming, but view as 
independent of this patch.

It sounds like this would be acceptable in theory, so I'll fix up the 
patch to address your comments and submit again.

Thanks,
Dan
