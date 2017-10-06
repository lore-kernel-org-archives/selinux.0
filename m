To: Antonio Murdaca <runcom@redhat.com>
Cc: Paul Moore <paul@paul-moore.com>, Stephen Smalley <sds@tycho.nsa.gov>,
 selinux@tycho.nsa.gov, Tejun Heo <tj@kernel.org>,
 lkml <linux-kernel@vger.kernel.org>
From: Waiman Long <longman@redhat.com>
Message-ID: <8009753d-c022-12ec-406d-7d6cf01f5f73@redhat.com>
Date: Fri, 6 Oct 2017 13:53:07 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Subject: About commit 901ef845fa2469c ("selinux: allow per-file
 labeling for cgroupfs")
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Antonio,

I have a question about your 4.14 upstream commit 901ef845fa2469c
("selinux: allow per-file labeling for cgroupfs"). With that, I am no
longer able to mount the cgroup2 filesystem with a 4.14 kernel. The
problem is that your commit sets the SE_SBGENFS flag, which causes
selinux to lookup the genfs database for a filesystem type match.
However, the filesystem type "cgroup2" isn't in the genfs database in my
RHEL7 based test system. The "cgroup" filesystem type is in the genfs database,
so I have no problem with v1 cgroup mount.

Do you know where the genfs database is defined? I need some way to add cgroup2
as a valid genfs fstype, or I have to manually back out the commit in order to
do my cgroup2 testing.

Thanks,
Longman
