Subject: Re: [PATCH] SELinux protection for exploiting null dereference
	using mmap
From: Stephen Smalley <sds@tycho.nsa.gov>
To: James Morris <jmorris@namei.org>
Cc: Eric Paris <eparis@redhat.com>, selinux@tycho.nsa.gov, drepper@redhat.com,
        alan@redhat.com, roland@redhat.com, arjan@infradead.org, mingo@elte.hu,
        viro@zeniv.linux.org.uk, chrisw@redhat.com
In-Reply-To: <Line.LNX.4.64.0705310943170.23949@d.namei>
References: <1180561713.3633.27.camel@dhcp231-215.rdu.redhat.com>
	 <Line.LNX.4.64.0705301954080.19731@d.namei>
	 <1180590362.3969.11.camel@localhost.localdomain>
	 <Line.LNX.4.64.0705310943170.23949@d.namei>
Content-Type: text/plain
Date: Thu, 31 May 2007 10:45:51 -0400
Message-Id: <1180622751.3340.269.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2007-05-31 at 09:45 -0400, James Morris wrote:
> On Thu, 31 May 2007, Eric Paris wrote:
> 
> > suggestions for a better name from anyone? 
> 
> system? kernel?

In retrospect, we likely should have moved all of the execmem/stack/heap
checks into a separate memory class and we could have put this one there
as well.  There is a 'system' class already, so it isn't better than
using 'process' aside from having more free bits; using a new class will
ensure that no existing policy implicitly allows this check via an allow
a b:c *; rule.

> > It doesn't address the question of 'is 1 page enough'   Anyone with a
> > good suggestion of how much is enough?  Or a reasonable idea on how to
> > make something like this configureable if we can't agree on a single
> > number?
> 
> For SELinux, have a default and allow the value to be set via a selinuxfs 
> node.

Or it could be a sysctl value if you wanted it to generalize beyond
selinux.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
