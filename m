Message-ID: <53BEAB1D.40502@tycho.nsa.gov>
Date: Thu, 10 Jul 2014 11:02:53 -0400
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: Dominick Grift <dominick.grift@gmail.com>
Subject: Re: [RFC] Source Policy, CIL, and High Level Languages
References: <53BD9646.6030303@tresys.com>
 <1404975079.31209.11.camel@x220.localdomain> <53BE889C.9050909@tycho.nsa.gov>
 <1404996778.661.4.camel@x220.localdomain>
 <1404997743.661.7.camel@x220.localdomain> <53BE9148.3090907@tycho.nsa.gov>
 <1404998783.661.10.camel@x220.localdomain>
In-Reply-To: <1404998783.661.10.camel@x220.localdomain>
Content-Type: text/plain; charset=ISO-8859-1
Cc: SELinux List <selinux@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 07/10/2014 09:26 AM, Dominick Grift wrote:
> On Thu, 2014-07-10 at 09:12 -0400, Stephen Smalley wrote:
>> On 07/10/2014 09:09 AM, Dominick Grift wrote:
>>> On Thu, 2014-07-10 at 14:52 +0200, Dominick Grift wrote:
>>>> On Thu, 2014-07-10 at 08:35 -0400, Stephen Smalley wrote:
>>>>
>>>> <snip>
>>>>
>>>>> Thanks for testing it.  How did it look from a performance POV, wrt
>>>>> memory use and runtime?
>>>>>
>>>>
>>>> I have not (yet) really focused on that but i suppose there was no real
>>>> noticeable slow down or speed up.
>>>>
>>>> Any tips on how i could provide useful benchmarks?
>>>>
>>>> I suppose i could enable the neverallow check
>>>> in /etc/selinux/semanage.conf and i would bet it is now much faster than
>>>> it used to be (in fact ill try that)
>>>>
>>>>
>>>
>>> I suspect i was lying.
>>>
>>> I am installing a guest with similar specs now and same software except
>>> the cil mods and then do some comparison.
>>>
>>> i suppose stuff like time semodule -B
>>> and looking at top
>>>
>>> I did do a semodule -B with checking for neverallow rules but that found
>>> a violation really fast (thanks fedora). So although i cant really say
>>> how much faster that is , it is pretty safe to assume its much faster
>>> now
>>
>> /usr/bin/time setsebool -P httpd_can_network_connect=1
>> valgrind --tool=massif setsebool -P httpd_can_network_connect=1
>> ms_print massif.out.<pid>
>>
>>
>>
> 
> Will do that next.
> 
> I did a time semodule -B on similar configs (2 cores/2GB ram):
> 
> Result: cil seems faster but seems to take more memory:
> 
> CIL: real 0m13.XXXs (23% mem (of 2 GB)
> REGULAR: real 0m21.XXXs (15% mem (of 2 GB)

For /usr/bin/time semodule -i test_policy.pp (from selinux-testsuite), I
see:
#integration (i.e. CIL): 6.24user 1.00system 0:07.30elapsed 99%CPU
(0avgtext+0avgdata 464480maxresident)k

#next (i.e. regular/upstream): 24.31user 0.88system 0:25.37elapsed
99%CPU (0avgtext+0avgdata 300792maxresident)k

That seems like a significant speed-up but it is more expensive in
memory use.

This is with up-to-date Fedora 20 policy, no customization of
semanage.conf.
