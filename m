Subject: Re: vserver and vprocunhide
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Daniel Gil Mayol <Daniel.Gil-Mayol@brunel.de>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <200610240919.46906.Daniel.Gil-Mayol@brunel.de>
References: <200610231751.50609.Daniel.Gil-Mayol@brunel.de>
	 <1161625986.3316.108.camel@moss-spartans.epoch.ncsc.mil>
	 <200610240847.58333.Daniel.Gil-Mayol@brunel.de>
	 <200610240919.46906.Daniel.Gil-Mayol@brunel.de>
Content-Type: text/plain
Date: Tue, 24 Oct 2006 11:59:35 -0400
Message-Id: <1161705575.3987.95.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2006-10-24 at 09:19 +0200, Daniel Gil Mayol wrote:
> > > Is the process running as
> > > root? 
> >
> > After execute "ps aux | grep bus" I see the next:
> >
> > dbus     21879  0.0  0.3 10508  768 ?        Ssl  Oct23   0:00
> > dbus-daemon-1 --system
> >
> > so it is not running within a vserver, has its own process;
> > And appear dbus instead of root, must be root?
> 
> I forgot to write -Z (--context), after "ps auxZ | grep bus", I see this:
> 
> root:system_r:dbusd_t           dbus     21879  0.0  0.3 10508  968 ?        
> Ssl  Oct23   0:00 dbus-daemon-1 --system
> 
> So runs as root.

Oh, sorry - so it is the system bus.  So it should be able to generate
the audit messages.  Possibly it lacks the following permissions:
	allow dbusd_t self:capability { audit_write };
	allow dbusd_t self:netlink_audit_socket { create read write
nlmsg_relay };

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
