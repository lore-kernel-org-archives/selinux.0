Received: from goalie.tycho.ncsc.mil (goalie.infosec.tycho.ncsc.mil
 [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w8C01Xfj023002
 for <selinux@tycho.nsa.gov>; Tue, 11 Sep 2018 20:01:34 -0400
To: "Ahmed S. Darwish" <darwish.07@gmail.com>
Cc: LSM <linux-security-module@vger.kernel.org>,
 James Morris <jmorris@namei.org>, LKM <linux-kernel@vger.kernel.org>,
 SE Linux <selinux@tycho.nsa.gov>, John Johansen
 <john.johansen@canonical.com>, Kees Cook <keescook@chromium.org>,
 Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
 Paul Moore <paul@paul-moore.com>, Stephen Smalley <sds@tycho.nsa.gov>,
 "Schaufler, Casey" <casey.schaufler@intel.com>
References: <cbf848ae-a1ac-c5ab-f23b-bc9217fceebe@schaufler-ca.com>
 <c43599b8-20f6-0cc6-28d7-abff4c0d0a0d@schaufler-ca.com>
 <20180911234538.GB12337@darwi-kernel>
From: Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <cb61a8bc-eb36-3eb9-88ab-d30c6522619b@schaufler-ca.com>
Date: Tue, 11 Sep 2018 17:01:21 -0700
MIME-Version: 1.0
In-Reply-To: <20180911234538.GB12337@darwi-kernel>
Content-Type: text/plain; charset=utf-8
Subject: Re: [PATCH 01/10] procfs: add smack subdir to attrs
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 9/11/2018 4:45 PM, Ahmed S. Darwish wrote:
> On Tue, Sep 11, 2018 at 09:41:32AM -0700, Casey Schaufler wrote:
>> Back in 2007 I made what turned out to be a rather serious
>> mistake in the implementation of the Smack security module.
>> The SELinux module used an interface in /proc to manipulate
>> the security context on processes. Rather than use a similar
>> interface, I used the same interface. The AppArmor team did
>> likewise. Now /proc/.../attr/current will tell you the
>> security "context" of the process, but it will be different
>> depending on the security module you're using.
>>
>> This patch provides a subdirectory in /proc/.../attr for
>> Smack. Smack user space can use the "current" file in
>> this subdirectory and never have to worry about getting
>> SELinux attributes by mistake. Programs that use the
>> old interface will continue to work (or fail, as the case
>> may be) as before.
>>
> Did downstream distributions already merge the stacking patches on
> their own?

Ubuntu is leading the way with adopting the stacking patches.
