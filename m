Subject: Re: [PATCH] optionals in base
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Joshua Brindle <jbrindle@tresys.com>
Cc: SELinux List <SELinux@tycho.nsa.gov>
In-Reply-To: <43ED0594.6010605@tresys.com>
References: <43ED0594.6010605@tresys.com>
Content-Type: text/plain
Date: Mon, 13 Feb 2006 10:34:51 -0500
Message-Id: <1139844891.14253.47.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2006-02-10 at 16:28 -0500, Joshua Brindle wrote:
> This patch adds support for optionals in base policy. This is necessary 
> because currently optional policy in base is handled with m4 ifdefs 
> which make the rules disappear if the corresponding module isn't 
> present. This means that if the module is inserted at a later time the 
> rules will not be enabled.
> 
> Since we didn't want to diverge the base policy and monolithic policy 
> grammar monolithic policies also support optionals.
> 
> The link step resolves all optional dependancies and therefore all base 
> modules (including ones which are being written to a kernel policy) must 
> call link prior to calling expand. This was added to checkpolicy and to 
> semodule_expand, as well as removing a check for 0 modules in 
> semanage_store.c

Merged as of checkpolicy 1.29.2, libsepol 1.11.14, libsemanage 1.5.23,
and policycoreutils 1.29.21.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
