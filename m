Subject: Re: [PATCH] disallow * and ~ in rules
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Joshua Brindle <jbrindle@tresys.com>
Cc: selinux <selinux@tycho.nsa.gov>
In-Reply-To: <200506231636.35348.jbrindle@tresys.com>
References: <1119543471.8955.5.camel@localhost>
	 <200506231529.07106.jbrindle@tresys.com>
	 <1119557965.28493.273.camel@moss-spartans.epoch.ncsc.mil>
	 <200506231636.35348.jbrindle@tresys.com>
Content-Type: text/plain
Date: Fri, 24 Jun 2005 09:59:55 -0400
Message-Id: <1119621595.12865.76.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2005-06-23 at 16:36 -0400, Joshua Brindle wrote:
> Fair enough, attached is hopefully the final patch, * and ~ disabled in all 
> type sets other than neverallow and removed from role sets entirely.

Thanks, merged (checkpolicy 1.25.1).

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
