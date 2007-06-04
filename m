Subject: Re: [PATCH] SELinux protection for exploiting null dereference
	using mmap
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Alan Cox <alan@redhat.com>
Cc: Eric Paris <eparis@redhat.com>, selinux@tycho.nsa.gov, drepper@redhat.com,
        roland@redhat.com, arjan@infradead.org, mingo@elte.hu,
        viro@zeniv.linux.org.uk, jmorris@namei.org, chrisw@redhat.com
In-Reply-To: <20070603205653.GE25869@devserv.devel.redhat.com>
References: <1180561713.3633.27.camel@dhcp231-215.rdu.redhat.com>
	 <20070603205653.GE25869@devserv.devel.redhat.com>
Content-Type: text/plain
Date: Mon, 04 Jun 2007 09:38:26 -0400
Message-Id: <1180964306.14220.34.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 2007-06-03 at 16:56 -0400, Alan Cox wrote:
> On Wed, May 30, 2007 at 05:48:33PM -0400, Eric Paris wrote:
> > Assuming there is a kernel bug which includes a null dereference it may
> > allow for a process to place information on the first page on the system
> > and get the kernel to act in unintended ways.  This patch creates a new
> 
> Gak
> 
> > +	if (unlikely(addr < PAGE_SIZE)) {
> > +		error = security_mmap_zero();
> > +		if (error)
> > +			return error;
> > +	}
> 
> Wouldn't it be better simply to pass the address and let the mmap test
> for SELinux make a decsion on it. People who care about performance don't
> run SELinux enabled kernels anyway.

That's the wrong mindset IMHO - whatever performance issues exist in
SELinux should be addressed to enable people who care about performance
to run with it enabled.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
