Subject: Re: [PATCH] Dropping support for disabling caching of context
	translations (CACHETRANS=0)
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Steve G <linux_4ever@yahoo.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <751432.17898.qm@web51508.mail.yahoo.com>
References: <751432.17898.qm@web51508.mail.yahoo.com>
Content-Type: text/plain
Date: Mon, 12 Mar 2007 14:05:09 -0400
Message-Id: <1173722709.2738.125.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2007-03-08 at 06:53 -0800, Steve G wrote:
> >So, is anyone using CACHETRANS=0?  Do we need to retain it going forward
> >in the trunk?
> 
> Attaching a patch dropping this config option.

Thanks, merged on the trunk.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
