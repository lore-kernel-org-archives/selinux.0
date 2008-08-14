Date: Fri, 15 Aug 2008 09:05:44 +1000 (EST)
From: James Morris <jmorris@namei.org>
To: Stephen Smalley <sds@tycho.nsa.gov>
cc: Vesa-Matti Kari <vmkari@cc.helsinki.fi>, eparis@parisplace.org,
        selinux@tycho.nsa.gov
Subject: Re: [PATCH] selinux: Unify for- and while-loop style
In-Reply-To: <1218732169.29535.35.camel@moss-spartans.epoch.ncsc.mil>
Message-ID: <alpine.LRH.1.10.0808150859500.1371@tundra.namei.org>
References: <200808070036.m770ajof012753@ruuvi.it.helsinki.fi> <1218732169.29535.35.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 14 Aug 2008, Stephen Smalley wrote:

> 
> On Thu, 2008-08-07 at 03:18 +0300, Vesa-Matti Kari wrote:
> > Replace "thing != NULL" comparisons with just "thing" to make
> > the code look more uniform (mixed styles were used even in the
> > same source file).
> 
> Looks fine to me.
> 
> Acked-by:  Stephen Smalley <sds@tycho.nsa.gov>

Applied to:

git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/security-testing-2.6#next

FWIW, thes kinds of cleanups are not a problem per se, but do require time 
upstream to review, integrate and test them, where such time is often in 
short supply.  I think there's better value in working on finding/fixing 
functional bugs, picking items off the todo list [1] and generally looking 
for ways to make the code better for end users.  One example of the latter 
would be to look for ways to improve performance. There are also several 
works in progress with patches posted asking for review and feedback.


[1]
http://selinuxproject.org/page/Kernel_Development


-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
