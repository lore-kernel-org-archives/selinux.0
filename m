Subject: Re: memory leak in services.c
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Jason Tang <jtang@tresys.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1125076427.5306.19.camel@localhost.localdomain>
References: <1125076427.5306.19.camel@localhost.localdomain>
Content-Type: text/plain
Date: Fri, 26 Aug 2005 14:15:20 -0400
Message-Id: <1125080120.8692.73.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2005-08-26 at 13:13 -0400, Jason Tang wrote:
> The following patch corrects a memory leak in sepol_context_to_sid()
> within libsepol/services.c.  The context was malloc()ed but never
> free()ed afterwards.

Hmmm...suggests that the introduction of the
sepol_ctx_struct_from_string() helper may lead to confusion because it
hides the allocation internally, and context_destroy doesn't free the
context struct itself.  Possibly a bad interface choice.  But I'll merge
this patch for now.
 
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
