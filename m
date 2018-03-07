Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w27Dknjf015217
 for <selinux@tycho.nsa.gov>; Wed, 7 Mar 2018 08:46:49 -0500
Received: by mail-lf0-f67.google.com with SMTP id v9-v6so3281867lfa.11
 for <selinux@tycho.nsa.gov>; Wed, 07 Mar 2018 05:46:24 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180306155920.7b6379ac@xeon-e3>
References: <152037526427.18953.14013300464173153064.stgit@chester>
 <20180306155920.7b6379ac@xeon-e3>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 7 Mar 2018 08:46:23 -0500
Message-ID: <CAHC9VhSp=ijxe6PmfnRdg5WVG59p8d17GYQkzo0jw1B7H8b2Rw@mail.gmail.com>
To: Stephen Hemminger <stephen@networkplumber.org>, netdev@vger.kernel.org
Cc: Paul Moore <pmoore@redhat.com>, Al Viro <viro@zeniv.linux.org.uk>,
 Dominick Grift <dac.override@gmail.com>, selinux@tycho.nsa.gov,
 linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [PATCH] net: don't unnecessarily load kernel modules in
 dev_ioctl()
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Tue, Mar 6, 2018 at 6:59 PM, Stephen Hemminger
<stephen@networkplumber.org> wrote:
> On Tue, 06 Mar 2018 17:27:44 -0500
> Paul Moore <pmoore@redhat.com> wrote:
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
>>
>> diff --git a/net/core/dev_ioctl.c b/net/core/dev_ioctl.c
>> index 0ab1af04296c..a04e1e88bf3a 100644
>> --- a/net/core/dev_ioctl.c
>> +++ b/net/core/dev_ioctl.c
>> @@ -402,8 +402,6 @@ int dev_ioctl(struct net *net, unsigned int cmd, struct ifreq *ifr, bool *need_c
>>       if (colon)
>>               *colon = 0;
>>
>> -     dev_load(net, ifr->ifr_name);
>
> Actually dev_load by ethernet name is really a legacy thing that should just die,
>
> It was kept around so that some very tunnel configuration using special names.
>
>         # ifconfig sit0
>
> which probably several web pages still tell users to do...
> We have much better control now with ip commands so that this is just
> baggage.

In an effort to get this regression fixed quickly, and not get tangled
up in a user education issue, can we at least restore the old ioctl()
behavior and worry about removing dev_load() later?

-- 
paul moore
www.paul-moore.com
