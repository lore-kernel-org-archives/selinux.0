Reply-To: dwalsh@redhat.com
Subject: Re: is_selinux_enabled() always returns 0 after
 selinux_set_policy_root()
To: Stephen Smalley <sds@tycho.nsa.gov>,
 Dominick Grift <dac.override@gmail.com>, selinux@tycho.nsa.gov
References: <1493237420.1820719.957368808.08E54C5A@webmail.messagingengine.com>
 <1493238298.32540.13.camel@tycho.nsa.gov>
 <1493239388.1829342.957407608.3C297B30@webmail.messagingengine.com>
 <1493240908.1837173.957437120.416E6DD8@webmail.messagingengine.com>
 <1493298251.2524.3.camel@tycho.nsa.gov> <20170427165358.GA26305@julius>
 <1493325438.2524.31.camel@tycho.nsa.gov>
From: Daniel Walsh <dwalsh@redhat.com>
Message-ID: <444510d7-686f-ccd0-bf0f-ee09aade9990@redhat.com>
Date: Sun, 30 Apr 2017 06:51:17 -0400
MIME-Version: 1.0
In-Reply-To: <1493325438.2524.31.camel@tycho.nsa.gov>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 04/27/2017 04:37 PM, Stephen Smalley wrote:
> On Thu, 2017-04-27 at 18:53 +0200, Dominick Grift wrote:
>> On Thu, Apr 27, 2017 at 09:04:11AM -0400, Stephen Smalley wrote:
>>> On Wed, 2017-04-26 at 17:08 -0400, Colin Walters wrote:
>>>> On Wed, Apr 26, 2017, at 04:43 PM, Colin Walters wrote:
>>>>> On Wed, Apr 26, 2017, at 04:24 PM, Stephen Smalley wrote:
>>>>>> Your analysis and proposed fix sound correct to me.  I blame
>>>>>> Dan
>>>>>> ;)
>>>>> Thanks.  I tested the patch and confirmed it fixed ostree as it
>>>>> stands today,
>>>>> but I'm going to change ostree to cache the result of
>>>>> `is_selinux_enabled()`
>>>>> itself to work around this, since for our use cases it should
>>>>> never
>>>>> really
>>>>> change dynamically.
>>>> Although as I was working on the workaround, which I just put up
>>>> as:
>>>> https://github.com/ostreedev/ostree/pull/815
>>>>
>>>> I was thinking about this a bit more and I realized (maybe) why
>>>> Dan added that call.
>>>>
>>>> Right now (ignoring #ifdef ANDROID):
>>>> int is_selinux_enabled()
>>>> {
>>>> return (selinux_mnt && has_selinux_config);
>>>> }
>>>>
>>>> And conceptually "has_selinux_config" derives from the policy
>>>> root.
>>>> But in practice it doesn't today - that variable is also only
>>>> initialized
>>>> in the constructor.   Should it?  I'm not sure.
>>>>
>>>> The way libostree uses the policy root is basically for the
>>>> regexp
>>>> labeling
>>>> database.   We're using `is_selinux_enabled()` to determine
>>>> whether
>>>> or not we should call `setfscreatecon()`.
>>>>
>>>> Eh.  My inclination is not think too much more about this.  The
>>>> patch
>>>> is unlikely to break anything, it does fix a bug, and I'm not
>>>> aware
>>>> of a
>>>> case where someone would be using e.g. a host system with SELinux
>>>> fully disabled to do anything related to ostree, so we don't
>>>> need to care about trying to disentangle those cases.  Hopefully!
>>> 1. The has_selinux_config test was added long after the
>>> introduction of
>>>   selinux_set_policy_root(), and only to avoid a regression due to
>>> removal of the test to see if policy is loaded.  See commits
>>> c08c4eacab8d55598b9e5caaef8a871a7a476cab and
>>> 685f4aeeadc0b60f3770404d4f149610d656e3c8.
>>>
>>> 2. The test for has_selinux_config wouldn't actually be affected by
>>> selinux_set_policy_root() even if we were to re-evaluate it.
>>> selinux_set_policy_root() sets the prefix for the policy files
>>> (e.g.
>>> from /etc/selinux/targeted to /etc/selinux/mls), it does not affect
>>> the
>>> path for /etc/selinux/config.  We don't presently provide any way
>>> to
>>> redirect libselinux to a different config file.
>>>
>>> 3. Originally, is_selinux_enabled() returned 1 if selinuxfs was
>>> registered (in /proc/filesystems), even if not mounted. This was
>>> dropped by commit e3cab998b48ab293a9962faf9779d70ca339c65d, which
>>> changed the test to only return 1 if selinuxfs was mounted and only
>>> if
>>> it is mounted rw, so that a ro mount could be used in mock and
>>> other
>>> tools to make SELinux appear disabled.  Recent discussions on the
>>> list
>>> (subject: "let's revert e3cab998b48ab293a9962faf9779d70ca339c65d")
>>> have
>>>   proposed removing the ro check and only considering it disabled if
>>> selinuxfs is not mounted at all because systemd is remounting
>>> everything under /sys as ro for ProtectKernelTunables=yes and this
>>> is
>>> leading services to conclude that SELinux is disabled and then
>>> failing
>>> to label files correctly.  However, my impression is that systemd
>>> will
>>> alter its behavior and I don't think we can in the near term change
>>> libselinux in this regard as it will break various chroot and
>>> container
>>> implementations.
>> I hope you're not being too optimistic. The way i see it is that
>> reverting the patch will give these entities a reason to remove the
>> mounting of selinuxfs in containers. If you keep it in for
>> "compatibility" then i fear that it will never get fixed because
>> there is not sense of urgency.
>>
>> Also the discussion on github WRT to ProtectKernelTurnables is
>> seemingly over but no action has been decided upon.
> Yes, I don't know how to help move that forward.  I don't think
> applying Nicolas' patch for libselinux helps in that regard; even if we
> applied it today, it doesn't help motivate systemd to change its
> handling of PKT or NNP.  If anything, it might cause them to delay
> fixing PKT because it would "solve" the short-term problem associated
> with running systemd-localed with a ro selinuxfs mount, whereas we
> really need them to mount selinuxfs rw to support full use of the
> SELinux API by services.
>
>
I thought we agreed to remove the R/O check from libselinux.  I am fine 
as long as libselinux reports SELinux is disabled when selinuxfs is not 
mounted in the container.  We can move to ensure that selinuxfs is not 
mounted by container runtimes.  Currently I am not aware of a container 
runtime that mounts selinuxfs read/only to take advantage of this 
feature.  selinuxfs is not mounted by default in any container runtimes 
that I know of. Removing the libselinux READ/ONLY restriction should not 
break these work loads.
