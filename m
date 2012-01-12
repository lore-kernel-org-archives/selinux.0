Subject: Re: SELinux for Mandriva Linux
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Eugene Budanov <eugene.budanov@rosalab.ru>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <76466968.6308.1326352810378.JavaMail.root@collab.rosalab.ru>
References: <76466968.6308.1326352810378.JavaMail.root@collab.rosalab.ru>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 12 Jan 2012 09:53:04 -0500
Message-ID: <1326379984.26969.38.camel@moss-pluto>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2012-01-12 at 10:20 +0300, Eugene Budanov wrote:
> Hi!
> 
> At first, I apologize for my terrible English.
> 
> I'm trying to make a port of SELinux for ROSA/Mandriva Linux from Fedora Linux.
> But a have a problem. In general, the most functions and packages built and works fine but I cannot compile package for selinux policy. It crashes with this error:
> 
>  tmp/unconfineduser.mod.role
> echo "')" >> tmp/unconfineduser.mod.role
> m4 -D enable_mcs -D distro_redhat -D mls_num_sens=16 -D mls_num_cats=1024 -D mcs_num_cats=1024 -D hide_broken_symptoms -s support/divert.m4 policy/support/file_patterns.spt policy/support/ipc_patterns.spt policy/support/obj_perm_sets.spt policy/support/misc_patterns.spt policy/support/misc_macros.spt policy/support/mls_mcs_macros.spt policy/support/loadable_module.spt support/undivert.m4 tmp/generated_definitions.conf tmp/all_interfaces.conf policy/modules/roles/unconfineduser.te tmp/unconfineduser.mod.role > tmp/unconfineduser.tmp
> /usr/bin/checkmodule -M -m tmp/unconfineduser.tmp -o tmp/unconfineduser.mod
> /usr/bin/checkmodule:  loading policy configuration from tmp/unconfineduser.tmp
> policy/modules/roles/unconfineduser.te":47:ERROR 'unknown role unconfined_r' at token ';' on line 3315:
> #line 47
>         role unconfined_r types unconfined_t;

Offhand, I would guess that this is due to a change made in the
checkpolicy policy compiler that requires you to separately declare
roles on their own rather than implicitly declaring them as part of any
role...types declaration.  So you would need to add a:
role unconfined_r;
to your policy.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
