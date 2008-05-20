Subject: Re: roles in base module
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Joshua Brindle <method@manicmethod.com>
Cc: Martin Orr <martin@martinorr.name>, SELinux List <selinux@tycho.nsa.gov>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>,
        Karl MacMillan <kmacmillan@tresys.com>
In-Reply-To: <4831F82F.3090702@manicmethod.com>
References: <4820D9FB.8010802@martinorr.name>
	 <1210248530.6434.145.camel@moss-spartans.epoch.ncsc.mil>
	 <482E1DCD.1000505@manicmethod.com>
	 <1211199052.7486.30.camel@moss-spartans.epoch.ncsc.mil>
	 <4831F82F.3090702@manicmethod.com>
Content-Type: text/plain
Date: Tue, 20 May 2008 13:55:38 -0400
Message-Id: <1211306138.7486.189.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Mon, 2008-05-19 at 17:59 -0400, Joshua Brindle wrote:
> Stephen Smalley wrote:
> > On Fri, 2008-05-16 at 19:50 -0400, Joshua Brindle wrote:
> >> Stephen Smalley wrote:
> >>> On Tue, 2008-05-06 at 23:21 +0100, Martin Orr wrote:
> >>>> Should I be able to build trunk refpolicy with the user roles included in
> >>>> the base module?  I can build it with the roles as modules, but if I try
> >>>> building them into base I get
> >>>> /usr/bin/checkmodule -M base.conf -o tmp/base.mod
> >>>> /usr/bin/checkmodule:  loading policy configuration from base.conf
> >>>> libsepol.expand_module: Error while indexing out symbols
> >>>> /usr/bin/checkmodule:  expand module failed
> >>>>
> >>>> I have refpolicy revision 2669, libsepol 2.0.25, checkpolicy 2.0.12.  I have
> >>>> attached the modules.conf I am using, which seems to be the minimum number
> >>>> of things I need to build in to be able to build in roles.
> >>> Reproduced here as well, and naturally one should be able to build roles
> >>> into base.
> >>>
> >>> We've seen this error condition in the past - it indicates that there is
> >>> a hole in the symbol table, and requires mapping support in the expand
> >>> code for roles to correctly handle it.  So that represents a
> >>> bug/limitation of the current policy compiler.
> >>>
> >>> Walking through it I see that it is omitting the auditadm_r and secadm_r
> >>> roles during the expand, and this is leaving the holes in the symbol
> >>> table.
> >>>
> >>> Fixing the compiler requires adding mapping support for the roles
> >>> similar to what Karl did for booleans in r2308.
> >>>
> >>> Hopefully though Chris can work around it in the policy in the interim.
> >>>
> >> Patch below should fix both user and role mapping issues.
> > 
> > Why is it that we don't need a usermap too?
> > 
> 
> Updated patch includes usermap and mapping in constraint_node_clone, completely untested.

Still fails in the same way as reported by Martin upon semodule -b of the base module.
libsepol.context_read_and_validate: invalid security context
libsepol.sepol_set_policydb_from_file: can't read binary policy: Success
Error reading policy /etc/selinux/test/policy/policy.23: Success
libsemanage.semanage_install_active: setfiles returned error code 1.

Also fails upon just trying to semodule -B an existing valid policy
store using the patched libsepol.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
