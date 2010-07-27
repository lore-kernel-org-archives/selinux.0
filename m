Subject: Re: [PATCH 2/2] selinux: implement mmap on /selinux/policy
From: Eric Paris <eparis@redhat.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov, jmorris@namei.org
In-Reply-To: <1280257773.4789.110.camel@moss-pluto.epoch.ncsc.mil>
References: <20100726193407.19538.67667.stgit@paris.rdu.redhat.com>
	 <20100726193414.19538.64028.stgit@paris.rdu.redhat.com>
	 <1280255773.4789.83.camel@moss-pluto.epoch.ncsc.mil>
	 <1280256670.2788.14.camel@dhcp231-200.rdu.redhat.com>
	 <1280257773.4789.110.camel@moss-pluto.epoch.ncsc.mil>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 27 Jul 2010 15:16:54 -0400
Message-ID: <1280258214.2788.17.camel@dhcp231-200.rdu.redhat.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2010-07-27 at 15:09 -0400, Stephen Smalley wrote:
> On Tue, 2010-07-27 at 14:51 -0400, Eric Paris wrote:

> > My fear was:
> > 
> > Process A			Process B
> > ------------------------	-------------------------
> > open("/selinux/policy");
> >   plm->data = p1
> >   plm->len = l1
> >   i_size = l1
> > 				load_policy
> > 				open("/selinux/policy");
> > 				  plm->data = p2;
> > 				  plm->len = l2;
> > 				  i_size = l2;
> > 				stat("/selinux/policy");
> > 				  we get i_size=l2
> > stat("/selinux/policy");
> >   we get i_size=l2  WHOOPS.
> 
> How is that different from corresponding situation for a regular file?
> Doesn't seem like the sort of thing the kernel should worry about.
> I thought the check was to prevent arbitrary allocation of kernel memory
> by spinning in a loop opening /selinux/policy forever.  But that doesn't
> require worrying about the inode size changing.

This is actually more the problem with files in /proc.  The difference
is that the plm->data and plm->len are still p1 and l1.  It's just
stat() that is going to lie to you.  So you will either mmap to much or
too little space and you have no idea how long the data you are going to
be reading is...

read() works ok, because it is going to go till the EOF, but you have no
idea where that is with mmap.....


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
