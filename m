Message-ID: <53BFFC89.3060408@tresys.com>
Date: Fri, 11 Jul 2014 11:02:33 -0400
From: Steve Lawrence <slawrence@tresys.com>
MIME-Version: 1.0
To: Dominick Grift <dominick.grift@gmail.com>, Stephen Smalley
 <sds@tycho.nsa.gov>
Subject: Re: [RFC] Source Policy, CIL, and High Level Languages
References: <53BD9646.6030303@tresys.com>
 <1404975079.31209.11.camel@x220.localdomain> <53BE889C.9050909@tycho.nsa.gov>
 <1404996778.661.4.camel@x220.localdomain>
 <1404997743.661.7.camel@x220.localdomain> <53BE9148.3090907@tycho.nsa.gov>
 <1404998783.661.10.camel@x220.localdomain> <53BE9771.3000708@tycho.nsa.gov>
 <1404999908.661.11.camel@x220.localdomain>
In-Reply-To: <1404999908.661.11.camel@x220.localdomain>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: SELinux List <selinux@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 07/10/2014 09:45 AM, Dominick Grift wrote:
> On Thu, 2014-07-10 at 09:38 -0400, Stephen Smalley wrote:
>> On 07/10/2014 09:26 AM, Dominick Grift wrote:
>>> On Thu, 2014-07-10 at 09:12 -0400, Stephen Smalley wrote:
>>>> On 07/10/2014 09:09 AM, Dominick Grift wrote:
>>>>> On Thu, 2014-07-10 at 14:52 +0200, Dominick Grift wrote:
>>>>>> On Thu, 2014-07-10 at 08:35 -0400, Stephen Smalley wrote:
>>>>>>
>>>>>> <snip>
>>>>>>
>>>>>>> Thanks for testing it.  How did it look from a performance POV, wrt
>>>>>>> memory use and runtime?
>>>>>>>
>>>>>>
>>>>>> I have not (yet) really focused on that but i suppose there was no real
>>>>>> noticeable slow down or speed up.
>>>>>>
>>>>>> Any tips on how i could provide useful benchmarks?
>>>>>>
>>>>>> I suppose i could enable the neverallow check
>>>>>> in /etc/selinux/semanage.conf and i would bet it is now much faster than
>>>>>> it used to be (in fact ill try that)
>>>>>>
>>>>>>
>>>>>
>>>>> I suspect i was lying.
>>>>>
>>>>> I am installing a guest with similar specs now and same software except
>>>>> the cil mods and then do some comparison.
>>>>>
>>>>> i suppose stuff like time semodule -B
>>>>> and looking at top
>>>>>
>>>>> I did do a semodule -B with checking for neverallow rules but that found
>>>>> a violation really fast (thanks fedora). So although i cant really say
>>>>> how much faster that is , it is pretty safe to assume its much faster
>>>>> now
>>>>
>>>> /usr/bin/time setsebool -P httpd_can_network_connect=1
>>>> valgrind --tool=massif setsebool -P httpd_can_network_connect=1
>>>> ms_print massif.out.<pid>
>>>>
>>>>
>>>>
>>>
>>> Will do that next.
>>>
>>> I did a time semodule -B on similar configs (2 cores/2GB ram):
>>>
>>> Result: cil seems faster but seems to take more memory:
>>>
>>> CIL: real 0m13.XXXs (23% mem (of 2 GB)
>>> REGULAR: real 0m21.XXXs (15% mem (of 2 GB)
>>
>> So, that's a concern, as we already have various bug reports on semodule
>> and setsebool being killed by the OOM killer, e.g.
>> https://bugzilla.redhat.com/show_bug.cgi?id=1098446
>>
>>
> valgrind output:
> 
> http://paste.fedoraproject.org/116966/4999755/
> 

We just pushed a commit to CIL that greatly reduces peak memory usage.
Some quick testing brings the peak memory usage of compiling Fedora's
policy from around 460MB down to around 260MB. So I think its now about
on par with current userspace. We're also working on some other changes,
but those require a bit more work and so might take a little longer. But
I don't think those changes will get memory usage down significantly
more (maybe down another 10-20MB), so I doubt this will do a whole lot
in solving the OOM killer issue.

- Steve
