Subject: Re: strange policy loading problem
From: Stephen Smalley <sds@tycho.nsa.gov>
To: russell@coker.com.au
Cc: SE-Linux <selinux@tycho.nsa.gov>
In-Reply-To: <1267621594.3436.19.camel@moss-pluto.epoch.ncsc.mil>
References: <201003031018.38030.russell@coker.com.au>
	 <1267621594.3436.19.camel@moss-pluto.epoch.ncsc.mil>
Content-Type: text/plain
Date: Wed, 03 Mar 2010 09:28:54 -0500
Message-Id: <1267626534.6048.22.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2010-03-03 at 08:06 -0500, Stephen Smalley wrote:
> On Wed, 2010-03-03 at 10:18 +1100, Russell Coker wrote:
> > I'm running a 2.6.32 system under KVM and it keeps OOMing when I try to run 
> > semodule.
> > 
> > # free
> >              total       used       free     shared    buffers     cached
> > Mem:        507532     475320      32212          0       4168      11148
> > -/+ buffers/cache:     460004      47528
> > Swap:       524280      19848     504432
> > 
> > The policy.24 file is just under 900K in size, the output of free is above, it 
> > doesn't seem particularly short of RAM.  The dmesg output is below.  Any 
> > suggestions for what I should investigate?
> > 
> > I could just give the VM a gig of RAM, but I run lots of real systems with 
> > less than 512M so I would like this to work.
> 
> - make sure CONFIG_SECURITY_SELINUX_POLICYDB_VERSION_MAX is not set,
> - what are the versions of libsepol, libsemanage, and glibc

- and what do you have in /etc/selinux/semanage.conf?

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
