From: "Spector, Aaron" <Aaron_Spector@mcafee.com>
To: Stephen Smalley <sds@tycho.nsa.gov>, "SELinux (selinux@tycho.nsa.gov)"
 <selinux@tycho.nsa.gov>, "Paul Moore (paul@paul-moore.com)"
 <paul@paul-moore.com>
Subject: RE: Switching to enforcing mode introduces new policy issues?
Date: Fri, 24 Apr 2015 16:30:21 +0000
Message-ID: <265314580c2149fca9a8b2d9f9b74592@MIVEXUSR1N01.corpzone.internalzone.com>
References: <363d72e72db54ed2a93f39f76d1811fd@MIVEXUSR1N01.corpzone.internalzone.com>
 <553A362B.7040500@tycho.nsa.gov>
 <0787916bff754fec87b219654e47b1e0@MIVEXUSR1N01.corpzone.internalzone.com>
 <553A60D2.30105@tycho.nsa.gov>
 <73c3e069515544578eb3a2798436f272@MIVEXUSR1N01.corpzone.internalzone.com>
 <553A693A.5080807@tycho.nsa.gov> <553A6B3A.70108@tycho.nsa.gov>
In-Reply-To: <553A6B3A.70108@tycho.nsa.gov>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Correct, I'm not running auditd.

Is it worth removing the printk_ratelimit call in audit_printk_skb() in audit.c for experimentation purposes? Just let it printk all the audits and if it rolls over, oh well?

-Aaron

-----Original Message-----
From: Stephen Smalley [mailto:sds@tycho.nsa.gov] 
Sent: Friday, April 24, 2015 11:12 AM
To: Spector, Aaron; SELinux (selinux@tycho.nsa.gov); Paul Moore (paul@paul-moore.com)
Subject: Re: Switching to enforcing mode introduces new policy issues?

On 04/24/2015 12:03 PM, Stephen Smalley wrote:
> On 04/24/2015 11:57 AM, Spector, Aaron wrote:
>> That's what I thought with regards to the file opens. It seemed to work when I lacked the directory search permission, but once it came up and I thought about it, it made sense. I'm just not sure why I didn't see the deny in permissive mode.. All of the rules I have had to add have made sense in the grand scheme of things.
>>
>> Is it possible to examine the cache for what lookups have happened, similar to how sesearch works? Perhaps my permissive mode is actually denying some operations, but not telling me for some reason.
> 
> No, the only information about the AVC that is made available to 
> userspace is statistics via /sys/fs/selinux/avc/cache_stats and hash_stats.
> 
> I don't think your permissive mode is denying anything.  The more 
> likely scenario is audit is just losing events IMHO.  Looking again at 
> the code, even the audit_lost output is wrapped with a 
> printk_ratelimit check, so it could be suppressed.
> 
>> If I was rolling over the kernel ring buffer, wouldn't I be missing the initial boot events? I've got the entire boot sequence in dmesg.
> 
> Yes, so it doesn't sound like you are rolling over that buffer.
> 
> Sounds like a bug in audit to me...

Just wanted to check - it sounds like you are not running auditd at all?
 Just letting all of the audit messages go to dmesg?
