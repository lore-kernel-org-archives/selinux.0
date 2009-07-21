Subject: Re: [PATCH 1/2] VM/SELinux: require CAP_SYS_RAWIO for all
 mmap_zero operations
From: Eric Paris <eparis@redhat.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org, selinux@tycho.nsa.gov,
        linux-security-module@vger.kernel.org, sds@tycho.nsa.gov,
        jmorris@namei.org, spender@grsecurity.net, dwalsh@redhat.com,
        cl@linux-foundation.org, arjan@infradead.org, kyle@mcmartin.ca,
        cpardy@redhat.com, arnd@arndb.de
In-Reply-To: <20090721160437.5bda68b4@lxorguk.ukuu.org.uk>
References: <20090721144157.14159.23439.stgit@paris.rdu.redhat.com>
	 <20090721160437.5bda68b4@lxorguk.ukuu.org.uk>
Content-Type: text/plain
Date: Tue, 21 Jul 2009 11:18:44 -0400
Message-Id: <1248189524.2654.301.camel@localhost>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2009-07-21 at 16:04 +0100, Alan Cox wrote:
> On Tue, 21 Jul 2009 10:41:58 -0400
> Eric Paris <eparis@redhat.com> wrote:
> 
> > Currently non-SELinux systems need CAP_SYS_RAWIO for an application to mmap
> > the 0 page.  On SELinux systems they need a specific SELinux permission,
> > but do not need CAP_SYS_RAWIO.  This has proved to be a poor decision by
> > the SELinux team as, by default, SELinux users are logged in unconfined and
> > thus a malicious non-root has nothing stopping them from mapping the 0 page
> > of virtual memory.
> 
> So the poor decision is in fact that the SELinux users start as
> unconfined rather than taking away a few things like the the min map
> stuff which can then be given back to specific apps.

See Fedora Core 2 of an example why confining users causes people to
just turn off SELinux.  In F10 we had around 90% SELinux enforcing of
machines the reported to smolt for more than 3 months.  We are trying to
slowly reign people in with SELinux and confining the user is one of
those near impossibilities without breaking every power user out
there....

> > On a non-SELinux system, a malicious non-root user is unable to do this, as
> > they need CAP_SYS_RAWIO.
> > 
> > This patch checks CAP_SYS_RAWIO for all operations which attemt to map a
> > page below mmap_min_addr.
> 
> So "wine" now needs to run with CAP_SYS_RAWIO or you turn all the
> security off.

Now, as in today, yes.  To run wine today it either needs CAP_SYS_RAWIO
or you disable for the whole system.  I noted that I believe ubuntu just
turns it off for the whole system when you install WINE.  This patch
doesn't change that fact.  All it does is add that requirement to
SELinux systems that already exists on non-selinux systems.

> Am I missing something here, this "solution" sounds completely brain
> dead ?

Well, with patch 2/2 you still get your SELinux protections (only for 1
page) even if you disable it for the whole system.  So in the end, you
have better protection than you have today with this series....

-Eric


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
