Subject: Re: Security context of shared libraries
To: mm <mm19827@gmail.com>, selinux@tycho.nsa.gov
References: <f195719b-bab5-6a83-0a13-8d62c077e808@gmail.com>
 <8ff395c1-f0cd-061f-fb26-2bba74eb32d7@tycho.nsa.gov>
 <95ad1d72-8c8c-29eb-531c-e42dd02f6a19@gmail.com>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <8e4c976b-8608-4331-fe4d-251db6763b0b@tycho.nsa.gov>
Date: Mon, 7 Nov 2016 09:35:44 -0500
MIME-Version: 1.0
In-Reply-To: <95ad1d72-8c8c-29eb-531c-e42dd02f6a19@gmail.com>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 11/07/2016 08:52 AM, mm wrote:
> 
> 
> On 11/7/2016 2:35 PM, Stephen Smalley wrote:
>> On 11/05/2016 02:55 PM, mm wrote:
>>> Hi all,
>>>
>>> I have an executable started by /bin/foo which runs confined within the
>>> context foo_t.
>>> The process loads (actually does LD_PRELOAD) bar.so which needs to
>>> access resources outside foo_t (actually unconfined_t).
>>
>> I understand what you are saying but it wouldn't be secure and it is not
>> possible.  Instead, run bar.so in a separate program/process and have
>> them communicate over an IPC mechanism.
>>
> Thanks for the reply, but it is not clear to me why it would not be secure.

There is no enforceable separation between the executable and a shared
library - they all run in the same process.

> Unfortunately I don't have control on bar.so.
> Nonetheless, your reply may suggest the symmetric strategy:
> bar.so is in fact an IPC proxy to an external process, say /bin/bar,
> which currently runs unconfined (and that also I have no control on).
> What I might think of is to define a bar_t context for /bin/bar, and
> allow the required access from foo_t to bar_t (instead of allowing from
> foo_t to unconfined_t).
> The idea is still to minimize access extension for foo_t, handling the
> target side instead of the source side.

Yes, that would be a better approach.

> Moreover, in order not to compromise the functionality of /bin/bar, I
> would need to allow bar_t the same access as unconfined_t (at least as a
> first approximation). The fact is that, although I can trust /bin/bar,
> it is not selinux-aware.

I wouldn't do that; otherwise any security gains you are getting are
illusory since bar is equivalent to unconfined.  It isn't that hard to
define a real confined domain for a program.

> Would this be effective?
> What would be the easiest way to define the bar_t context (i.e. define a
> context with the same access rights as another one)?

Generally the simplest approach is to define a stub .te file for your
domain, include a permissive declaration for it (permissive bar_t;), and
then derive a policy from the resulting avc:  denied messages via some
combination of audit2allow -R and manual examination.  In Fedora, there
is a sepolgen aka sepolicy-generate tool for generating a stub domain,
although to be honest, I haven't used it myself - I just write policy by
hand.
