Subject: Re: 2.6.25-rc5
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Justin Mattock <justinmattock@gmail.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <dd18b0c30803130105l7cfc19d8y793518d20b2fcd22@mail.gmail.com>
References: <dd18b0c30803130105l7cfc19d8y793518d20b2fcd22@mail.gmail.com>
Content-Type: text/plain
Date: Fri, 14 Mar 2008 09:09:01 -0400
Message-Id: <1205500141.22912.13.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Thu, 2008-03-13 at 08:05 +0000, Justin Mattock wrote:
> Hello; I need to open my eyes better when looking for new versions of
> a program.(I located svn refpolicy and plugged it on, looks very
> nice,)
> The only question for now with this policy is, with building the allow
> rules, its seems it takes longer to attain avc's, as in other
> policies. i.g.
> when doing a reboot after the first install of the policy I noticed
> only around 7 to 8 avc's, then after those were defined,  then the
> same amount on the next reboot.
> Previous policies would pour 100's of avc's on the first reboot of the
> newly installed policy(was this planned).Personally; sitting and
> slowly going through each and every avc's frustrated me, but then made
> me realize it is better to take you're time with the rules, due to
> some rule that should'nt be there that might find it's way in. Below
> is what I see in dmesg with SELinux.

I think that just reflects the fact that the latest refpolicy has
incorporated many additional permissions since the one that you were
originally using based on user feedback, and thus has fewer gaps in its
coverage.  Not any fundamental change in how it reports avcs.

> 
> 
> 
> 
> [    0.164286] SELinux:  Registering netfilter hooks
> [    1.015122] SELinux:8192 avtab hash slots allocated. Num of
> rules:202124
> [    1.045833] SELinux:8192 avtab hash slots allocated. Num of
> rules:202124
> [    1.076950] security:  7 users, 7 roles, 2618 types, 89 bools
> [    1.076953] security:  69 classes, 202124 rules

Good, so all classes/perms known to the kernel are defined by your
policy.  Although they might still not be in use (due to the policy
capabilities not yet being defined upstream).

> [    1.078288] SELinux:  Completing initialization.
> [    1.078290] SELinux:  Setting up existing superblocks.
> [    1.080008] SELinux: initialized (dev sda1, type ext3), uses xattr
> [    1.080008] SELinux: initialized (dev debugfs, type debugfs), uses
> genfs_contexts
> [    1.080008] SELinux: initialized (dev selinuxfs, type selinuxfs),
> uses genfs_contexts
> [    1.080008] SELinux: initialized (dev mqueue, type mqueue), uses
> transition SIDs
> [    1.080008] SELinux: initialized (dev hugetlbfs, type hugetlbfs),
> uses genfs_contexts
> [    1.080008] SELinux: initialized (dev devpts, type devpts), uses
> transition SIDs
> [    1.080008] SELinux: initialized (dev inotifyfs, type inotifyfs),
> uses genfs_contexts
> [    1.080008] SELinux: initialized (dev tmpfs, type tmpfs), uses
> transition SIDs
> [    1.080008] SELinux: initialized (dev futexfs, type futexfs), uses
> genfs_contexts
> [    1.080008] SELinux: initialized (dev anon_inodefs, type
> anon_inodefs), uses genfs_contexts
> [    1.080008] SELinux: initialized (dev pipefs, type pipefs), uses
> task SIDs
> [    1.080008] SELinux: initialized (dev sockfs, type sockfs), uses
> task SIDs
> [    1.080008] SELinux: initialized (dev proc, type proc), uses
> genfs_contexts
> [    1.080008] SELinux: initialized (dev bdev, type bdev), uses
> genfs_contexts
> [    1.080008] SELinux: initialized (dev rootfs, type rootfs), uses
> genfs_contexts
> [    1.080008] SELinux: initialized (dev sysfs, type sysfs), uses
> genfs_contexts
> [    0.691525] SELinux: policy loaded with handle_unknown=deny
> [    0.691532] type=1403 audit(1205354634.730:2): policy loaded
> auid=4294967295 ses=4294967295
> [    0.990260] SELinux: initialized (dev tmpfs, type tmpfs), uses
> transition SIDs
> [    1.373915] SELinux: initialized (dev tmpfs, type tmpfs), uses
> transition SIDs
> [    2.802217] SELinux: initialized (dev tmpfs, type tmpfs), uses
> transition SIDs
> [    4.354764] SELinux: initialized (dev usbfs, type usbfs), uses
> genfs_contexts
> [    5.863940] SELinux: initialized (dev tmpfs, type tmpfs), uses
> transition SIDs
> 
> I'll leave this policy in place for the time being and test and see if
> anything happens.
> Thank you for the help.
> 
> 
> -- 
> Justin P. Mattock
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
