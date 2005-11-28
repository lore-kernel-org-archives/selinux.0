Subject: Re: link between roles and domains
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Guillaume PETITJEAN <guillaume.petitjean@st.com>
Cc: selinux <selinux@tycho.nsa.gov>
In-Reply-To: <438183C1.5070403@st.com>
References: <438183C1.5070403@st.com>
Content-Type: text/plain
Date: Mon, 28 Nov 2005 10:46:17 -0500
Message-Id: <1133192777.348.117.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2005-11-21 at 09:22 +0100, Guillaume PETITJEAN wrote:
> Hello,
> 
> I'm new to SELinux.
> 
> I have a question regarding the management of users and roles.
> 
> I understood that a user is associated with a role (or several roles) 
> and that each role is allowed to enter a set of domain. I understood  
> how access control permissions are defined on couple of domains and the 
> process of domain transitions. But I didn't understand which domain 
> (among the set of domains allowed for a role) is selected at any time.
> 
> In other terms let's say you have a process foo belonging to the role 
> user_r and suppose user_r is allowed for (domain1_t, domain2_t, 
> domain3_t), how does the policy decides to which domain will belong the 
> process in practice in order to compute security decisions ?

The security context of a user process is set up by some "entrypoint"
program, like login or sshd, by querying libselinux for an ordered list
of reachable security contexts from the entrypoint process for the user.
libselinux consults the kernel security server via selinuxfs as well as
a default_contexts configuration to generate and order this list.  The
kernel security server computes reachability based on process transition
permission from the context of the entrypoint process to contexts for
the user.

Once the security context has been initially set for the user process,
any subsequent domain transitions are governed by the policy based on
the usual (file:execute, process:transition, file:entrypoint) triple.
Any accesses by a process are governed by the domain stored in its
security context.  A process may only have a single domain in its
security context at any given time.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
