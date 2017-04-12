Received: from [192.168.25.4] (moss-lions [192.168.25.4])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v3CDZ8p7001825
 for <selinux@tycho.nsa.gov>; Wed, 12 Apr 2017 09:35:08 -0400
Subject: Re: [PATCH 0/2] libsepol and checkpolicy: Add ability to expand some
 attributes in binary policy
To: selinux@tycho.nsa.gov
References: <1491933223-18277-1-git-send-email-jwcart2@tycho.nsa.gov>
 <20170412061122.GA3438@markus>
 <eabeefc3-8281-92f1-ae23-f1abbb6e56c3@tycho.nsa.gov>
From: James Carter <jwcart2@tycho.nsa.gov>
Message-ID: <e63b48e6-4535-972f-62bd-9ea53a9863e7@tycho.nsa.gov>
Date: Wed, 12 Apr 2017 09:35:42 -0400
MIME-Version: 1.0
In-Reply-To: <eabeefc3-8281-92f1-ae23-f1abbb6e56c3@tycho.nsa.gov>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 04/12/2017 09:26 AM, James Carter wrote:
> On 04/12/2017 02:11 AM, Dominick Grift wrote:
>> On Tue, Apr 11, 2017 at 01:53:41PM -0400, James Carter wrote:
>>> The number of type attributes included in the binary policy is becomming a
>>> performance issue in some cases.
>>>
>>> This patch set more aggressives removes attributes and gives the options to
>>> expand and remove all auto-generated attributes and all attributes with fewer
>>> than a given amount of attributes assigned.
>>>
>>> Comparison of the number of attributes remaining in the binary policy
>>>      mls   normal  android
>>> org  310     286     255
>>> old  268     251     130
>>> max  154      20      17
>>> min  226     173     119
>>> def  224     170      80
>>> gen  221     170      46
>>> u5   191     112      59
>>>
>>> Org - Number of attributes in the CIL policy
>>> Old - Results without this patch set
>>> Max - Remove the maximum number of attributes: "-G -X 9999"
>>> Min - Remove the minimum number of attributes: "-X 0"
>>> Def - The new defaults for CIL
>>> Gen - Just removing auto-generated attributes: "-G"
>>> U5  - Remove attributes with less than five members: "-X 5"
>>
>> I tried this with my policy:
>>
>> old defaults
>>
>> size: 949K
>> typeattributes: 765
>> types: 1420
>> allow rules: 24812
>>
>> new defaults
>>
>> size: 876K
>> typeattributes: 641
>> types: 1418
>> allow rules: 20998
>>
>> I cannot imagine where the difference went.. every aspect improved. I expected
>> to see some trade-offs instead here.
>>
>
> I hope that the number of types going from 1420 to 1418 is a typo. I don't see
> how my patch set would remove any types, but, if it is, then that is a problem.
>

I should point out that in all of my testing I have not had sediff report any 
differences in allow rules. The only differences that should be seen with this 
patch set is in the attributes that a type is associated with and the attributes 
that are actually defined in the policy. Any change seen outside of the Types 
and Attribute sections of the sediff output would be a bug.

Jim

> With your dssp1-standard policy, I see:
> Before         : 1178K, 9938 attributes, and 534 types
> After (default):  574K, 3209 attributes, and 534 types
> After (-X5)    :  471K, 2206 attributes, and 534 types
>
> Jim
>
>>>
>>>
>>> James Carter (2):
>>>   libsepol/cil: Add ability to expand some attributes in binary policy
>>>   secilc: Add options to control the expansion of attributes
>>>
>>>  libsepol/cil/include/cil/cil.h     |   2 +
>>>  libsepol/cil/src/cil.c             |  12 ++
>>>  libsepol/cil/src/cil_binary.c      | 253 +++++++++++++++++++++++++++----------
>>>  libsepol/cil/src/cil_internal.h    |   7 +-
>>>  libsepol/cil/src/cil_post.c        |  32 +++--
>>>  libsepol/cil/src/cil_resolve_ast.c |  25 ++--
>>>  libsepol/src/libsepol.map.in       |   2 +
>>>  secilc/secil2conf.c                |   2 +
>>>  secilc/secilc.8.xml                |  10 ++
>>>  secilc/secilc.c                    |  31 ++++-
>>>  10 files changed, 275 insertions(+), 101 deletions(-)
>>>
>>> --
>>> 2.7.4
>>>
>>> _______________________________________________
>>> Selinux mailing list
>>> Selinux@tycho.nsa.gov
>>> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
>>> To get help, send an email containing "help" to Selinux-request@tycho.nsa.gov.
>>
>>
>>
>> _______________________________________________
>> Selinux mailing list
>> Selinux@tycho.nsa.gov
>> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
>> To get help, send an email containing "help" to Selinux-request@tycho.nsa.gov.
>>
>
>


-- 
James Carter <jwcart2@tycho.nsa.gov>
National Security Agency
