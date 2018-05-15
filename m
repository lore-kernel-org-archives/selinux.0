From: Stephen Smalley <sds@tycho.nsa.gov>
To: Casey Schaufler <casey@schaufler-ca.com>,
 Stephen Smalley <stephen.smalley@gmail.com>
Cc: selinux <selinux@tycho.nsa.gov>, Paul Moore <paul@paul-moore.com>
References: <991a548d-1cdc-5e15-89d9-a36a557429d2@schaufler-ca.com>
 <CAB9W1A1=mRMn_HuUu-Qsxy8goWMW1C3U5eCOTWV1JSj2+9F2BA@mail.gmail.com>
 <ae956be3-3fef-3b87-53b3-75779d3f5286@schaufler-ca.com>
 <d44677e9-65dc-969a-4162-97c447740d2c@tycho.nsa.gov>
Message-ID: <66b82a04-52af-f7aa-98ba-8bb344da850c@tycho.nsa.gov>
Date: Tue, 15 May 2018 08:57:42 -0400
MIME-Version: 1.0
In-Reply-To: <d44677e9-65dc-969a-4162-97c447740d2c@tycho.nsa.gov>
Content-Type: text/plain; charset=utf-8
Subject: Re: Anyone using the SELinux test suite on Fedora 28?
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 05/15/2018 08:28 AM, Stephen Smalley wrote:
> On 05/14/2018 08:10 PM, Casey Schaufler wrote:
>> On 5/14/2018 4:48 PM, Stephen Smalley wrote:
>>> It's been running fine for me. Maybe you just need to clean your tree and do a fresh make test.
>>
>> Did that first thing.
>>
>> Digging down, I find that the "make -C policy load" is failing.
>>
>> make[1]: Leaving directory '/home/cschaufler/SELinux/selinux-testsuite/policy/test_policy'
>> # General policy load
>> /usr/sbin/semodule -i test_policy/test_policy.pp
>> neverallow check failed at /var/lib/selinux/targeted/tmp/modules/100/base/cil:4703
>>   (neverallow base_typeattr_6 base_typeattr_7 (process (fork transition sigchld sigkill sigstop signull signal ptrace getsched setsched getsession getpgid setpgid getcap setcap share getattr setexec setfscreate noatsecure siginh setrlimit rlimitinh dyntransition setcurrent execmem execstack execheap setkeycreate setsockcreate getrlimit)))
>>     <root>
>>     allow at /var/lib/selinux/targeted/tmp/modules/400/test_policy/cil:2565
>>       (allow test_create_no_t unconfined_t (process (sigchld)))
>>     <root>
>>     allow at /var/lib/selinux/targeted/tmp/modules/400/test_policy/cil:2569
>>       (allow test_create_no_t self (process (transition sigchld sigkill sigstop signull signal ptrace getsched setsched getsession getpgid setpgid getcap setcap share getattr setexec setfscreate noatsecure siginh setrlimit rlimitinh dyntransition setcurrent execmem execstack execheap setkeycreate setsockcreate getrlimit)))
>>     <root>
>>     allow at /var/lib/selinux/targeted/tmp/modules/400/test_policy/cil:2606
>>       (allow test_create_no_t self (process (setexec)))
>>     <root>
>>     allow at /var/lib/selinux/targeted/tmp/modules/400/test_policy/cil:2634
>>       (allow test_create_d sysadm_t (process (sigchld)))
>>
>> I bet the reason it's doing this is obvious. Just not to me.
> 
> Add or uncomment expand-check = 0 in /etc/selinux/semanage.conf.
> That's noted in the README but used to be the default in Fedora (changed in 28).

Also, just FYI, expand-check controls whether neverallow and type bounds checking is performed when the policy
is linked/expanded.  The test policy necessarily violates some of these policy assertions in order to test the
kernel functionality, and thus we have to disable the userspace checking when installing the test policy.  Fedora
used to disable this checking anyway (except when the policy is built as a package) because it was a) slow and
b) could prevent users from installing local policy modules that would violate these assertions (but might be
necessary to fix some issue they had).

> 
>>
>>> On Mon, May 14, 2018, 7:37 PM Casey Schaufler <casey@schaufler-ca.com <mailto:casey@schaufler-ca.com>> wrote:
>>>
>>>     Has anyone had success with the SELinux test suite on Fedora 28?
>>>     I find the chcon and newrole are unhappy with the contexts used
>>>     in the suite.
>>>
>>>
>>
> 
