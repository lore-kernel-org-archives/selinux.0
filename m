From: Russell Coker <russell@coker.com.au>
To: selinux@tycho.nsa.gov
Reply-To: russell@coker.com.au
Cc: Stephen Smalley <sds@tycho.nsa.gov>, cgzones <cgzones@googlemail.com>
Subject: Re: net_admin audit for setsockopt SO_SNDBUFFORCE
Date: Wed, 22 Mar 2017 22:49:34 +1100
Message-ID: <3955630.trR7UcfmOm@russell.coker.com.au>
In-Reply-To: <1490119264.2050.1.camel@tycho.nsa.gov>
References: <CAJ2a_DdNpZ5vLtCmzC+o94zQrCGWwRYar5xYa4jyxohxnu7AZA@mail.gmail.com>
 <1490119264.2050.1.camel@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Tuesday, 21 March 2017 2:01:04 PM AEDT Stephen Smalley wrote:
> On Tue, 2017-03-21 at 16:06 +0100, cgzones wrote:
> > Hi list,
> > this thread[1] about setsockopt(...,...,SO_SNDBUFFORCE), which
> > triggers widely due to systemd, let me think about the recent SELinux
> > kernel fixes: the reordering of dac_read_search and dac_override and
> > also the cap_wake_alarm fix.
> > 
> > Would it make sense to test, if the send buffer is really set to a
> > higher value than wmem_max, before testing for the cap_net_admin
> > permission[2]?
> > (might also apply to SO_RCVBUFFORCE)
> 
> Probably not, since SO_SNDBUFFORCE only exists to allow a process with
> CAP_NET_ADMIN to override the wmem_max limit per the man page.  IOW,
> only processes with CAP_NET_ADMIN should ever use that option. 
> dontaudit'ing that does not seem like a good idea either; I think you
> have to allow it or risk silent breakage.

We have had sshd, tor, and rpcbind denied access to that for some time without 
any apparent breakage.

> What would perhaps be better would be to introduce LSM hooks to allow
> finer-grained distinctions to be made among the different CAP_NET_ADMIN
> cases, ala issue #26.  Then the impact of allowing net_admin would be
> less significant.

Yes that would be good.

-- 
My Main Blog         http://etbe.coker.com.au/
My Documents Blog    http://doc.coker.com.au/
