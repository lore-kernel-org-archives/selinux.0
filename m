From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Curtis.Bowman@atl.frb.org, <SELinux@tycho.nsa.gov>
Subject: Re: VMWare GSX Server under SELinux
Date: Wed, 11 Jun 2003 16:52:07 +1000
References: <20030610223441.10ED085996@p3fed1.frb.org>
In-Reply-To: <20030610223441.10ED085996@p3fed1.frb.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200306111652.07240.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 11 Jun 2003 08:22, Curtis.Bowman@atl.frb.org wrote:
> Has anyone tried with running VMWare under SELinux built on top of Redhat
> 8.0 or another distro that is compatible for VMWare GSX server.  I thought
> it might be a good way to do server consolidation while maintaining high
> security standards for Linux.  Run a couple of Windows 2000 servers with
> VMWare GSX server.  Any thoughts?

It's been done, there is policy for it, however the policy has not been 
updated for a while and may not have kept up to date with the latest core 
policy changes and the latest changes to VMWare and the kernel.

Try it out and report in detail any errors you may encounter, I expect that 
any problems you find can be solved quickly enough.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
