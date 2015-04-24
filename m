Message-ID: <553A362B.7040500@tycho.nsa.gov>
Date: Fri, 24 Apr 2015 08:25:15 -0400
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: "Spector, Aaron" <Aaron_Spector@mcafee.com>,
 "SELinux (selinux@tycho.nsa.gov)" <selinux@tycho.nsa.gov>,
 Paul Moore <paul@paul-moore.com>
Subject: Re: Switching to enforcing mode introduces new policy issues?
References: <363d72e72db54ed2a93f39f76d1811fd@MIVEXUSR1N01.corpzone.internalzone.com>
In-Reply-To: <363d72e72db54ed2a93f39f76d1811fd@MIVEXUSR1N01.corpzone.internalzone.com>
Content-Type: text/plain; charset=windows-1252
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 04/23/2015 05:14 PM, Spector, Aaron wrote:
> Hi all,
> 
>  
> 
> I’ve been working on writing my first policy for SELinux and I’ve hit a
> bit of a snag. I’ve gotten the policy clean in permissive mode, but when
> I swap the system over to enforcing, a whole new set of policy issues
> crop up. Everything I’ve read says this isn’t to be expected so I’m a
> bit confused as to what’s happening. Output from sestatus when in
> permissive mode is:
> 
>  
> 
> SELinux status:                 enabled
> 
> SELinuxfs mount:                /sys/fs/selinux
> 
> SELinux root directory:         /etc/selinux
> 
> Loaded policy name:             default
> 
> Current mode:                   permissive
> 
> Mode from config file:          permissive
> 
> Policy MLS status:              enabled
> 
> Policy deny_unknown status:     denied
> 
> Max kernel policy version:      29
> 
>  
> 
> I’m running a version 26 policy and a 3.16.7 kernel.
> 
>  
> 
> It seems like the majority of the new deny audits are about the need for
> search permissions on directories between types that already have what I
> believe are the necessary file permissions.
> 
>  
> 
> So far what I’ve had to do to get around it is to add to my policy, but
> that doesn’t seem like that should be necessary. If the audit is clean
> in permissive mode, why isn’t it clean in enforcing?
> 
>  
> 
> Is it possible that I’m missing policy deny audits when it’s in
> permissive mode?

The audit system can be overwhelmed by too many denials and therefore
can drop some of the messages under certain conditions; look for
audit_lost= in your dmesg output after booting.  You may be hitting the
audit rate limit, if set, or the backlog limit, if the userspace audit
daemon cannot keep up, or an OOM condition.  I've seen that for e.g.
Android board bringup where you have too many denials during early boot.
You can try adjusting the backlog or rate limits to improve the capture
of denials, but sometimes you may just have to do it iteratively to
ensure full coverage.

Another possibility is that in enforcing mode, the kernel or userspace
may follow a different code path after the point of the denial since the
denial is then being enforced, and that different code path may itself
trigger further permission checks that were not being triggered while
permissive.  I've seen that before as well.

I am a little puzzled though by your comment about the majority of the
new denials being for search permissions on directories between types
that already have the necessary permissions.  Does that mean that you
have already added allow rules for these denials, rebuilt, reinstalled,
and rebooted with that policy, and yet you are still seeing the same
denials?  If so, then a possible explanation is that the denial are due
to something other than a missing allow rule, e.g. they might be due to
a difference in the user identity or level fields of the source and
target security contexts based on constraints in the policy.  audit2why
can tell you why a given denial occurred, but its ability to give you
detailed info will depend on your policy version and how modern a
version of libselinux and policycoreutils you have.
