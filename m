Subject: Re: Request for multiple mailing lists
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Joshua Brindle <method@manicmethod.com>
Cc: russell@coker.com.au, Vesa-Matti J Kari <vmkari@cc.helsinki.fi>,
        Andy Warner <warner@rubix.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        SE-Linux <selinux@tycho.nsa.gov>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>,
        Daniel J Walsh <dwalsh@redhat.com>
In-Reply-To: <489C7DEE.7090006@manicmethod.com>
References: <489B25B6.4080309@windriver.com> <489C1BB1.2060701@rubix.com>
	 <Pine.LNX.4.64L.0808081319150.25440@ruuvi.it.helsinki.fi>
	 <200808082048.53795.russell@coker.com.au>
	 <489C7DEE.7090006@manicmethod.com>
Content-Type: text/plain
Date: Thu, 14 Aug 2008 12:16:16 -0400
Message-Id: <1218730576.29535.20.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Fri, 2008-08-08 at 13:10 -0400, Joshua Brindle wrote:
> Russell Coker wrote:
> > On Friday 08 August 2008 20:33, Vesa-Matti J Kari <vmkari@cc.helsinki.fi> 
> 
> <snip>
> 
> Back on topic:
> 
> I've multiple times in the past that I'd like to have a policy list that was separate. The main problem here is that all the core developers would almost certainly be subscribed to both (all) of them so there is little motivation on this end to split the lists out.
> 
> I completely disagree with splitting kernel and userland out as kernel changes almost always require userland changes, and userland changes are often created to address format changes, etc that are of interest to the kernel.
> 
> That said, even if we had to be subscribed to both it would be easier to disregard the parts less interesting to us (for me, that is policy, for Chris that is the other). 
> 
> So I'll +1 the request but believe only 2 lists are necessary.

I'm fine with moving refpolicy patches and discussion to another list
with the exception of changes that touch the core Flask definitions,
which should be copied to both lists as they will affect the kernel or
userspace object managers.

refpolicy certainly doesn't have to be the only policy for SELinux,
although it is a useful source pool that embodies a lot of knowledge
derived over time from the community, and most existing policies are
built from that common source pool.  Prior to refpolicy, the NSA example
policy served the same purpose, and that knowledge and community effort
transitioned from the example policy to refpolicy when refpolicy was
deployed in modern distributions that support SELinux.

While refpolicy is not limited to Tresys (they are just the upstream
maintainers), it seems to make sense to host such a refpolicy list on
the same site that hosts the refpolicy project, so hosting it on
oss.tresys.com would make sense to me.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
