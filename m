Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q2LDXGrW017275
	for <selinux@tycho.nsa.gov>; Wed, 21 Mar 2012 09:33:16 -0400
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Mark Dalton <mdalton@princeton.edu>
Subject: Re: VirtualGL and selinux
Date: Thu, 22 Mar 2012 00:33:07 +1100
Cc: selinux@tycho.nsa.gov
References: <4F69D204.9070609@princeton.edu>
In-Reply-To: <4F69D204.9070609@princeton.edu>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Message-Id: <201203220033.07525.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 22 Mar 2012, Mark Dalton <mdalton@princeton.edu> wrote:
> I was not able to get VirtualGL and selinux to work together.
> It is something during boot time it seems.  I have tried generating
> rules based on audit/audit.log.

When discussing such things it's a good idea to publish the rules you have 
tried adding, then we can determine whether you are on the right track.

> The VirtualGL web http://www.virtualgl.org/Documentation/RHEL6
> states they don't know how to make it work either.
> 
> I have tried in permissive mode after boot and that did not work either,
> which is why I think it is something during boot time.  Like the device
> setup. My guess is related to: /dev/dri as it sets up these and then
> access to the /dev/nvidia0 and /dev/nvidiactl are restricted to vglusers
> group (in my case it can be configured with/without group restriction).

Just to be clear, are you saying that it works if you boot with "enforcing=0" 
on the kernel command line (permissive all the way) but fails if you boot 
normally but run "setenforce 0" after booting?  If so then check whether all 
necessary daemons have started correctly.

> Currently, the only known way to make|vglgenkey|work (|vglgenkey|is used 
> to grant 3D X Server access to members of the|vglusers|group) is to 
> disable SELinux. With SELinux enabled, the*//usr/bin/xauth/*file is 
> hidden within the context of the GDM startup scripts, so|vglgenkey|has 
> no way of generating or importing an xauth key 
> to*//etc/opt/VirtualGL/vgl_xauth_key/*(and, for that matter, access is 
> denied to*//etc/opt/VirtualGL/*as well.)

What context is vglgenkey being run from?

The policy is written to support xauth being run from an X login session (GDM 
etc) and from a user login (IE you ssh to a server and run xauth at the 
command line).

If you have an X login manager that runs xauth then it should run in the xdm_t 
domain.  Give it the xdm_exec_t type and it should be fine.

-- 
My Main Blog         http://etbe.coker.com.au/
My Documents Blog    http://doc.coker.com.au/

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
