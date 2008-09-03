Message-ID: <48BE28D5.1080902@redhat.com>
Date: Wed, 03 Sep 2008 16:04:05 +1000
From: Murray McAllister <mmcallis@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: user guide draft: "SELinux Contexts and Attributes" review
References: <48B4FA3E.3000602@redhat.com>	 <1219844836.5708.92.camel@moss-spartans.epoch.ncsc.mil>	 <48BB93D2.8090909@redhat.com>  <48BCB564.4010404@redhat.com> <1220360985.26711.43.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1220360985.26711.43.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> On Tue, 2008-09-02 at 13:39 +1000, Murray McAllister wrote:
>> How about:
>>
>> The security level is an attribute of MLS and Multi-Category Security 
>> (MCS). The first part of the security level is the sensitivity, for 
>> example, s0 is a sensitivity. The s0 sensitivity is the only sensitivity 
>> used when running the SELinux targeted policy. Optionally, the security 
>> level can have a list of categories. Categories are used to categorize 
>> data and add an extra level of security. If a user does not have access 
>> to the same or higher categories than an object, and DAC and SELinux 
>> rules allow access, access to that object is denied. For example, if a 
>> user only has access to the c0 category, and an object is labeled with 
>> the c1 category, access is denied. Security levels can be translated to 
>> an easier-to-read form, such as CompanyConfidential. For an example list 
>> of security levels and their translations, refer to the 
>> /etc/selinux/targeted/setrans.conf file.
>>
>> When running the SELinux MLS policy, a sensitivity and categories are 
>> compulsory. MLS allows sensitivities s0 through to s9.
> 
> I think they go up to s15 in the -mls policy configuration, although it
> is all defined as part of the policy configuration and there is no
> implementation-defined hard limit.
> 
>>  MLS enforces the 
>> Bell-LaPadula Mandatory Access Model[1], and is used in Labeled Security 
>> Protection Profile (LSPP) environments. To use MLS restrictions, install 
>> the selinux-policy-mls package, and configure MLS to be the default 
>> SELinux policy.
> 
> Caveat:  the -mls policy as shipped by Fedora/RH intentionally omits
> many program domains that were not part of the evaluated configuration,
> and thus is not usable on a desktop workstation (no X support).  However
> you can build a mls policy from the upstream refpolicy that includes all
> program domains.
> 
>> from semanage login -l, is the range the "s0-s0" part of the MLS/MCS 
>> label? And in MLS, this could be something like "s0-s3"?
> 
> Yes, s0-s0 is a MLS/MCS range where the low level and the high level are
> identical.  It could just as easily be written as just "s0" since that
> implies s0-s0.
> 

How about:

The level is an attribute of MLS and Multi-Category Security (MCS). The 
first part of the level, s0-s0, is the sensitivity. The s0 sensitivity 
is the only sensitivity used for MCS. Since the format of the level is 
the same for MLS and MCS, and MLS supports ranges of sensitivities, a 
sensitivity such as s0-s0 is the same as s0 when using MCS. Optionally, 
the level can have a list of categories. Categories are used to 
categorize data and add an extra level of security. Fedora 10 supports 
1024 different categories: c0 through to c1023. If a user is not 
authorized for all of the categories of an object, and DAC and SELinux 
rules allow access, access is denied. For example, if a user is only 
authorized for the c0 category, and an object is labeled with the c0 and 
c1 categories, access is denied. If a user is authorized for the c0 and 
c1 categories, and an object is only labeled with the c0 category, 
access is allowed. Levels can be translated to an easier-to-read form, 
such as CompanyConfidential. For an example list of levels and their 
translations, refer to the /etc/selinux/targeted/setrans.conf file.

MLS allows ranges of sensitivities, not just s0. MLS enforces the 
Bell-LaPadula Mandatory Access Model, and is used in Labeled Security 
Protection Profile (LSPP) environments. To use MLS restrictions, install 
the selinux-policy-mls package, and configure MLS to be the default 
SELinux policy. The MLS policy shipped with Fedora omits many program 
domains that were not part of the evaluated configuration, and 
therefore, MLS on a desktop workstation is unusable (no support for the 
X Window System); however, an MLS policy from the upstream SELinux 
reference policy[1] can be built that includes all program domains.

I left out details to try to limit mistakes...

[1] http://oss.tresys.com/projects/refpolicy

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
