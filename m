Message-ID: <45A6C97C.3040001@us.ibm.com>
Date: Thu, 11 Jan 2007 17:34:20 -0600
From: Michael C Thompson <thompsmc@us.ibm.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: SE Linux <selinux@tycho.nsa.gov>, Klaus Weidner <klaus@atsec.com>
Subject: Re: [RFC] clarifications for -l to newrole.1
References: <45A6A064.2040707@us.ibm.com> <1168549320.7993.458.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1168549320.7993.458.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> On Thu, 2007-01-11 at 14:39 -0600, Michael C Thompson wrote:
>> Based on some discussion from irc and some complaints I have received,
>> I'm proposing this addition (comments or other suggestions welcome) to
>> the newrole manage. This example section would slot in right after the
>> DESCRIPTION section. Patch below.
>>
>> EXAMPLE
>>         Changing sensitivity only:
>>            # id -Z
>>            user:role:type:SystemLow-SystemHigh
>>            # newrole -l Unclassified
>>            # id -Z
>>            user:role:type:Unclassified-SystemHigh
> 
> How does SystemLow differ from Unclassified here (in meaning, not just
> value)?  If SystemLow is supposed to be a special label for system
> objects, then why have users login at that level at all?

There wasn't any specific meaning with that, if it would be preferable, 
it can go from Unclassified to Secret, or whatever people would like to see.

>>         Changing sensitivity and clearance:
>>            # id -Z
>>            user:role:type:SystemLow-SystemHigh
>>            # newrole -l Unclassified-Unclassified
>>            # id -Z
>>            user:role:type:Unclassified-Unclassified
> 
> When would you envision a user doing the above?  Trying to ensure that
> any process he subsequently starts cannot escalate to higher levels?

That seems reasonable, since, tbh, I hadn't really thought of a 
use-case. I just know that should the desire be there to change the 
clearance, this would show how to do it.... it is also inaccurate, since 
"user:role:type:Unclassified-Unclassified" would be condensed down to 
"user:role:type:Unclassified".

> If you are going to provide an example, use real output (i.e. not just
> user:role:type).  Please include an example of changing roles too since
> that is more common.  Also, fix the SEE ALSO list please (runas ->
> runcon, and drop su as it is no longer relevant).

Will do. I'll take an example from the current LSPP work.

> AUTHORS list is also badly out of date there.  Let's see...you, Dan
> Walsh, Steve Grubb, and Darrel Goeddel should likely be added, and while
> the earlier authors should be retained, their email addresses are
> obsolete and should be dropped.

OK, will include that in the patch.

Thanks,
Mike


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
