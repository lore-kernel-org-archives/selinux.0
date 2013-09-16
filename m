Message-ID: <1379345231.6787.72.camel@d30>
Subject: Re: RFC policycoreutils packaging
From: Dominick Grift <dominick.grift@gmail.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, selinux <selinux@tycho.nsa.gov>
Date: Mon, 16 Sep 2013 17:27:11 +0200
In-Reply-To: <52371FF5.5030602@redhat.com>
References: <1379166860.4313.21.camel@d30> <5236F48B.7080407@tycho.nsa.gov>
	  <1379334768.6787.48.camel@d30> <52371696.2050509@redhat.com>
	 <1379343250.6787.64.camel@d30> <52371FF5.5030602@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2013-09-16 at 11:12 -0400, Daniel J Walsh wrote:

> > The problem is not just fixing this. SELinux is misunderstood. If 
> > application developers hook into libselinux but they don't know how they 
> > should use it then that's the fundamental issue to tackle in my view.
> > 
> Yes the tool writers will take the easy way out, but libselinux is not very
> flexible with this either.  IE Every time a new policy enforcer like systemd
> or libvirt comes along, libselinux needs to change API.  So giving us
> flexibility for these tools to define context files structure rather then
> constantly changing libselinux.
> 
> BTW I am not familiar with anything hard coded into systemd or udev.
> 

I will look up the hard code issues and enclose them

> >> 
> >> I am open to fixing any problem that you have with Fedora running your
> >> policy, of course getting patches in would always help.
> > 
> > My view is that awareness is probably the only sustainable fix.
> > 
> > But yes i have been thinking about looking into sshd /login code to try a
> > fix this but there are only 24 hours in a day, and i dont think it is 
> > particularly efficient for me to try and fix this with my coding skills
> > 
> > I think its probably more efficient for me to do what i am good at
> > 
> Fine, but lets add bugzillas for these, cause I agree with you here.  These
> tools should be using libselinux to find context files to assign rather then
> hard coding, and then having a fall back to no labels if the policy does not
> define any.
> >> 
> >> 

Will do asap

> >>> 
> >> Tools that rely on MCS/MLS Separation will not work well without it. 
> >> libvirt/openshift/sandbox/libvirt-sandbox.  Not sure how you can fix
> >> this.  I guess we could reqwrite sandbox to more easily support just type
> >> separation, but I am not sure of the value.
> > 
> > It is not a problem that some apps rely on a optional security model, i 
> > guess, as long at they check for dependencies. I mean the 
> > policycoreutils-sandbox policy requires selinux-policy-targeted
> > 
> Not on Fedora 20?  Although we are creating a selinux-policy-sandbox which it
> will require for sandbox (Not sandbox -X) so that we can not install the huge
> sandbox.pp file.
> 

selinux-policy-sandbox is a great idea (i think), now i only wished
sandbox was not part of policycoreutils

I wasn't talking about Fedora selinux policy in particular although i
did take fedoras selinux-policy-targeted as an example

Might well have been taken care of in Fedora ( i was assuming above, i
have not actually tried it )

> > ( not sure if that is done )
> > 
> > As for libvirt well one can use libvirt fine without SELinux i suspect. It
> > has a configuration option to use no security/selinux/or apparmour
> > 
> > So thats not a problem (at least i dont see any)
> > 
> My point being that libvirt/Dynamic labeling would not work with a non MLS/MCS
> SELinux Policy.

Alright, yes good point



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
