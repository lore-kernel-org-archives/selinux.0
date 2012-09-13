Message-ID: <1347564722.24918.24.camel@moss-pluto.epoch.ncsc.mil>
Subject: Re: Security hooks for rpm
From: Stephen Smalley <sds@tycho.nsa.gov>
To: jwcart2@tycho.nsa.gov
Cc: Elena Reshetova <elena.reshetova@gmail.com>, SELinux@tycho.nsa.gov,
        Steve Lawrence <slawrence@tresys.com>
Date: Thu, 13 Sep 2012 15:32:02 -0400
In-Reply-To: <1347564198.28276.14.camel@moss-lions.epoch.ncsc.mil>
References: 
	<CALrft9-GWLKNZU=4yDBNx6hp=HJbh9qCUEntvYypz3F63Sd==w@mail.gmail.com>
	 <1347288243.9456.53.camel@moss-pluto.epoch.ncsc.mil>
	 <1347564198.28276.14.camel@moss-lions.epoch.ncsc.mil>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2012-09-13 at 15:23 -0400, James Carter wrote:
> On Mon, 2012-09-10 at 10:44 -0400, Stephen Smalley wrote:
> > > 7. rpmRC SECURITYHOOK_SCRIPT_EXEC_FUNC(ARGV_const_t argv)
> > 
> > It looks like our rpm_execcon() hook takes more arguments, but they
> > aren't truly unique or used, so this seems reasonable to me as a
> > simplified interface.
> > 
> 
> rpm_execcon() is not a part of the collection plugin support. I guess
> the plan would be to remove all of the SELinux support built in (such as
> the %sepolicy section)?

Yes, that's the idea - migrate all of the SELinux support, whether
built-in or via the collections plugin interface, into a single plugin
architecture that can also be leveraged by others like Tizen/MSSF.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
