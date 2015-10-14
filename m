Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t9EGriWE012952
 for <selinux@tycho.nsa.gov>; Wed, 14 Oct 2015 12:53:44 -0400
Subject: Re: does load_policy default to loading the lowest polvers available?
To: selinux@tycho.nsa.gov
References: <20151014133408.GA5222@x250> <561E5EF4.9080606@tycho.nsa.gov>
 <20151014141101.GB5222@x250> <561E63E0.1080609@tycho.nsa.gov>
 <20151014142952.GC5222@x250> <561E7840.50903@tycho.nsa.gov>
 <20151014154828.GA2909@x250> <561E7D47.7090306@tycho.nsa.gov>
 <20151014164145.GA11363@x250>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <561E8872.3090404@tycho.nsa.gov>
Date: Wed, 14 Oct 2015 12:53:06 -0400
MIME-Version: 1.0
In-Reply-To: <20151014164145.GA11363@x250>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 10/14/2015 12:41 PM, Dominick Grift wrote:
> On Wed, Oct 14, 2015 at 12:05:27PM -0400, Stephen Smalley wrote:
>>>
>>>> AFAIK, systemd just calls selinux_init_load_policy() in libselinux (aka
>>>> load_policy -i).  And the approach to selecting a policy version has been
>>>> stable for quite a while, so I wouldn't expect the libselinux in the
>>>> initramfs to differ in this respect.
>
> I just reboot that machine, and it happened again! So the dangling 29
> file was not at all related.
>
> This issue is so weird, and so hard to narrow down.
>
> I have about 7 systems all with the same policy, same selinux userspace, different form factors,
> 2 laptops (one rawhide, on fedora 23), one worksstation (rawhide) and
> 4 qemu/kvm guests (all rawhide)
>
> Theyre pretty much all identical from a config point of view except that
> the workstation is a hypervisor and router
>
> The workstation is the issue. I am getting avc denials for the same
> access vectors (but only on the workstation):
>
> system {status start }
>
> (obivously the rules to allow it are present in the policy)

You say "obviously"; how have you verified?  You could run sesearch on 
the kernel's view of the policy (/sys/fs/selinux/policy), or you could 
run compute_av from libselinux.

If allowed by policy but denied by systemd (since those are systemd 
permissions, not kernel ones, and unfortunately use a kernel class), 
then I've only seen that on a policy reload that alters the class 
definitions.  That issue should be fixed by the patch I posted a while 
back for libselinux, which I believe should now be in rawhide.

>
> Is it Linux 4.3 related -> then why does it work on my rawhide laptop,
> and kvm guests fine
> Is it my policy -> then why does it work on all my other systems fine
> Is it hardware related -> seems to be the only explanation but then why
> does it not happen consistently? (it happens most of the time when boot
> but not always)
> Maybe it is a combination of hardware + linux 4.3?
>
> So many questions and so hard to debug...
