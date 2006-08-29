Subject: Re: ipsec and getpeercon()
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Joshua Brindle <jbrindle@tresys.com>
Cc: Joy Latten <latten@us.ibm.com>,
        Venkat Yekkirala <vyekkirala@TrustedCS.com>, selinux@tycho.nsa.gov,
        paul.moore@hp.com
In-Reply-To: <1156883110.22210.222.camel@moss-spartans.epoch.ncsc.mil>
References: <1156874881.6255.5.camel@twoface.columbia.tresys.com>
	 <1156880256.22210.216.camel@moss-spartans.epoch.ncsc.mil>
	 <1156880819.8075.14.camel@twoface.columbia.tresys.com>
	 <1156883110.22210.222.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Tue, 29 Aug 2006 16:32:51 -0400
Message-Id: <1156883571.22210.225.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2006-08-29 at 16:25 -0400, Stephen Smalley wrote:
> On Tue, 2006-08-29 at 15:46 -0400, Joshua Brindle wrote:
> > On Tue, 2006-08-29 at 15:37 -0400, Stephen Smalley wrote:
> > > On Tue, 2006-08-29 at 14:08 -0400, Joshua Brindle wrote:
> > > > I'm trying to use getpeercon() with a tcp stream socket over an ipsec
> > > > host2host connection and it isn't working, it always returns the context
> > > > of the local domain/socket:
> > > > 
> > > > 
> > > > [root@rawhide-clone ~]# runcon -t passwd_t ./server
> > > > server: got connection from 10.1.13.104, root:system_r:passwd_t:s0-s0:c0.c255
> > > > 
> > > > [root@rawhide-clone ~]# runcon -t initrc_t ./server
> > > > server: got connection from 10.1.13.104, root:system_r:initrc_t:s0-s0:c0.c255
> > > > 
> > > > the process connecting is unconfined_t
> > > > 
> > > > Am I doing something wrong or is something broken?
> > > 
> > > You didn't provide much information above.  Kernel version?  ipsec-tools
> > > version?  racoon version?  ipsec configuration?  setkey -D output?
> > > setkey -DP output?
> > 
> > Sorry,
> > 
> > Linux rawhide-clone 2.6.17-1.2586.fc6 #1 SMP Thu Aug 24 08:51:22 EDT
> > 2006 i686 i686 i386 GNU/Linux
> > 
> > ipsec-tools.i386                         0.6.5-3.1
> > 
> > [root@rawhide-clone ~]# setkey -D
> <snip>
> > [root@rawhide-clone ~]# setkey -D
> 
> One of those was supposed to be a setkey -DP.
> 
> You did remember to specify a -ctx option when you added spd entries,
> right?

BTW, Joy & Venkat - it would be nice if the usage/configuration of the
ipsec labeling was documented somewhere.  I've seen emails in the past
with sample usage, but has it been captured anywhere we can refer people
to, like in the Fedora SELinux wiki?

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
