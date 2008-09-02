Message-ID: <48BCC591.3000101@redhat.com>
Date: Tue, 02 Sep 2008 14:48:17 +1000
From: Murray McAllister <mmcallis@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: user guide draft: "SELinux Contexts and Attributes" review
References: <48B4FA3E.3000602@redhat.com> <1219844836.5708.92.camel@moss-spartans.epoch.ncsc.mil> <48BB93D2.8090909@redhat.com> <48BCB564.4010404@redhat.com>
In-Reply-To: <48BCB564.4010404@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Murray McAllister wrote:
> Murray McAllister wrote:
> 
>>>> type: The type is an attribute of Type Enforcement. The type defines 
>>>> a domain type for subjects, and a type for objects. SELinux policy 
>>>> rules define how types access each other, whether it be a domain 
>>>> accessing a type, or a domain accessing another domain. Access is 
>>>> only allowed if a specific rule exists that allows it.
>>>>
>>>> category: The category is an attribute of Multi-Level Security (MLS) 
>>>> and Multi-Category Security (MCS). Categories are used to categorize 
>>>> data, and identify its sensitivity or security level. Standard 
>>>> SELinux policy supports MCS; however, it is not heavily used. MCS 
>>>> allows users, at their own discretion, to add a category to a piece 
>>>> of data, for example, PatientRecord or CompanyConfidential. There is 
>>>> only a single security level, s0. MLS labels data with both 
>>>> categories (CompanyConfidential) and a sensitivity level. MLS 
>>>> enforces the Bell-LaPadula Mandatory Access Model, and is used in 
>>>> Labeled Security Protection Profile (LSPP) environments.
>>>
>>> Again, this should be level or range rather than just category, where a
>>> level is a sensitivity and an optional list of categories and a range is
>>> a current/low level and a clearance/high level.  You may wish to note
>>> that people who wish to use the MLS restrictions need to install a
>>> separate -mls policy package and make it the default.
>>
> 
> How about:
> 
> The security level is an attribute of MLS and Multi-Category Security 
> (MCS). The first part of the security level is the sensitivity, for 
> example, s0 is a sensitivity. The s0 sensitivity is the only sensitivity 
> used when running the SELinux targeted policy. Optionally, the security 
> level can have a list of categories. Categories are used to categorize 
> data and add an extra level of security. If a user does not have access 
> to the same or higher categories than an object, and DAC and SELinux 
> rules allow access, access to that object is denied. 

I keep getting MLS and MCS mixed up. Should this be "If a user does not 
have access to same categories as the object is labeled with"?

Apologies for all the spam.


For example, if a
> user only has access to the c0 category, and an object is labeled with 
> the c1 category, access is denied. Security levels can be translated to 
> an easier-to-read form, such as CompanyConfidential. For an example list 
> of security levels and their translations, refer to the 
> /etc/selinux/targeted/setrans.conf file.
> 
> When running the SELinux MLS policy, a sensitivity and categories are 
> compulsory. MLS allows sensitivities s0 through to s9. MLS enforces the 
> Bell-LaPadula Mandatory Access Model[1], and is used in Labeled Security 
> Protection Profile (LSPP) environments. To use MLS restrictions, install 
> the selinux-policy-mls package, and configure MLS to be the default 
> SELinux policy.
> 
> 
> from semanage login -l, is the range the "s0-s0" part of the MLS/MCS 
> label? And in MLS, this could be something like "s0-s3"?
> 
> 
> [1] http://en.wikipedia.org/wiki/Bell-LaPadula_model
> 
>> This part is in progress. I do not understand the difference between 
>> levels/categories and ranges. Can you recommend any papers or books on 
>> this? This is what is there now, keeping in mind I don't understand:
>>
>> The level is an attribute of MLS and Multi-Category Security (MCS). 
>> There is a single sensitivity level, s0, which is the only sensitivity 
>> level used. This level is used when running the SELinux MLS policy, 
>> but not when running the SELinux targeted policy. An optional list of 
>> categories can be used to categorize data. Standard SELinux policy 
>> supports MCS; however, it is not heavily used. MCS allows users, at 
>> their own discretion, to add a category to a piece of data, for 
>> example, CompanyConfidential or PatientRecord. MLS labels data with 
>> both a sensitivity level and categories (such as CompanyConfidential). 
>> MLS enforces the Bell-LaPadula Mandatory Access Model, and is used in 
>> Labeled Security Protection Profile (LSPP) environments. To use MLS 
>> restrictions, install the selinux-policy-mls package, and configure 
>> MLS to be the default SELinux policy.
> 
> -- 
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov 
> with
> the words "unsubscribe selinux" without quotes as the message.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
