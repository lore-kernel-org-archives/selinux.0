Date: Wed, 6 Jun 2007 11:06:31 -0700
From: Chris Wright <chrisw@sous-sol.org>
To: Eric Paris <eparis@redhat.com>
Cc: Alan Cox <alan@redhat.com>, James Morris <jmorris@namei.org>,
        linux-kernel@vger.kernel.org, selinux@tycho.nsa.gov,
        drepper@redhat.com, roland@redhat.com, arjan@infradead.org,
        mingo@elte.hu, viro@zeniv.linux.org.uk, chrisw@redhat.com,
        sds@tycho.nsa.gov, sgrubb@redhat.com
Subject: Re: [PATCH] Protection for exploiting null dereference using mmap
Message-ID: <20070606180631.GP3723@sequoia.sous-sol.org>
References: <1180561713.3633.27.camel@dhcp231-215.rdu.redhat.com> <20070603205653.GE25869@devserv.devel.redhat.com> <1180964306.14220.34.camel@moss-spartans.epoch.ncsc.mil> <1181075666.3978.31.camel@localhost.localdomain> <Line.LNX.4.64.0706051658170.23379@d.namei> <20070605211616.GE23291@devserv.devel.redhat.com> <1181111433.3978.48.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1181111433.3978.48.camel@localhost.localdomain>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

* Eric Paris (eparis@redhat.com) wrote:
> On Tue, 2007-06-05 at 17:16 -0400, Alan Cox wrote:
> > On Tue, Jun 05, 2007 at 05:00:51PM -0400, James Morris wrote:
> > > This should be an unsigned long.
> > > 
> > > I wonder if the default should be for this value to be zero (i.e. preserve 
> > > existing behavior).  It could break binaries, albeit potentially insecure 
> > 
> > Agreed - DOSemu type apps and lrmi need to map at zero for vm86
> 
> And so it shall be!
> 
> Signed-off-by: Eric Paris <eparis@redhat.com>

With James' fix and real changelog ;-)

Acked-by: Chris Wright <chrisw@sous-sol.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
