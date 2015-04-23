Message-ID: <5538EEF8.3060501@tycho.nsa.gov>
Date: Thu, 23 Apr 2015 09:09:12 -0400
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: "Minear, Spencer" <Spencer_Minear@mcafee.com>,
 "SELinux (selinux@tycho.nsa.gov)" <selinux@tycho.nsa.gov>
Subject: Re: Yet another strange behavior.
References: <a8fc1b0fbe484a1596e07221e7c5424e@MIVEXUSR1N02.corpzone.internalzone.com>
 <5538E5B4.3000604@tycho.nsa.gov>
 <1293317c31164af3abf11fc27b9867f9@MIVEXUSR1N02.corpzone.internalzone.com>
 <5538ECE1.4060008@tycho.nsa.gov>
In-Reply-To: <5538ECE1.4060008@tycho.nsa.gov>
Content-Type: text/plain; charset=windows-1252
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 04/23/2015 09:00 AM, Stephen Smalley wrote:
> On 04/23/2015 08:57 AM, Minear, Spencer wrote:
>> Running in permissive mode during development so the actual operation is not being blocked.  An example of the audit is as follows
>>
>> [    5.075061] audit: type=1400 audit(1429635963.920:3): avc:  denied  { create } for  pid=2494 comm="sed" name="sedxhSZOp" scontext=system_u:system_r:sg_cfg_t:s0 tcontext=unconfined_u:object_r:etc_t:s0 tclass=file permissive=1
>>
>> Running sesearch on the policy file, shows the following:
>>
>> Found 1 semantic av rules:
>>    allow sg_cfg_t etc_t : file { ioctl read write create getattr setattr relabelfrom relabelto append unlink rename open } ;
> 
> The user identities are not equal, so in a typical policy, this will
> violate a constraint on file create permission.  audit2why tells which
> part of policy is denying the action, although the level of detail will
> vary depending on your policy version and how recent your selinux
> userspace is.

BTW, normally the user field of the context for a new file is inherited
from its creator, so normally the tcontext= would be
system_u:object_r:etc_t:s0, not unconfined_u:object_r:etc_t:s0.  The
fact that it is unconfined_u suggests that either the userspace program
is explicitly specifying the context (e.g. to match the original file)
or that your policy specifies a default_user rule that defaults to
inheriting from the parent directory instead,
http://selinuxproject.org/page/DefaultRules#default_user
