Subject: Re: Multiple contexts
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Cc: ivg2@cornell.edu, SELinux@tycho.nsa.gov
In-Reply-To: <20050112233241.GF11846@lkcl.net>
References: <1105390249.8093.21.camel@cobra.ivg2.net>
	 <1105474095.20566.131.camel@moss-spartans.epoch.ncsc.mil>
	 <1105560687.11135.26.camel@cobra.ivg2.net>
	 <1105566461.23136.40.camel@moss-spartans.epoch.ncsc.mil>
	 <20050112233241.GF11846@lkcl.net>
Content-Type: text/plain
Message-Id: <1105632966.24406.34.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Thu, 13 Jan 2005 11:16:06 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2005-01-12 at 18:32, Luke Kenneth Casson Leighton wrote:
>  would you accept that that could be done at policy compile time,
>  and that it would be unnecessary to do that at runtime?

No, it cannot be done at policy compile time, because the information
(the combinations of types on files) is not captured in the policy. 
file_contexts is not authoritative and is not part of the policy, and
the only authoritative source of information about the file attributes
is the on-disk version.  Full filesystem traversal required to do the
analysis you propose.  No examination of file_contexts or filesystem
state required to do current analysis of potential information flow
throughout the system.

>  would you also agree that if someone wants to mess things up
>  with chcon then all bets are off for _any_ kind of analysis?

Relabeling is controlled by policy already, and finer-grained control of
it is coming as part of the MLS work, so policy can bound such
relabeling to avoid illegal information flow, or at least limit the
ability to relabel in ways that violate information flow goals to
specific trusted subjects.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
