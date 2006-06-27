Subject: Re: [PATCH 1/3] security:  Extend task_kill hook to handle signals
	sent by AIO completion
From: "Timothy R. Chavez" <tinytim@us.ibm.com>
To: James Morris <jmorris@namei.org>
Cc: David Quigley <dpquigl@tycho.nsa.gov>, selinux@tycho.nsa.gov,
        sds@tycho.nsa.gov
In-Reply-To: <Pine.LNX.4.64.0606271625540.3759@d.namei>
References: <1151438496.1294.7.camel@moss-terrapins.epoch.ncsc.mil>
	 <Pine.LNX.4.64.0606271625540.3759@d.namei>
Content-Type: text/plain
Date: Tue, 27 Jun 2006 15:47:59 -0500
Message-Id: <1151441280.6863.8.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2006-06-27 at 16:34 -0400, James Morris wrote:
> On Tue, 27 Jun 2006, David Quigley wrote:
> 
> > + * @task_getsecurityid:
> > + *	Retrieve the security identifier of the process @p.
> > + *	@p contains the task_struct for the process and place is into @sid.
> 
> As long as still LSM exists, we need to avoid SELinux-specific code in the 
> core kernel security framework.  This needs to be reworked to use some 
> kind of abstract security field.
> 
> 
> (Unfortunately, some has crept into Netlink and xfrm hooks, too, and these 
> need to be fixed soon.  The audit code also looks like it's been 
> accumulating SELinux-specific code as well).
> 
> 
> - James

Ah... this answers my question :)

-tim


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
