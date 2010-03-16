Subject: Re: [PATCH] SELinux:  Reduce max avtab size to avoid page
 allocation failures
From: Stephen Smalley <sds@tycho.nsa.gov>
To: James Morris <jmorris@namei.org>
Cc: Eric Paris <eparis@parisplace.org>, Russell Coker <russell@coker.com.au>,
        selinux@tycho.nsa.gov
In-Reply-To: <alpine.LRH.2.00.1003160831220.13330@tundra.namei.org>
References: <1268664131.15512.54.camel@moss-pluto.epoch.ncsc.mil>
	 <alpine.LRH.2.00.1003160831220.13330@tundra.namei.org>
Content-Type: text/plain
Date: Tue, 16 Mar 2010 09:45:51 -0400
Message-Id: <1268747151.27024.17.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2010-03-16 at 08:31 +1100, James Morris wrote:
> On Mon, 15 Mar 2010, Stephen Smalley wrote:
> 
> > Reduce MAX_AVTAB_HASH_BITS so that the avtab allocation is an order 2
> > allocation rather than an order 4 allocation on x86_64.  This
> > addresses reports of page allocation failures:
> > http://marc.info/?l=selinux&m=126757230625867&w=2
> > https://bugzilla.redhat.com/show_bug.cgi?id=570433
> > 
> > Reported-by:  Russell Coker <russell@coker.com.au>
> > Signed-off-by:  Stephen D. Smalley <sds@tycho.nsa.gov>
> 
> 
> Applied to
> git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/security-testing-2.6#next

Candidate for -stable?  for 2.6.34?

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
