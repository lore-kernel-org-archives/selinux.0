Subject: Re: [RFC] semodule policy
From: Stephen Smalley <sds@tycho.nsa.gov>
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
Cc: SELinux Mail List <selinux@tycho.nsa.gov>
In-Reply-To: <1140123490.12655.183.camel@moss-spartans.epoch.ncsc.mil>
References: <1140118126.13925.211.camel@sgc.columbia.tresys.com>
	 <1140123490.12655.183.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Thu, 16 Feb 2006 16:11:28 -0500
Message-Id: <1140124288.12655.186.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2006-02-16 at 15:58 -0500, Stephen Smalley wrote:
> Should the domain be semanage_t to reflect use of libsemanage, and put
> all three of semodule, setsebool, and semanage into it?

Also chcat.  And genhomedircon will need read access.

BTW, as several of these are python scripts, the domain enforcement is
somewhat illusory.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
