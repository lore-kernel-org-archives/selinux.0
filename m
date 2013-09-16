Message-ID: <1379345882.6787.76.camel@d30>
Subject: Re: RFC policycoreutils packaging
From: Dominick Grift <dominick.grift@gmail.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, selinux <selinux@tycho.nsa.gov>
Date: Mon, 16 Sep 2013 17:38:02 +0200
In-Reply-To: <1379345231.6787.72.camel@d30>
References: <1379166860.4313.21.camel@d30> <5236F48B.7080407@tycho.nsa.gov>
	 <1379334768.6787.48.camel@d30> <52371696.2050509@redhat.com>
	 <1379343250.6787.64.camel@d30> <52371FF5.5030602@redhat.com>
	 <1379345231.6787.72.camel@d30>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2013-09-16 at 17:27 +0200, Dominick Grift wrote:
> On Mon, 2013-09-16 at 11:12 -0400, Daniel J Walsh wrote:
> 
> > > The problem is not just fixing this. SELinux is misunderstood. If 
> > > application developers hook into libselinux but they don't know how they 
> > > should use it then that's the fundamental issue to tackle in my view.
> > > 
> > Yes the tool writers will take the easy way out, but libselinux is not very
> > flexible with this either.  IE Every time a new policy enforcer like systemd
> > or libvirt comes along, libselinux needs to change API.  So giving us
> > flexibility for these tools to define context files structure rather then
> > constantly changing libselinux.
> > 
> > BTW I am not familiar with anything hard coded into systemd or udev.
> > 
> 
> I will look up the hard code issues and enclose them

I don't know what's responsible exactly but these are the hard-coded
contexts, and considering their nature i suspect its either systemd or
udev:

> # dmesg | grep -i selinux | grep -i unmapped
> [    1.453709] SELinux:  Context system_u:object_r:var_run_t:s0 is not valid (left unmapped).
> [    1.453713] SELinux:  Context system_u:object_r:sysfs_t:s0 is not valid (left unmapped).
> [    1.453717] SELinux:  Context system_u:object_r:root_t:s0 is not valid (left unmapped).
> [    1.453721] SELinux:  Context system_u:object_r:device_t:s0 is not valid (left unmapped).
> [    1.555305] SELinux:  Context system_u:object_r:tmp_t:s0 is not valid (left unmapped).
> [    1.918870] SELinux:  Context system_u:object_r:boot_t:s0 is not valid (left unmapped).

I happens pretty much right after the policy is loaded


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
