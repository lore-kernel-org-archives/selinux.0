Date: Tue, 11 Sep 2018 23:45:38 +0000
From: "Ahmed S. Darwish" <darwish.07@gmail.com>
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: LSM <linux-security-module@vger.kernel.org>,
 James Morris <jmorris@namei.org>, LKM <linux-kernel@vger.kernel.org>,
 SE Linux <selinux@tycho.nsa.gov>,
 John Johansen <john.johansen@canonical.com>,
 Kees Cook <keescook@chromium.org>,
 Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
 Paul Moore <paul@paul-moore.com>, Stephen Smalley <sds@tycho.nsa.gov>,
 "Schaufler, Casey" <casey.schaufler@intel.com>
Message-ID: <20180911234538.GB12337@darwi-kernel>
References: <cbf848ae-a1ac-c5ab-f23b-bc9217fceebe@schaufler-ca.com>
 <c43599b8-20f6-0cc6-28d7-abff4c0d0a0d@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <c43599b8-20f6-0cc6-28d7-abff4c0d0a0d@schaufler-ca.com>
Subject: Re: [PATCH 01/10] procfs: add smack subdir to attrs
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Tue, Sep 11, 2018 at 09:41:32AM -0700, Casey Schaufler wrote:
> Back in 2007 I made what turned out to be a rather serious
> mistake in the implementation of the Smack security module.
> The SELinux module used an interface in /proc to manipulate
> the security context on processes. Rather than use a similar
> interface, I used the same interface. The AppArmor team did
> likewise. Now /proc/.../attr/current will tell you the
> security "context" of the process, but it will be different
> depending on the security module you're using.
>
> This patch provides a subdirectory in /proc/.../attr for
> Smack. Smack user space can use the "current" file in
> this subdirectory and never have to worry about getting
> SELinux attributes by mistake. Programs that use the
> old interface will continue to work (or fail, as the case
> may be) as before.
>

Did downstream distributions already merge the stacking patches on
their own?

Got a little-bit confused after reading the log above; I already see
this in in Ubuntu 18.04.1 LTS, v4.15.0-33-generic:

    $ tree /proc/self/attr/
    /proc/self/attr/
    ├── apparmor
    │   ├── current
    │   ├── exec
    │   └── prev
    ├── current
    ├── display_lsm
    ├── exec
    ├── fscreate
    ├── keycreate
    ├── prev
    ├── selinux
    │   ├── current
    │   ├── exec
    │   ├── fscreate
    │   ├── keycreate
    │   ├── prev
    │   └── sockcreate
    ├── smack
    │   └── current
    └── sockcreate

Thanks,

--
Darwi
http://darwish.chasingpointers.com
