Received: from [192.168.25.4] (moss-lions [192.168.25.4])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v3CK7Ncd028034
 for <selinux@tycho.nsa.gov>; Wed, 12 Apr 2017 16:07:23 -0400
Subject: Re: [PATCH 0/2] libsepol and checkpolicy: Add ability to expand some
 attributes in binary policy
To: selinux@tycho.nsa.gov
References: <1491933223-18277-1-git-send-email-jwcart2@tycho.nsa.gov>
 <20170412061122.GA3438@markus>
 <eabeefc3-8281-92f1-ae23-f1abbb6e56c3@tycho.nsa.gov>
 <20170412133549.GB3438@markus>
 <c9a50d53-e334-67dd-5d78-9af2b5746fe3@tycho.nsa.gov>
 <20170412191212.GD3438@markus>
From: James Carter <jwcart2@tycho.nsa.gov>
Message-ID: <ab05c219-1a83-df24-e90c-09fc335b0e91@tycho.nsa.gov>
Date: Wed, 12 Apr 2017 16:07:57 -0400
MIME-Version: 1.0
In-Reply-To: <20170412191212.GD3438@markus>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 04/12/2017 03:12 PM, Dominick Grift wrote:
> On Wed, Apr 12, 2017 at 02:20:32PM -0400, James Carter wrote:
>> On 04/12/2017 09:35 AM, Dominick Grift wrote:
>>> On Wed, Apr 12, 2017 at 09:26:17AM -0400, James Carter wrote:
>>>> On 04/12/2017 02:11 AM, Dominick Grift wrote:
>>>>> On Tue, Apr 11, 2017 at 01:53:41PM -0400, James Carter wrote:
>>>>>> The number of type attributes included in the binary policy is becomming a performance issue in some cases.
>>>>>>
>>>>>> This patch set more aggressives removes attributes and gives the options to expand and remove all auto-generated attributes and all attributes with fewer than a given amount of attributes assigned.
>>>>>>
>>>>>> Comparison of the number of attributes remaining in the binary policy
>>>>>>      mls   normal  android
>>>>>> org  310     286     255
>>>>>> old  268     251     130
>>>>>> max  154      20      17
>>>>>> min  226     173     119
>>>>>> def  224     170      80
>>>>>> gen  221     170      46
>>>>>> u5   191     112      59
>>>>>>
>>>>>> Org - Number of attributes in the CIL policy
>>>>>> Old - Results without this patch set
>>>>>> Max - Remove the maximum number of attributes: "-G -X 9999"
>>>>>> Min - Remove the minimum number of attributes: "-X 0"
>>>>>> Def - The new defaults for CIL
>>>>>> Gen - Just removing auto-generated attributes: "-G"
>>>>>> U5  - Remove attributes with less than five members: "-X 5"
>>>>>
>>>>> I tried this with my policy:
>>>>>
>>>>> old defaults
>>>>>
>>>>> size: 949K
>>>>> typeattributes: 765
>>>>> types: 1420
>>>>> allow rules: 24812
>>>>>
>>>>> new defaults
>>>>>
>>>>> size: 876K
>>>>> typeattributes: 641
>>>>> types: 1418
>>>>> allow rules: 20998
>>>>>
>>>>> I cannot imagine where the difference went.. every aspect improved. I expected to see some trade-offs instead here.
>>>>>
>>>>
>>>> I hope that the number of types going from 1420 to 1418 is a typo. I don't
>>>> see how my patch set would remove any types, but, if it is, then that is a
>>>> problem.
>>>>
>>>> With your dssp1-standard policy, I see:
>>>> Before         : 1178K, 9938 attributes, and 534 types
>>>> After (default):  574K, 3209 attributes, and 534 types
>>>> After (-X5)    :  471K, 2206 attributes, and 534 types
>>>>
>>>> Jim
>>>
>>> The test that i did was with dssp2-standard (my current work). So if you want you can see for yourself on github.
>>>
>>> you can then also see that I , with dssp2-standard, still have attributes without types associated with it
>>>
>>> At least:
>>>
>>> seinfo -a | grep adm_subj_type | grep -v service.service | wc -l
>>> 90
>>>
>>
>> Thanks, this was do to an older bug. If an attribute had already been
>> evaluated in an expression, then cil_typeattribute_used() would not be
>> called on it.
>>
>> So now I have for your dssp1-standard policy:
>> Before         : 1178K, 9938 attributes, and 534 types
>> After (default):  420K, 1621 attributes, and 534 types
>> After (-X5)    :  275K,  248 attributes, and 534 types
>
> The above is where my dssp1 model really shines. These stats are what i envisioned when I started to design it at first, I abandoned it because of this bug but also because of one other fundamental limitation:
>
> namely that one cannot associate typeattributes in booleanif. Is this really something that we cannot overcome?
>

Sorry, but that would be very difficult to do in the kernel policy.

What were you trying to accomplish with them?

Jim

>>
>> So now I have for your dssp2-standard policy:
>> Before         :  918K, 772 attributes, and 1426 types
>> After (default):  889K, 551 attributes, and 1426 types
>> After (-X5)    :  901K, 160 attributes, and 1426 types
>>
>> And:
>> seinfo -a policy.30 | grep adm_subj_type | grep -v service.service | wc -l
>> 0
>>
>> Jim
>>
>>>>
>>>>>>
>>>>>>
>>>>>> James Carter (2):
>>>>>>   libsepol/cil: Add ability to expand some attributes in binary policy
>>>>>>   secilc: Add options to control the expansion of attributes
>>>>>>
>>>>>>  libsepol/cil/include/cil/cil.h     |   2 +
>>>>>>  libsepol/cil/src/cil.c             |  12 ++
>>>>>>  libsepol/cil/src/cil_binary.c      | 253 +++++++++++++++++++++++++++----------
>>>>>>  libsepol/cil/src/cil_internal.h    |   7 +-
>>>>>>  libsepol/cil/src/cil_post.c        |  32 +++--
>>>>>>  libsepol/cil/src/cil_resolve_ast.c |  25 ++--
>>>>>>  libsepol/src/libsepol.map.in       |   2 +
>>>>>>  secilc/secil2conf.c                |   2 +
>>>>>>  secilc/secilc.8.xml                |  10 ++
>>>>>>  secilc/secilc.c                    |  31 ++++-
>>>>>>  10 files changed, 275 insertions(+), 101 deletions(-)
>>>>>>
>>>>>> --
>>>>>> 2.7.4
>>>>>>
>>>>>> _______________________________________________
>>>>>> Selinux mailing list
>>>>>> Selinux@tycho.nsa.gov
>>>>>> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
>>>>>> To get help, send an email containing "help" to Selinux-request@tycho.nsa.gov.
>>>>>
>>>>>
>>>>>
>>>>> _______________________________________________
>>>>> Selinux mailing list
>>>>> Selinux@tycho.nsa.gov
>>>>> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
>>>>> To get help, send an email containing "help" to Selinux-request@tycho.nsa.gov.
>>>>>
>>>>
>>>>
>>>> --
>>>> James Carter <jwcart2@tycho.nsa.gov>
>>>> National Security Agency
>>>> _______________________________________________
>>>> Selinux mailing list
>>>> Selinux@tycho.nsa.gov
>>>> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
>>>> To get help, send an email containing "help" to Selinux-request@tycho.nsa.gov.
>>>
>>>
>>>
>>> _______________________________________________
>>> Selinux mailing list
>>> Selinux@tycho.nsa.gov
>>> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
>>> To get help, send an email containing "help" to Selinux-request@tycho.nsa.gov.
>>>
>>
>>
>> --
>> James Carter <jwcart2@tycho.nsa.gov>
>> National Security Agency
>> _______________________________________________
>> Selinux mailing list
>> Selinux@tycho.nsa.gov
>> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
>> To get help, send an email containing "help" to Selinux-request@tycho.nsa.gov.
>
>
>
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to Selinux-request@tycho.nsa.gov.
>


-- 
James Carter <jwcart2@tycho.nsa.gov>
National Security Agency
