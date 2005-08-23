Subject: Re: [PATCH 3/6] libsepol: resource leaks in policydb.c
From: Stephen Smalley <sds@tycho.nsa.gov>
To: serue@us.ibm.com
Cc: Joshua Brindle <jbrindle@tresys.com>, SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <20050822160238.GC4191@sergelap.austin.ibm.com>
References: <20050822160238.GC4191@sergelap.austin.ibm.com>
Content-Type: text/plain
Date: Tue, 23 Aug 2005 09:15:49 -0400
Message-Id: <1124802949.7874.23.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2005-08-22 at 11:02 -0500, serue@us.ibm.com wrote:
> This patch fixes 2 resource leaks found by Coverity in policydb.c.
> 
> 	1. in avrule_read(), the 'cur' element has been malloc'ed
> 	but not yet added to the avrule->perms list at one point
> 	whene we jump to bad:
> 
> 	2. 'key' is not freed in one case in scope_read().
> 
> The second point makes me wonder - is scope_destroy() fully
> implemented?  It takes 'key' as an argument, but does nothing with
> it.  Same with its third arg.  Of course, they both have attribute
> unused...

I'm merging this patch at present, but I think you are correct about
scope_destroy being ambiguous in its usage - either it shouldn't take
the key as an argument at all, or it should free it.  Given that
scope_destroy is also being used in a hashtab_map call by
policydb_destroy to free the scope, I'd think we would want it to free
the key.  Joshua?

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
