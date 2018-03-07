Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w27KE8gB020618
 for <selinux@tycho.nsa.gov>; Wed, 7 Mar 2018 15:14:08 -0500
Date: Wed, 07 Mar 2018 15:13:32 -0500 (EST)
Message-Id: <20180307.151332.565301474495395127.davem@davemloft.net>
To: paul@paul-moore.com
Cc: pmoore@redhat.com, netdev@vger.kernel.org, viro@zeniv.linux.org.uk,
 dac.override@gmail.com, selinux@tycho.nsa.gov,
 linux-security-module@vger.kernel.org
From: David Miller <davem@davemloft.net>
In-Reply-To: <CAHC9VhR4FzwsAEO9O9Pnpkm2jOBajwZUkn_i0FqOMR_4ycag2g@mail.gmail.com>
References: <152037526427.18953.14013300464173153064.stgit@chester>
 <CAHC9VhR4FzwsAEO9O9Pnpkm2jOBajwZUkn_i0FqOMR_4ycag2g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Subject: Re: [PATCH] net: don't unnecessarily load kernel modules in
 dev_ioctl()
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

From: Paul Moore <paul@paul-moore.com>
Date: Tue, 6 Mar 2018 17:32:47 -0500

> On Tue, Mar 6, 2018 at 5:27 PM, Paul Moore <pmoore@redhat.com> wrote:
>> From: Paul Moore <paul@paul-moore.com>
>>
>> Starting with v4.16-rc1 we've been seeing a higher than usual number
>> of requests for the kernel to load networking modules, even on events
>> which shouldn't trigger a module load (e.g. ioctl(TCGETS)).  Stephen
>> Smalley suggested the problem may lie in commit 44c02a2c3dc5
>> ("dev_ioctl(): move copyin/copyout to callers") which moves changes
>> the network dev_ioctl() function to always call dev_load(),
>> regardless of the requested ioctl.
>>
>> This patch moves the dev_load() calls back into the individual ioctls
>> while preserving the rest of the original patch.
>>
>> Reported-by: Dominick Grift <dac.override@gmail.com>
>> Suggested-by: Stephen Smalley <sds@tycho.nsa.gov>
>> Signed-off-by: Paul Moore <paul@paul-moore.com>
>> ---
>>  net/core/dev_ioctl.c |    7 +++++--
>>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> In the interest of full disclosure, I've compiled this code but I
> haven't booted it yet (test kernel building now).  I just wanted to
> post this sooner rather than later in case the networking folks, or
> Al, had a different solution they would prefer.

This is definitely the right fix, so patch applied.

Taking the dev_load() out of that switch statement definitely has
side effects.
