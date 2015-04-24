From: "Spector, Aaron" <Aaron_Spector@mcafee.com>
To: Stephen Smalley <sds@tycho.nsa.gov>, "SELinux (selinux@tycho.nsa.gov)"
 <selinux@tycho.nsa.gov>, "Paul Moore (paul@paul-moore.com)"
 <paul@paul-moore.com>
Subject: RE: Switching to enforcing mode introduces new policy issues?
Date: Fri, 24 Apr 2015 20:37:37 +0000
Message-ID: <43aa6499341c4948a2e4ad1c34a9ef2b@MIVEXUSR1N01.corpzone.internalzone.com>
References: <363d72e72db54ed2a93f39f76d1811fd@MIVEXUSR1N01.corpzone.internalzone.com>
 <553A362B.7040500@tycho.nsa.gov>
 <0787916bff754fec87b219654e47b1e0@MIVEXUSR1N01.corpzone.internalzone.com>
 <553A60D2.30105@tycho.nsa.gov>
 <73c3e069515544578eb3a2798436f272@MIVEXUSR1N01.corpzone.internalzone.com>
 <553A693A.5080807@tycho.nsa.gov> <553A6B3A.70108@tycho.nsa.gov>
 <265314580c2149fca9a8b2d9f9b74592@MIVEXUSR1N01.corpzone.internalzone.com>
 <553A7050.3050208@tycho.nsa.gov> <553A710A.80804@tycho.nsa.gov>
In-Reply-To: <553A710A.80804@tycho.nsa.gov>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

So I gave it a shot and nothing changed. I did however notice some oddity with my serial console though. I get some udevd failures in enforcing and I see the Permission Denied messages there, but I see no audit associated with them on the console. I'm able to get into my system to check dmesg and lo and behold there are audits in dmesg for that udev service that couldn't start.

-Aaron

-----Original Message-----
From: Stephen Smalley [mailto:sds@tycho.nsa.gov] 
Sent: Friday, April 24, 2015 11:36 AM
To: Spector, Aaron; SELinux (selinux@tycho.nsa.gov); Paul Moore (paul@paul-moore.com)
Subject: Re: Switching to enforcing mode introduces new policy issues?

On 04/24/2015 12:33 PM, Stephen Smalley wrote:
> On 04/24/2015 12:30 PM, Spector, Aaron wrote:
>> Correct, I'm not running auditd.
>>
>> Is it worth removing the printk_ratelimit call in audit_printk_skb() in audit.c for experimentation purposes? Just let it printk all the audits and if it rolls over, oh well?
> 
> Sure.

We actually do that in our kernel trees for Android policy development, e.g.
https://bitbucket.org/seandroid/kernel-msm/commits/0388e1630648c481e42929135babb1dbba272e27
