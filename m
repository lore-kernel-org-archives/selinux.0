Subject: Re: Proposed policy feature: $1_domain attribute
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Ivan Gyurdiev <ivg2@cornell.edu>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1109685518.764.9.camel@cobra.ivg2.net>
References: <1109685518.764.9.camel@cobra.ivg2.net>
Content-Type: text/plain
Date: Tue, 01 Mar 2005 09:35:48 -0500
Message-Id: <1109687748.10589.2.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2005-03-01 at 08:58 -0500, Ivan Gyurdiev wrote:
> I'd like to mark all role-dependent domains with a new attribute
> $1_domain (analogous to $1_file_type), and then do the following in
> base_user_macros.te:
> 
> can_ps($1, $1_domain)
> can_ptrace($1, $1_domain)
> 
> Objections?

can_ptrace?  You could easily end up allowing unintended permissions
directly to the user domain that were previously limited to a specific
program.

-- 
Stephen Smalley <sds@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
