Subject: Re: [PATCH] require in conditional
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Joshua Brindle <jbrindle@tresys.com>
Cc: SELinux List <SELinux@tycho.nsa.gov>
In-Reply-To: <1129128614.3504.13.camel@twoface.columbia.tresys.com>
References: <1129128614.3504.13.camel@twoface.columbia.tresys.com>
Content-Type: text/plain
Date: Thu, 13 Oct 2005 12:46:46 -0400
Message-Id: <1129222006.26188.235.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2005-10-12 at 10:50 -0400, Joshua Brindle wrote:
> This patch changes the parser to allow require blocks inside
> conditionals . This is necessary for reference policy because interfaces
> always add their dependencies in require blocks but won't know they are
> in a conditional. For example:

Thanks, merged (libsepol 1.9.15, checkpolicy 1.27.9).

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
