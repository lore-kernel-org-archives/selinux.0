Message-ID: <53BC47F4.5030205@tycho.nsa.gov>
Date: Tue, 08 Jul 2014 15:35:16 -0400
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: Steve Lawrence <slawrence@tresys.com>,
 Dominick Grift <dominick.grift@gmail.com>
Subject: Re: secilc: is anyone able to confirm that type_change ...
References: <1404563967.9852.42.camel@x220.localdomain>	
 <1404652323.9852.49.camel@x220.localdomain> <53BAA801.8070308@tresys.com>	
 <1404743060.9852.50.camel@x220.localdomain>
 <1404744312.9852.55.camel@x220.localdomain> <53BC44BB.6000708@tresys.com>
In-Reply-To: <53BC44BB.6000708@tresys.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: selinux@tycho.nsa.gov
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 07/08/2014 03:21 PM, Steve Lawrence wrote:
> On 07/07/2014 10:45 AM, Dominick Grift wrote:
>> On Mon, 2014-07-07 at 16:24 +0200, Dominick Grift wrote:
>>> On Mon, 2014-07-07 at 10:00 -0400, Steve Lawrence wrote:
>>>
>>>> I can't reproduce the problem with my test policies. The typechange
>>>> statements look like they are correctly inserted into the binary and I
>>>> am seeing the expected type changes at runtime.
>>>>
>>>> Is this with your monogam policy?
>>>>
>>>
>>> No, that one is no longer maintained.
>>>
>>> It is this very small base policy:
>>>
>>> https://github.com/doverride/e145
>>>
>>
>> Note though, with that version, that there is no type_change rule from
>> devpts_t to device_session_pts_t currently (so if you were to test this
>> with sshd then it would be lacking the type change rule)
>>
>> Either insert that type_change rule manually or test it with the (local)
>> login program since there is a type_change session_t
>> device_tty_t:chr_file device_session_tty_t rule present.
>>
>> There is also a conditional type change rule for console_device_t to
>> device_session_tty_t.
>>
>> I cannot imagine me having overlooked anything. Since there are only two
>> domains (system_t and session_t), and both are virtually unconfined.
>>
>>
> 
> Ok, finally managed to track down this issue. Turns out to be an
> ordering problem. You have your classes listed in alphabetical order.
> Order shouldn't matter with CIL and everything should work correctly,
> and in most cases is does. However, we assign integer values to each
> class based on the order we see them. So the first one we see gets value
> 1, second gets 2, etc. If these values don't match up with what
> userspace and the kernel expect them to be, things break.

Kernel and newer userspace code performs dynamic lookup of class/perm
values from strings and handles mapping their own internal indices to
the policy-defined values.  So this points to a need to update
pam_selinux and other older code to map via string_to_security_class().

> So the temporary solution is to reorder your class statements so that
> they are in the order defined in flask.h [1] so they get the right values.
> 
> The long term solution is to add a new statement to CIL (classorder,
> similar to sidorder) that defines this order, allowing the class
> definitions to appear in any order.
> 
> Thanks,
> - Steve
> 
> [1]
> https://github.com/SELinuxProject/selinux/blob/master/libselinux/include/selinux/flask.h
