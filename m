Subject: Re: [RFC][PATCH 0/3] Reduce number of avtab nodes
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Joshua Brindle <jbrindle@tresys.com>
Cc: Valdis.Kletnieks@vt.edu, russell@coker.com.au,
   James Morris <jmorris@redhat.com>, selinux@tycho.nsa.gov
In-Reply-To: <42F2366E.3050106@tresys.com>
References: <1122655799.6573.193.camel@moss-spartans.epoch.ncsc.mil>
	 <42EE3879.2050409@tresys.com>
	 <1122908944.6573.305.camel@moss-spartans.epoch.ncsc.mil>
	 <200508041757.54938.russell@coker.com.au>
	 <200508041435.j74EZ4jY011001@turing-police.cc.vt.edu>
	 <1123166289.13654.59.camel@moss-spartans.epoch.ncsc.mil>
	 <42F2366E.3050106@tresys.com>
Content-Type: text/plain
Date: Thu, 04 Aug 2005 11:45:10 -0400
Message-Id: <1123170310.13654.64.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2005-08-04 at 11:38 -0400, Joshua Brindle wrote:
> But just incase (also mentioned in a previous email), would it be 
> possible to use a macro in the kernel to switch between 16 and 32 bit 
> avtab keys in the kernel and then make checkpolicy write a "fat" policy 
> if the types exceed 16 bits? This would allow the possibility of having 
> a huge number of types without penalizing all users.

I don't think we want a kernel config option altering the expected
binary policy format.  That would also mean that /selinux/policyvers ==
n could have two meanings depending on how the kernel was configured,
leaving userspace rather confused about what to provide it.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
