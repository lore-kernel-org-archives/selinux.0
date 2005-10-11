Subject: Re: [ SEMANAGE ] [ SEPOL ] More database work
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Joshua Brindle <jbrindle@tresys.com>
Cc: Ivan Gyurdiev <ivg2@cornell.edu>, SELinux-dev@tresys.com,
   dwalsh@redhat.com, selinux@tycho.nsa.gov
In-Reply-To: <1128719862.1450.119.camel@moss-spartans.epoch.ncsc.mil>
References: <43454A61.8010907@cornell.edu>
	 <1128626875.15836.168.camel@moss-spartans.epoch.ncsc.mil>
	 <1128695426.1450.26.camel@moss-spartans.epoch.ncsc.mil>
	 <1128700358.1450.39.camel@moss-spartans.epoch.ncsc.mil>
	 <1128709856.1450.75.camel@moss-spartans.epoch.ncsc.mil>
	 <4346CE4C.1030201@tresys.com>
	 <1128714852.1450.90.camel@moss-spartans.epoch.ncsc.mil>
	 <1128719862.1450.119.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Tue, 11 Oct 2005 08:51:55 -0400
Message-Id: <1129035115.3308.67.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2005-10-07 at 17:17 -0400, Stephen Smalley wrote:
> I left struct sepol_module_package publically defined, just wrapping its
> policydb pointer, since it didn't seem to expose any internals
> otherwise, so libsemanage and others users can still directly reference
> p->policy, p->file_contexts, and p->file_contexts_len (but not anything
> within p->policy).  Let me know if you think it should be made
> completely opaque (or send a patch); if so, we'll have to update its
> users to use get/set methods any time they directly reference the
> fields.  Note that the create method allocates the struct and creates
> its policydb for it.  

Hi all,

Any thoughts on the above question?  If we leave it publically defined,
then users can still directly allocate/free sepol_module_package's
rather than using the provided create/free interfaces and can directly
access the policy, file_contexts, and file_context_len fields.  Do we
anticipate sepol_module_package's including other information in the
future?

Also, I wanted to note that when I introduced create/free interfaces for
sepol_module_package, I had to rename the existing interface named
"sepol_module_package_create" to "sepol_module_package_create_file".
That interface was for creating a package file from a policy file and a
file contexts file, not for creating the struct itself.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
