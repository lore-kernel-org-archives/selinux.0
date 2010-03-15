Date: Tue, 16 Mar 2010 08:31:35 +1100 (EST)
From: James Morris <jmorris@namei.org>
To: Stephen Smalley <sds@tycho.nsa.gov>
cc: Eric Paris <eparis@parisplace.org>, Russell Coker <russell@coker.com.au>,
        selinux@tycho.nsa.gov
Subject: Re: [PATCH] SELinux:  Reduce max avtab size to avoid page allocation
 failures
In-Reply-To: <1268664131.15512.54.camel@moss-pluto.epoch.ncsc.mil>
Message-ID: <alpine.LRH.2.00.1003160831220.13330@tundra.namei.org>
References: <1268664131.15512.54.camel@moss-pluto.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 15 Mar 2010, Stephen Smalley wrote:

> Reduce MAX_AVTAB_HASH_BITS so that the avtab allocation is an order 2
> allocation rather than an order 4 allocation on x86_64.  This
> addresses reports of page allocation failures:
> http://marc.info/?l=selinux&m=126757230625867&w=2
> https://bugzilla.redhat.com/show_bug.cgi?id=570433
> 
> Reported-by:  Russell Coker <russell@coker.com.au>
> Signed-off-by:  Stephen D. Smalley <sds@tycho.nsa.gov>


Applied to
git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/security-testing-2.6#next

-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
