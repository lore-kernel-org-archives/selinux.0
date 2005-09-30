Message-Id: <200509301628.j8UGSZYs009770@gotham.columbia.tresys.com>
From: "Karl MacMillan" <kmacmillan@tresys.com>
To: "'Stephen Smalley'" <sds@tycho.nsa.gov>
Cc: <selinux@tycho.nsa.gov>, "'Daniel J Walsh'" <dwalsh@redhat.com>,
   "'Ivan Gyurdiev'" <ivg2@cornell.edu>, <SELinux-dev@tresys.com>
Subject: RE: [RFC][PATCH] New interface for loading policy
Date: Fri, 30 Sep 2005 12:28:35 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-reply-to: <1128092366.12459.145.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> -----Original Message-----
> From: Stephen Smalley [mailto:sds@tycho.nsa.gov]
> Sent: Friday, September 30, 2005 10:59 AM
> To: Karl MacMillan
> Cc: selinux@tycho.nsa.gov; 'Daniel J Walsh'; 'Ivan Gyurdiev'; SELinux-
> dev@tresys.com
> Subject: RE: [RFC][PATCH] New interface for loading policy
> 
> On Fri, 2005-09-30 at 10:53 -0400, Karl MacMillan wrote:
> > This will be an interface in addition to the current interface, correct?
> 
> Yes, security_load_policy(3) will still be available.  Just not used
> directly any more by init or load_policy, but potentially could be used
> by others if they want the low level interface.
> 
> > It depends on whether the policy server will use this interface or the
> > existing security_load_policy internally to load policy. If it will use
> > selinux_mkload_policy then it will need to be able to specify the path I
> > think. This is especially important if the policy server will be
> generating
> > different policies for the kernel and one or more userspace security
> > servers.
> 
> Hmm...at present, libsemanage installs the binary policy to the standard
> location and then invokes load_policy in direct mode, right?

Correct.

>  Is there a
> reason the policy server would operate differently?
> selinux_mkload_policy is purely for the kernel policy; it will be used
> by init for the initial policy load.
> 

As long as the interface is only for the kernel policy then libselinux
should always know the correct file. The only thing I was thinking of is if
the policy gets split for kernel and uss, but you are right, init will have
to be able to rely on always finding the correct policy to load into the
kernel, so making certain that libselinux can always find that policy is the
right thing to do.

Karl

------
Karl MacMillan
Tresys Technology
http://www.tresys.com

> --
> Stephen Smalley
> National Security Agency



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
