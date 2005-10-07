Subject: Re: [ SEMANAGE ] [ SEPOL ] More database work
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Ivan Gyurdiev <ivg2@cornell.edu>
Cc: SELinux-dev@tresys.com, dwalsh@redhat.com, selinux@tycho.nsa.gov
In-Reply-To: <1128700907.1450.50.camel@moss-spartans.epoch.ncsc.mil>
References: <43454A61.8010907@cornell.edu>
	 <1128626875.15836.168.camel@moss-spartans.epoch.ncsc.mil>
	 <1128695426.1450.26.camel@moss-spartans.epoch.ncsc.mil>
	 <434699D7.9040307@cornell.edu>
	 <1128700907.1450.50.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Fri, 07 Oct 2005 13:04:18 -0400
Message-Id: <1128704658.1450.58.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2005-10-07 at 12:01 -0400, Stephen Smalley wrote:
> With regard to the policy type in the create interface, I was thinking
> that sepol_policydb_create should include calling policydb_init, which
> presently takes the type and sets it.  However, there isn't any obvious
> reason to do that there, so possibly I should drop it from the
> policydb_init internal function interface as well, and just let the
> type/version be initialized as appropriate elsewhere (policydb_read for
> policydb's created from an existing image; expand_module for policydb's
> created from module expansion; possibly via separate set functions for
> newly constructed ones if we need that support in libsemanage).

Ok, I dropped policy_type from sepol_policydb_create (and policydb_init
internally), and added sepol_policydb_set_typevers (set policy type and
automatically set policy version to max supported for the type) and
sepol_policydb_set_vers (change policy version to a different value than
the max) for explicit manipulation of the type and version.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
