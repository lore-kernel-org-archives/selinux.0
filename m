Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l4VFKKhw013315
	for <selinux@tycho.nsa.gov>; Thu, 31 May 2007 11:20:20 -0400
Received: from mail1.sea5.speakeasy.net (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l4VFKGWZ021290
	for <selinux@tycho.nsa.gov>; Thu, 31 May 2007 15:20:16 GMT
Date: Thu, 31 May 2007 11:19:51 -0400 (EDT)
From: James Morris <jmorris@namei.org>
To: Stephen Smalley <sds@tycho.nsa.gov>
cc: Eric Paris <eparis@redhat.com>, selinux@tycho.nsa.gov, drepper@redhat.com,
        alan@redhat.com, roland@redhat.com, arjan@infradead.org, mingo@elte.hu,
        viro@zeniv.linux.org.uk, chrisw@redhat.com
Subject: Re: [PATCH] SELinux protection for exploiting null dereference using
 mmap
In-Reply-To: <1180622751.3340.269.camel@moss-spartans.epoch.ncsc.mil>
Message-ID: <Line.LNX.4.64.0705311101250.24147@d.namei>
References: <1180561713.3633.27.camel@dhcp231-215.rdu.redhat.com>
 <Line.LNX.4.64.0705301954080.19731@d.namei>  <1180590362.3969.11.camel@localhost.localdomain>
  <Line.LNX.4.64.0705310943170.23949@d.namei> <1180622751.3340.269.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 31 May 2007, Stephen Smalley wrote:

> On Thu, 2007-05-31 at 09:45 -0400, James Morris wrote:
> > On Thu, 31 May 2007, Eric Paris wrote:
> > 
> > > suggestions for a better name from anyone? 
> > 
> > system? kernel?
> 
> In retrospect, we likely should have moved all of the execmem/stack/heap
> checks into a separate memory class and we could have put this one there
> as well.  There is a 'system' class already, so it isn't better than
> using 'process' aside from having more free bits; using a new class will
> ensure that no existing policy implicitly allows this check via an allow
> a b:c *; rule.

Time for a new policy format version?

> > > It doesn't address the question of 'is 1 page enough'   Anyone with a
> > > good suggestion of how much is enough?  Or a reasonable idea on how to
> > > make something like this configureable if we can't agree on a single
> > > number?
> > 
> > For SELinux, have a default and allow the value to be set via a selinuxfs 
> > node.
> 
> Or it could be a sysctl value if you wanted it to generalize beyond
> selinux.

So, the dummy module would use the sysctl value, and SELinux would 
selectively allow bypass of this?  We then need to ensure SELinux is 
appropriately mediating changes to the sysctl.


- James
-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
