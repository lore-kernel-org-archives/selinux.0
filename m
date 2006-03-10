Subject: Re: Query MLS info outside of SELinux/LSM?
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Paul Moore <paul.moore@hp.com>
Cc: James Morris <jmorris@namei.org>, SELinux List <selinux@tycho.nsa.gov>
In-Reply-To: <4411B9A9.5020102@hp.com>
References: <4411AFCB.60401@hp.com>
	 <1142010664.25454.128.camel@moss-spartans.epoch.ncsc.mil>
	 <4411B5F2.6060702@hp.com>
	 <1142012234.25454.139.camel@moss-spartans.epoch.ncsc.mil>
	 <4411B9A9.5020102@hp.com>
Content-Type: text/plain
Date: Fri, 10 Mar 2006 12:53:09 -0500
Message-Id: <1142013189.25454.152.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2006-03-10 at 12:38 -0500, Paul Moore wrote:
> Agreed.  Although for most cases in SELinux there are no practical upper 
> bounds so such logic (that I am thinking of anyway) doesn't make sense. 
>     I was just looking for something to tell me the number of MLS levels 
> and categories in the current instantiated policy so I could do some 
> optimizations in the CIPSO/NetLabel code.
> 
> It's not a big deal, there is always another solution.

For experimental patches, you are certainly welcome to add an interface
to the security server to expose such information, and export it to the
rest of the kernel (see some of the recent audit-related patches and
James' skfilter patches for other examples where security server
interfaces are being exported to other kernel subsystems).  We just
don't want the MLS limitation to be the ultimate solution upstream.
 
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
