Message-ID: <1490189293.27242.1.camel@tycho.nsa.gov>
Subject: Re: net_admin audit for setsockopt SO_SNDBUFFORCE
From: Stephen Smalley <sds@tycho.nsa.gov>
To: russell@coker.com.au, selinux@tycho.nsa.gov
Date: Wed, 22 Mar 2017 09:28:13 -0400
In-Reply-To: <3955630.trR7UcfmOm@russell.coker.com.au>
References: <CAJ2a_DdNpZ5vLtCmzC+o94zQrCGWwRYar5xYa4jyxohxnu7AZA@mail.gmail.com>
 <1490119264.2050.1.camel@tycho.nsa.gov>
 <3955630.trR7UcfmOm@russell.coker.com.au>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Wed, 2017-03-22 at 22:49 +1100, Russell Coker wrote:
> On Tuesday, 21 March 2017 2:01:04 PM AEDT Stephen Smalley wrote:
> > On Tue, 2017-03-21 at 16:06 +0100, cgzones wrote:
> > > Hi list,
> > > this thread[1] about setsockopt(...,...,SO_SNDBUFFORCE), which
> > > triggers widely due to systemd, let me think about the recent
> > > SELinux
> > > kernel fixes: the reordering of dac_read_search and dac_override
> > > and
> > > also the cap_wake_alarm fix.
> > > 
> > > Would it make sense to test, if the send buffer is really set to
> > > a
> > > higher value than wmem_max, before testing for the cap_net_admin
> > > permission[2]?
> > > (might also apply to SO_RCVBUFFORCE)
> > 
> > Probably not, since SO_SNDBUFFORCE only exists to allow a process
> > with
> > CAP_NET_ADMIN to override the wmem_max limit per the man
> > page.  IOW,
> > only processes with CAP_NET_ADMIN should ever use that option. 
> > dontaudit'ing that does not seem like a good idea either; I think
> > you
> > have to allow it or risk silent breakage.
> 
> We have had sshd, tor, and rpcbind denied access to that for some
> time without 
> any apparent breakage.

Two concerns with that:
1) The breakage might be subtle and not apparent, but nonetheless real.
  They are presumably using SO_SNDBUFFORCE for a reason, not just for
fun.  At the least, it may be degrading performance, possibly
increasing potential for DoS, or similar.

2) If we dontaudit net_admin now for SO_SNDBUFFORCE, and any of these
programs later introduce code (or any of the libraries that they use do
so) that actually requires net_admin for another purpose, we won't see
the denial and users will experience breakage with no indication as to
cause.

> 
> > What would perhaps be better would be to introduce LSM hooks to
> > allow
> > finer-grained distinctions to be made among the different
> > CAP_NET_ADMIN
> > cases, ala issue #26.  Then the impact of allowing net_admin would
> > be
> > less significant.
> 
> Yes that would be good.
> 
