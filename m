Subject: Re: polyinstantiation support in fs?
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Joshua Brindle <method@gentoo.org>
Cc: =?ISO-8859-1?Q?Magos=E1nyi_=C1rp=E1d?= <mag@bunuel.tii.matav.hu>,
   SELinux <SELinux@tycho.nsa.gov>
In-Reply-To: <402D17A7.3020006@gentoo.org>
References: <1076619586.2481.147.camel@kusturica>
	 <1076681620.10189.25.camel@moss-spartans.epoch.ncsc.mil>
	 <402D17A7.3020006@gentoo.org>
Content-Type: text/plain
Message-Id: <1076697269.10189.179.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Fri, 13 Feb 2004 13:34:29 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2004-02-13 at 13:29, Joshua Brindle wrote:
> Would this support be in the VFS or each filesystem?

The VFS.  Initial step is transparent redirection to a member directory
based on policy; next step is to provide a union directory mechanism
that provides a single unified view of all accessible member directories
basedo on policy.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
