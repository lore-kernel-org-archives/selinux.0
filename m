Sender: Tejun Heo <htejun@gmail.com>
Date: Mon, 19 Dec 2016 08:11:38 -0500
From: Tejun Heo <tj@kernel.org>
To: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc: John Stultz <john.stultz@linaro.org>, lkml <linux-kernel@vger.kernel.org>,
 Li Zefan <lizefan@huawei.com>, Jonathan Corbet <corbet@lwn.net>,
 cgroups@vger.kernel.org, Android Kernel Team <kernel-team@android.com>,
 Rom Lemarchand <romlem@android.com>, Colin Cross <ccross@android.com>,
 Dmitry Shmidt <dimitrysh@google.com>, Todd Kjos <tkjos@google.com>,
 Christian Poetzsch <christian.potzsch@imgtec.com>,
 Amit Pundir <amit.pundir@linaro.org>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Kees Cook <keescook@chromium.org>, "Serge E . Hallyn" <serge@hallyn.com>,
 Andy Lutomirski <luto@amacapital.net>, linux-api@vger.kernel.org,
 Paul Moore <paul@paul-moore.com>, Stephen Smalley <sds@tycho.nsa.gov>,
 Eric Paris <eparis@parisplace.org>,
 James Morris <james.l.morris@oracle.com>,
 Jeff Vander Stoep <jeffv@google.com>,
 linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov,
 Michael Kerrisk <mtk.manpages@gmail.com>, Daniel Mack <daniel@zonque.org>
Subject: Re: [PATCH] cgroup: Add new capability to allow a process to migrate
 other tasks between cgroups
Message-ID: <20161219131138.GA14837@mtj.duckdns.org>
References: <1481949827-23613-1-git-send-email-john.stultz@linaro.org>
 <5855A8EB.8000005@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <5855A8EB.8000005@digikod.net>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Hello,

On Sat, Dec 17, 2016 at 10:06:51PM +0100, Mickaël Salaün wrote:
> If I understand correctly, this patch is intended to add a delegation
> feature to cgroup v1, which does not really make sense for the v2

It's more about upstreaming a workaround for android somewhat like
including binder into kernel.  It isn't adding actual cgroup
delegation to v1.  It's just splitting a small piece of CAP_SYS_ADMIN
to accomodate what android has been doing.

> because of the clean cgroup-v2 delegation design. However, this new
> capability impact both versions.

In the same way but it's not about cgroup delegation.  It's just
allowing splitting up CAP_SYS_ADMIN so that "no extra restrictions on
cgroup" can be given away in a safer way.

> However, even if a cgroup does not directly involve a limitation, it may
> be used to identify a group of processes for a security critical purpose
> (e.g. kill a group of process). It can then make sense to have a
> dedicated capability CAP_CGROUP to allow a process *without the right to
> write in cgroup.procs* to be allowed to move a process out of its
> current cgroup. This is similar to CAP_DAC_OVERRIDE but only for
> cgroup/controllers files (but not necessarily sufficient to modify all
> cgroups). This does not means that CAP_CGROUP should allow to move any
> process from any cgroup. The cgroup_procs_write_permission() should
> compose the checks for CAP_CGROUP and/or CAP_SYS_RESOURCE and/or
> CAP_SYS_ADMIN depending on the current use of the cgroup (i.e. cgroup
> controller, BPF program type, netfilter).

There's no reason to invent a whole new set of security policies for
cgroup.  It already got one which follows the filesystem permissions
with some extra restrictions.  The CAP split is purely to accomodate
android and that's it.  If that isn't good enough a reason, then
android should just keep carrying the patches it needs.  This doesn't
justify bolting on another permission model on cgroup in any way.

Thanks.

-- 
tejun
