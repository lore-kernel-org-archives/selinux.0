Subject: Re: Security context of shared libraries
To: mm19827 <mm19827@gmail.com>, selinux@tycho.nsa.gov
References: <f195719b-bab5-6a83-0a13-8d62c077e808@gmail.com>
 <8ff395c1-f0cd-061f-fb26-2bba74eb32d7@tycho.nsa.gov>
 <95ad1d72-8c8c-29eb-531c-e42dd02f6a19@gmail.com>
 <8e4c976b-8608-4331-fe4d-251db6763b0b@tycho.nsa.gov>
 <5abc1601-678f-0d76-e800-789941f5c22b@gmail.com>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <d20db309-43e4-adcf-04e2-407290d52b93@tycho.nsa.gov>
Date: Mon, 7 Nov 2016 10:01:39 -0500
MIME-Version: 1.0
In-Reply-To: <5abc1601-678f-0d76-e800-789941f5c22b@gmail.com>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 11/07/2016 09:50 AM, mm19827 wrote:
> 
> 
> On 11/07/2016 03:35 PM, Stephen Smalley wrote:
>>
>>> Moreover, in order not to compromise the functionality of /bin/bar, I
>>> would need to allow bar_t the same access as unconfined_t (at least as a
>>> first approximation). The fact is that, although I can trust /bin/bar,
>>> it is not selinux-aware.
>>
>> I wouldn't do that; otherwise any security gains you are getting are
>> illusory since bar is equivalent to unconfined.  It isn't that hard to
>> define a real confined domain for a program.
> 
> I agree that defining a real confined domain for /bin/bar is a better
> approach.
> It is not clear to me that any security gains would be illusory: even if
> /bin/bar (from bar_t) has effectively unconfined access, still /bin/foo
> (i.e. foo_t) could only access bar_t, and not unconfined_t.

I suppose that's true, depending on what it is that you have to allow
between foo_t and bar_t, e.g. you can allow foo_t to connect to a bar_t
socket or similar without allowing it to connect to unconfined_t
sockets. If you truly want bar_t to be unconfined, you can always just
have it call the unconfined_domain() interface in refpolicy, e.g.
unconfined_domain(bar_t), and it will inherit all of the unconfined
domain rules.

>>
>> Generally the simplest approach is to define a stub .te file for your
>> domain, include a permissive declaration for it (permissive bar_t;), and
>> then derive a policy from the resulting avc:
> Thanks for the hint of the stub .te file.
> The only issue here is that I would need to find a way to trigger all
> possible avc's from /bin/bar, which is not straightforward.

Yes, it is better if you have some idea of the expected functionality of
bar, whether from source code, static analysis of the binary, strace, or
documentation, and can then define up front policy that corresponds.
