Subject: Re: (Userspace) AVC denial generated even if allowed by the policy?
To: Laurent Bigonville <bigon@debian.org>
References: <5652636F.2060609@debian.org> <56533D07.20508@tycho.nsa.gov>
 <56534C04.60306@debian.org> <56535E8B.9030805@tycho.nsa.gov>
 <565363AF.9030607@debian.org>
Cc: Paul Moore <paul@paul-moore.com>, Selinux@tycho.nsa.gov
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <565377B4.9060303@tycho.nsa.gov>
Date: Mon, 23 Nov 2015 15:31:48 -0500
MIME-Version: 1.0
In-Reply-To: <565363AF.9030607@debian.org>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 11/23/2015 02:06 PM, Laurent Bigonville wrote:
> Le 23/11/15 19:44, Stephen Smalley a écrit :
>> On 11/23/2015 12:25 PM, Laurent Bigonville wrote:
>>> As you can see the results are different... So this seems to be
>>> regression at the kernel level.
>>
>> Well, that depends - are you loading the same policy into both? What
>> do you have in /etc/selinux/targeted/policy?  A policy.29 and a
>> policy.30?  What does your libsepol/checkpolicy support?
>>
>> Or, alternatively, are you toggling cron_userdomain_transition and
>> thereby changing the result?
>
> It's the same policy loaded, for both kernel version (I'm just choosing
> an other kernel in grub), I only have one policy file.
>
> # ls /etc/selinux/refpolicy/policy/
> policy.29
>
> I've the latest released userspace (2.4), policydb.h shows max version
> being 29.
>
> The policyvers utility shows: 30 with 4.3 and 29 with 4.2

You are correct - this is a kernel bug.  Hidden on Fedora because these 
rules are unconditional there...
