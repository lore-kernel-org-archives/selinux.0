Subject: Re: [PATCH] Protection for exploiting null dereference using mmap
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Eric Paris <eparis@redhat.com>
Cc: Alan Cox <alan@redhat.com>, James Morris <jmorris@namei.org>,
        linux-kernel@vger.kernel.org, selinux@tycho.nsa.gov,
        drepper@redhat.com, roland@redhat.com, arjan@infradead.org,
        mingo@elte.hu, viro@zeniv.linux.org.uk, chrisw@redhat.com,
        sgrubb@redhat.com
In-Reply-To: <1181078927.3978.42.camel@localhost.localdomain>
References: <1180561713.3633.27.camel@dhcp231-215.rdu.redhat.com>
	 <20070603205653.GE25869@devserv.devel.redhat.com>
	 <1180964306.14220.34.camel@moss-spartans.epoch.ncsc.mil>
	 <1181075666.3978.31.camel@localhost.localdomain>
	 <Line.LNX.4.64.0706051658170.23379@d.namei>
	 <20070605211616.GE23291@devserv.devel.redhat.com>
	 <1181078927.3978.42.camel@localhost.localdomain>
Content-Type: text/plain
Date: Wed, 06 Jun 2007 08:47:48 -0400
Message-Id: <1181134068.3699.31.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2007-06-05 at 17:28 -0400, Eric Paris wrote:
> On Tue, 2007-06-05 at 17:16 -0400, Alan Cox wrote:
> > On Tue, Jun 05, 2007 at 05:00:51PM -0400, James Morris wrote:
> > > This should be an unsigned long.
> > > 
> > > I wonder if the default should be for this value to be zero (i.e. preserve 
> > > existing behavior).  It could break binaries, albeit potentially insecure 
> > 
> > Agreed - DOSemu type apps and lrmi need to map at zero for vm86
> 
> While I understand, there are a few users who will have problems with
> this default are we really better to not provide this defense in depth
> for the majority of users and let those with problems turn it off rather
> than provide no defense by default?  I could even provide a different
> default for SELinux and non-SELinux if anyone saw value in that?  But if
> others think that off default is  best I'll send another patch shortly
> with the unsigned long fix and the default set to 0.  My hope is then
> that distros will figure out to turn this on.

I'd be ok with having a different default for SELinux vs. non-SELinux,
i.e. no restrictions by default under dummy/capability, but restrict it
by default to 64k if selinux is enabled.  Then we can use policy to
grant it as needed to the specific programs.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
