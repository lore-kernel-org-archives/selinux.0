Subject: Re: link between roles and domains
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Guillaume PETITJEAN <guillaume.petitjean@st.com>
Cc: Karl MacMillan <kmacmillan@tresys.com>, selinux <selinux@tycho.nsa.gov>
In-Reply-To: <438B3418.2070600@st.com>
References: <438183C1.5070403@st.com>
	 <1133192777.348.117.camel@moss-spartans.epoch.ncsc.mil>
	 <438B3418.2070600@st.com>
Content-Type: text/plain
Date: Mon, 28 Nov 2005 12:34:15 -0500
Message-Id: <1133199255.348.180.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2005-11-28 at 17:45 +0100, Guillaume PETITJEAN wrote:
> It's basically what I understood and I'm still missing something : in 
> the example policy (may be it is not representative of a real system ?) 
> there are very few role transitions. And domain transition rules don't 
> take into account the role. Then it seems to me that once a process has 
> been associated the first time to a domain (the domain of the first 
> security context in the default_contexts list) its role isn't used 
> anymore since only domain transitions occur. Or do roles only aim to 
> define the first domain of a process ?
> Where is my mistake ?

The role is primarily a way of organizing sets of domains for user
authorization.  We expect role transitions to be relatively rare (in
comparison to domain transitions) and usually explicitly requested by
the user or program (ala login or newrole) rather than automatic upon
program execution.  Automatic role transitions are primarily a
concession to compatibility (e.g. manual execution of init scripts and
restart of daemons by admins or by package scriptlets).

The role does act as a limit on what domains can be associated with the
process; the user-role relation and the role-domain relation are checked
for every security context, so a process can never transition to a
context with a domain that is not authorized for the role in that
context.  However, this is a weak barrier, as that process might still
be able to influence the target domain if it is allowed to do other
operations on the domain by the TE policy, so it is generally not a good
idea to rely on the role-domain relation alone to isolate domains.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
