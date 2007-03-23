Subject: Re: Expunging userspace classes and permissions from kernel headers
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov, Eamon Walsh <ewalsh@tycho.nsa.gov>,
        Eric Paris <eparis@parisplace.org>, James Morris <jmorris@namei.org>,
        Chad Sellers <csellers@tresys.com>
In-Reply-To: <1174667120.31436.232.camel@moss-spartans.epoch.ncsc.mil>
References: <1174569868.31436.22.camel@moss-spartans.epoch.ncsc.mil>
	 <1174571162.19924.36.camel@sgc.columbia.tresys.com>
	 <1174571459.31436.31.camel@moss-spartans.epoch.ncsc.mil>
	 <1174584303.19924.43.camel@sgc.columbia.tresys.com>
	 <1174585916.31436.94.camel@moss-spartans.epoch.ncsc.mil>
	 <1174666169.19924.47.camel@sgc.columbia.tresys.com>
	 <1174667120.31436.232.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Fri, 23 Mar 2007 15:37:32 -0400
Message-Id: <1174678652.28830.6.camel@sgc.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2007-03-23 at 12:25 -0400, Stephen Smalley wrote:
> On Fri, 2007-03-23 at 16:09 +0000, Christopher J. PeBenito wrote:
> > I reverted the comment change and changed "null" to NULL.  Is this what
> > you had in mind (it doesn't have the PAX change yet)?
> 
> Yes, looks sane.  We would then apply that diff (re-based to the kernel
> tree) along with a patch like the following untested one (added a guard
> to both avc_dump_query and validate_classes despite my earlier comment).

I have merged this into trunk and marked pax as userland so it can be
reclaimed.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
