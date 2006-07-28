Subject: Re: [PATCH] SELinux: new /proc/self/attr/ipccreate for
	expliciteipc object labeling
From: Stephen Smalley <sds@tycho.nsa.gov>
To: James Morris <jmorris@namei.org>
Cc: Valdis.Kletnieks@vt.edu, Eric Paris <eparis@parisplace.org>,
        selinux@tycho.nsa.gov, jbrindle@tresys.com
In-Reply-To: <Pine.LNX.4.64.0607280016340.13981@d.namei>
References: 
	 <6FE441CD9F0C0C479F2D88F959B015882989A9@exchange.columbia.tresys.com>
	 <1154019529.5028.19.camel@localhost.localdomain>
	 <200607272116.k6RLGrFC026797@turing-police.cc.vt.edu>
	 <Pine.LNX.4.64.0607280016340.13981@d.namei>
Content-Type: text/plain
Date: Fri, 28 Jul 2006 07:42:47 -0400
Message-Id: <1154086967.31881.4.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2006-07-28 at 00:17 -0400, James Morris wrote:
> On Thu, 27 Jul 2006, Valdis.Kletnieks@vt.edu wrote:
> 
> > > A note of interest, this only leaves 1 bit in the process security
> > > class.  I don't currently have any plans to use any more, but it is
> > > something to remember.
> > 
> > Does anybody have a good plan for what to do when we run out?
> 
> Probably create another process class and abstract it so policy just sees 
> a single class.

Yes, that is the plan.  The class/permission distinction is fairly
arbitrary anyway; abstractly, there is really only a set of permissions,
where file__read and chr_file__read are two different permissions.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
