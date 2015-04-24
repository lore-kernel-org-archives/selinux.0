From: "Spector, Aaron" <Aaron_Spector@mcafee.com>
To: Stephen Smalley <sds@tycho.nsa.gov>, "SELinux (selinux@tycho.nsa.gov)"
 <selinux@tycho.nsa.gov>, "Paul Moore (paul@paul-moore.com)"
 <paul@paul-moore.com>
Subject: RE: Switching to enforcing mode introduces new policy issues?
Date: Fri, 24 Apr 2015 15:18:13 +0000
Message-ID: <0787916bff754fec87b219654e47b1e0@MIVEXUSR1N01.corpzone.internalzone.com>
References: <363d72e72db54ed2a93f39f76d1811fd@MIVEXUSR1N01.corpzone.internalzone.com>
 <553A362B.7040500@tycho.nsa.gov>
In-Reply-To: <553A362B.7040500@tycho.nsa.gov>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

I noticed the ratelimiting happening a while ago, but if it was happening here, I should get suppression logs correct? I've been checking my avc audits by examining dmesg / viewing that output via a serial console and nothing in there implies that I'm missing logs. When in permissive I can see the policy load audit (<time>:2) and if I break my policy on purpose, the next one is (<time>:3) as expected. When I reboot in enforcing (without the broken policy), I see the policy load (<time>:2) and then I see a new deny on (<time>:3) that doesn't appear in a permissive boot. I'm also not seeing any gaps in the audit sequence numbers.

It may be that you're right about using different code paths in enforcing, it just seems weird that if I didn't deny it in permissive, why would I deny it in enforcing? It seems logical that I'd see new permission checks if a new portion of code was taken.

What I've had to do to make a bit of progress is add new allow rules for the dir class. The only difference between boots is either I add 'enforcing=1' to the kernel boot params in the bootloader or I alter the /etc/config/selinux file to use enforcing mode. An example would be:

# This is all I needed in permissive mode
Allow type_a_t type_b_t : file { read open };
# In enforcing, I now get denies for this
Allow type_a_t type_b_t : dir { search };

I'm surprised that I've never seen denies that relate to that second rule while in permissive mode before. They're not the only new denies I've seen, but they are most frequent. I've been adding to the policy with the rules to allow the denies, rebuilding, reinstalling, rebooting and I get slightly farther each time due to the new rules.

-Aaron 

-----Original Message-----
From: Stephen Smalley [mailto:sds@tycho.nsa.gov] 
Sent: Friday, April 24, 2015 7:25 AM
To: Spector, Aaron; SELinux (selinux@tycho.nsa.gov); Paul Moore
Subject: Re: Switching to enforcing mode introduces new policy issues?

On 04/23/2015 05:14 PM, Spector, Aaron wrote:
> Hi all,
> 
>  
> 
> I've been working on writing my first policy for SELinux and I've hit 
> a bit of a snag. I've gotten the policy clean in permissive mode, but 
> when I swap the system over to enforcing, a whole new set of policy 
> issues crop up. Everything I've read says this isn't to be expected so 
> I'm a bit confused as to what's happening. Output from sestatus when 
> in permissive mode is:
<snip>
> It seems like the majority of the new deny audits are about the need 
> for search permissions on directories between types that already have 
> what I believe are the necessary file permissions.
> 
>  
> 
> So far what I've had to do to get around it is to add to my policy, 
> but that doesn't seem like that should be necessary. If the audit is 
> clean in permissive mode, why isn't it clean in enforcing?
> 
>  
> 
> Is it possible that I'm missing policy deny audits when it's in 
> permissive mode?

The audit system can be overwhelmed by too many denials and therefore can drop some of the messages under certain conditions; look for audit_lost= in your dmesg output after booting.  You may be hitting the audit rate limit, if set, or the backlog limit, if the userspace audit daemon cannot keep up, or an OOM condition.  I've seen that for e.g.
Android board bringup where you have too many denials during early boot.
You can try adjusting the backlog or rate limits to improve the capture of denials, but sometimes you may just have to do it iteratively to ensure full coverage.

Another possibility is that in enforcing mode, the kernel or userspace may follow a different code path after the point of the denial since the denial is then being enforced, and that different code path may itself trigger further permission checks that were not being triggered while permissive.  I've seen that before as well.

I am a little puzzled though by your comment about the majority of the new denials being for search permissions on directories between types that already have the necessary permissions.  Does that mean that you have already added allow rules for these denials, rebuilt, reinstalled, and rebooted with that policy, and yet you are still seeing the same denials?  If so, then a possible explanation is that the denial are due to something other than a missing allow rule, e.g. they might be due to a difference in the user identity or level fields of the source and target security contexts based on constraints in the policy.  audit2why can tell you why a given denial occurred, but its ability to give you detailed info will depend on your policy version and how modern a version of libselinux and policycoreutils you have.
