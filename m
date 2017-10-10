To: Stephen Smalley <sds@tycho.nsa.gov>, Antonio Murdaca <runcom@redhat.com>
Cc: Tejun Heo <tj@kernel.org>, selinux@tycho.nsa.gov,
 lkml <linux-kernel@vger.kernel.org>, Paul Moore <paul@paul-moore.com>,
 Miroslav Grepl <mgrepl@redhat.com>
References: <8009753d-c022-12ec-406d-7d6cf01f5f73@redhat.com>
 <1507644412.30616.2.camel@tycho.nsa.gov>
From: Waiman Long <longman@redhat.com>
Message-ID: <89c4fc8c-1931-582c-a7f3-8aa2ef14c3c4@redhat.com>
Date: Tue, 10 Oct 2017 10:05:17 -0400
MIME-Version: 1.0
In-Reply-To: <1507644412.30616.2.camel@tycho.nsa.gov>
Content-Type: text/plain; charset=utf-8
Subject: Re: About commit 901ef845fa2469c ("selinux: allow per-file
 labeling for cgroupfs")
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 10/10/2017 10:06 AM, Stephen Smalley wrote:
> On Fri, 2017-10-06 at 13:53 -0400, Waiman Long wrote:
>> Antonio,
>>
>> I have a question about your 4.14 upstream commit 901ef845fa2469c
>> ("selinux: allow per-file labeling for cgroupfs"). With that, I am no
>> longer able to mount the cgroup2 filesystem with a 4.14 kernel. The
>> problem is that your commit sets the SE_SBGENFS flag, which causes
>> selinux to lookup the genfs database for a filesystem type match.
>> However, the filesystem type "cgroup2" isn't in the genfs database in
>> my
>> RHEL7 based test system. The "cgroup" filesystem type is in the genfs
>> database,
>> so I have no problem with v1 cgroup mount.
>>
>> Do you know where the genfs database is defined? I need some way to
>> add cgroup2
>> as a valid genfs fstype, or I have to manually back out the commit in
>> order to
>> do my cgroup2 testing.
> It is part of the policy; you could add it via a policy module ala:
> $ cat cgroup2.cil
> (genfscon cgroup2 / (system_u object_r cgroup_t ((s0) (s0))))
>
> $ sudo semodule -i cgroup2.cil

Thanks for the workaround. I will try that next time.

> That said, the fact that you can't even mount it without that is
> arguably a bug/regression.  I guess this is due to the ENOENT from
> security_genfs_sid being propagated all the way up instead of just
> leaving it unlabeled and permitting the mount to proceed.

Yes, the mount command got the ENOENT error and it printed out some
confusing message.

Cheers,
Longman
