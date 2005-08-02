Subject: Re: [ libsepol ] User, context, port records. Bugfixes.
From: Stephen Smalley <sds@tycho.nsa.gov>
To: gyurdiev@redhat.com
Cc: Daniel J Walsh <dwalsh@redhat.com>, jbrindle@tresys.com,
   selinux@tycho.nsa.gov
In-Reply-To: <1122658154.28860.19.camel@celtics.boston.redhat.com>
References: <1122658154.28860.19.camel@celtics.boston.redhat.com>
Content-Type: text/plain
Date: Tue, 02 Aug 2005 09:17:28 -0400
Message-Id: <1122988648.11904.13.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2005-07-29 at 13:29 -0400, Ivan Gyurdiev wrote:
> The following patch replaces the previously added
> high level structures: 
> 
> sepol_ctxinfo_t
> sepol_portinfo_t
> sepol_uinfo_t
> 
> with opaque records:
> 
> sepol_context_t
> sepol_port_t
> sepol_user_t
> 
> The idea is that those opaque records can
> be re-used by libsemanage (not sure exactly
> how to do that without re-implementing
> the entire interface and calling each sepol
> function). In any case, the change stands 
> independently of libsemanage, and using
> opaque data structures in interfaces is 
> a good idea.
> 
> Other changes:
> - changed namespace to some functions in context.c
> to sepol_ctx_struct, in order not to conflict with
> the record namespace
> 
> - fixed a memory leak in context.c on mls-disabled 
> systems with mls contexts
> 
> - fixed improper use of mls_context_to_sid in users.c
> that would cause a crash.
> 
> - made some error messages more clear/verbose

Thanks, merged.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
