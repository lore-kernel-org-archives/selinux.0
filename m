Subject: Re: Proposed policy feature: $1_domain attribute
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Ivan Gyurdiev <ivg2@cornell.edu>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1109688827.2205.8.camel@cobra.ivg2.net>
References: <1109685518.764.9.camel@cobra.ivg2.net>
	 <1109687748.10589.2.camel@moss-spartans.epoch.ncsc.mil>
	 <1109688827.2205.8.camel@cobra.ivg2.net>
Content-Type: text/plain
Date: Tue, 01 Mar 2005 09:45:41 -0500
Message-Id: <1109688341.10589.14.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2005-03-01 at 09:53 -0500, Ivan Gyurdiev wrote:
> >can_ptrace?  You could easily end up allowing unintended permissions
> >directly to the user domain that were previously limited to a specific
> >program.
> 
> Can you elaborate? I thought can_ptrace was needed for the proper
> operation of the strace command.

If the program domain has enhanced permissions for its function beyond
what the user domain is directly allowed, and you allow the user domain
to ptrace the program domain, then you allow it to completely control
the program and thus indirectly gain those permissions.  No different
than ptracing setuid root programs.

-- 
Stephen Smalley <sds@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
