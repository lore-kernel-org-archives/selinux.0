From: Laurent Bigonville <bigon@debian.org>
Subject: Re: (Userspace) AVC denial generated even if allowed by the policy?
To: Stephen Smalley <sds@tycho.nsa.gov>
References: <5652636F.2060609@debian.org> <56533D07.20508@tycho.nsa.gov>
 <56534C04.60306@debian.org> <56535E8B.9030805@tycho.nsa.gov>
Cc: Paul Moore <paul@paul-moore.com>, Selinux@tycho.nsa.gov
Message-ID: <565363AF.9030607@debian.org>
Date: Mon, 23 Nov 2015 20:06:23 +0100
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
In-Reply-To: <56535E8B.9030805@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Le 23/11/15 19:44, Stephen Smalley a écrit :
> On 11/23/2015 12:25 PM, Laurent Bigonville wrote:
>> As you can see the results are different... So this seems to be
>> regression at the kernel level.
>
> Well, that depends - are you loading the same policy into both? What
> do you have in /etc/selinux/targeted/policy?  A policy.29 and a
> policy.30?  What does your libsepol/checkpolicy support?
>
> Or, alternatively, are you toggling cron_userdomain_transition and
> thereby changing the result?

It's the same policy loaded, for both kernel version (I'm just choosing 
an other kernel in grub), I only have one policy file.

# ls /etc/selinux/refpolicy/policy/
policy.29

I've the latest released userspace (2.4), policydb.h shows max version 
being 29.

The policyvers utility shows: 30 with 4.3 and 29 with 4.2
