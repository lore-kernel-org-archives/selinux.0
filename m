Message-ID: <53BDB5FD.6060207@redhat.com>
Date: Wed, 09 Jul 2014 17:37:01 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>, Steve Lawrence <slawrence@tresys.com>,
 Dominick Grift <dominick.grift@gmail.com>
Subject: Re: secilc: is anyone able to confirm that type_change ...
References: <1404563967.9852.42.camel@x220.localdomain>	
 <1404652323.9852.49.camel@x220.localdomain> <53BAA801.8070308@tresys.com>	
 <1404743060.9852.50.camel@x220.localdomain>
 <1404744312.9852.55.camel@x220.localdomain> <53BC44BB.6000708@tresys.com>
 <53BC47F4.5030205@tycho.nsa.gov> <53BD5B4A.5070405@redhat.com>
 <53BD5D63.5090908@tycho.nsa.gov> <53BD612B.4000200@tycho.nsa.gov>
In-Reply-To: <53BD612B.4000200@tycho.nsa.gov>
Content-Type: text/plain; charset=ISO-8859-1
Cc: selinux@tycho.nsa.gov
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


On 07/09/2014 11:35 AM, Stephen Smalley wrote:
> On 07/09/2014 11:18 AM, Stephen Smalley wrote:
>> On 07/09/2014 11:10 AM, Daniel J Walsh wrote:
>>> On 07/08/2014 03:35 PM, Stephen Smalley wrote:
>>>> On 07/08/2014 03:21 PM, Steve Lawrence wrote:
>>>>> On 07/07/2014 10:45 AM, Dominick Grift wrote:
>>>>>> On Mon, 2014-07-07 at 16:24 +0200, Dominick Grift wrote:
>>>>>>> On Mon, 2014-07-07 at 10:00 -0400, Steve Lawrence wrote:
>>>>>>>
>>>>>>>> I can't reproduce the problem with my test policies. The typechange
>>>>>>>> statements look like they are correctly inserted into the binary and I
>>>>>>>> am seeing the expected type changes at runtime.
>>>>>>>>
>>>>>>>> Is this with your monogam policy?
>>>>>>>>
>>>>>>> No, that one is no longer maintained.
>>>>>>>
>>>>>>> It is this very small base policy:
>>>>>>>
>>>>>>> https://github.com/doverride/e145
>>>>>>>
>>>>>> Note though, with that version, that there is no type_change rule from
>>>>>> devpts_t to device_session_pts_t currently (so if you were to test this
>>>>>> with sshd then it would be lacking the type change rule)
>>>>>>
>>>>>> Either insert that type_change rule manually or test it with the (local)
>>>>>> login program since there is a type_change session_t
>>>>>> device_tty_t:chr_file device_session_tty_t rule present.
>>>>>>
>>>>>> There is also a conditional type change rule for console_device_t to
>>>>>> device_session_tty_t.
>>>>>>
>>>>>> I cannot imagine me having overlooked anything. Since there are only two
>>>>>> domains (system_t and session_t), and both are virtually unconfined.
>>>>>>
>>>>>>
>>>>> Ok, finally managed to track down this issue. Turns out to be an
>>>>> ordering problem. You have your classes listed in alphabetical order.
>>>>> Order shouldn't matter with CIL and everything should work correctly,
>>>>> and in most cases is does. However, we assign integer values to each
>>>>> class based on the order we see them. So the first one we see gets value
>>>>> 1, second gets 2, etc. If these values don't match up with what
>>>>> userspace and the kernel expect them to be, things break.
>>>> Kernel and newer userspace code performs dynamic lookup of class/perm
>>>> values from strings and handles mapping their own internal indices to
>>>> the policy-defined values.  So this points to a need to update
>>>> pam_selinux and other older code to map via string_to_security_class().
>>> Lets open a bugzilla on this.
>> Probably need to crawl the fedora source tree and look for any #include
>> <selinux/flask.h> or #include <selinux/av_permissions.h> references to
>> identify all packages that need to be updated.
> Or we could be evil and delete those two header files altogether, or be
> a bit nicer and put #warning or #error in them.
I like this idea.  This would catch places that we have missed.  Could
be done in Rawhide.
> I see we also wrongly use a hardcoded class in
> libselinux/src/setexecfilecon.c; should fix that one too.
>
>   For permission checks,
>> can just switch over to using selinux_check_access() in most cases and
>> then all the string lookups are handled for you as well as all of the
>> ugliness of dealing with the AVC.  May want new wrapper functions for
>> security_compute_* that take the class as a string and internally call
>> string_to_security_class() that can be used instead.
>>
>>
>> _______________________________________________
>> Selinux mailing list
>> Selinux@tycho.nsa.gov
>> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
>> To get help, send an email containing "help" to Selinux-request@tycho.nsa.gov.
>>
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to Selinux-request@tycho.nsa.gov.
>
>
