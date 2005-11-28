Subject: Re: [PATCH] wrap char*** for user_get_roles()
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Joshua Brindle <jbrindle@tresys.com>
Cc: Daniel J Walsh <dwalsh@redhat.com>, SELinux List <SELinux@tycho.nsa.gov>
In-Reply-To: <1133206170.17541.2.camel@twoface.columbia.tresys.com>
References: <1133205192.17541.1.camel@twoface.columbia.tresys.com>
	 <438B5A15.4060604@redhat.com>
	 <1133206170.17541.2.camel@twoface.columbia.tresys.com>
Content-Type: text/plain
Date: Mon, 28 Nov 2005 15:00:47 -0500
Message-Id: <1133208047.348.244.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2005-11-28 at 14:29 -0500, Joshua Brindle wrote:
> On Mon, 2005-11-28 at 14:27 -0500, Daniel J Walsh wrote:
> > Joshua Brindle wrote:
> > > This adds wrappers for char*** so that semanage_user_get_roles will
> > > work. I added the test to the user test (-u), please let me know if
> > > there are any issues with this.
> > >
> > >   
> > No patch attached.
> > 
> 
> oops.

Thanks, merged.  

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
