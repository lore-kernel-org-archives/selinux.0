Subject: Re: [PATCH] Protection for exploiting null dereference using mmap
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Chris Wright <chrisw@sous-sol.org>
Cc: Eric Paris <eparis@redhat.com>, linux-kernel@vger.kernel.org,
        selinux@tycho.nsa.gov, Alan Cox <alan@redhat.com>, drepper@redhat.com,
        roland@redhat.com, arjan@infradead.org, mingo@elte.hu,
        viro@zeniv.linux.org.uk, jmorris@namei.org, chrisw@redhat.com,
        sgrubb@redhat.com
In-Reply-To: <20070605225302.GE3723@sequoia.sous-sol.org>
References: <1180561713.3633.27.camel@dhcp231-215.rdu.redhat.com>
	 <20070603205653.GE25869@devserv.devel.redhat.com>
	 <1180964306.14220.34.camel@moss-spartans.epoch.ncsc.mil>
	 <1181075666.3978.31.camel@localhost.localdomain>
	 <20070605225302.GE3723@sequoia.sous-sol.org>
Content-Type: text/plain
Date: Wed, 06 Jun 2007 08:12:32 -0400
Message-Id: <1181131952.3699.0.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2007-06-05 at 15:53 -0700, Chris Wright wrote:
> * Eric Paris (eparis@redhat.com) wrote:
> > One result of using the dummy hook for non-selinux kernels means that I
> > can't leave the generic module stacking code in the SELinux check.  If
> > the secondary ops are called they will always deny the operation just
> > like in non-selinux systems even if SELinux policy would have allowed
> > the action.  This patch may be the first step to removing the arbitrary
> > LSM module stacking code from SELinux.  I think history has shown the
> > arbitrary module stacking is not a good idea and eventually I want to
> > pull out all the secondary calls which aren't used by the capability
> > module, so I view this as just the first step along those lines.
> 
> Or replace them all with direct library calls to the capability code.

The only tricky part there is retaining the support for falling back on
capabilities upon runtime disable of selinux by /sbin/init.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
