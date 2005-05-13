Subject: Re: Busted by constraints.
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SE Linux <selinux@tycho.nsa.gov>, Karl MacMillan <kmacmillan@tresys.com>
In-Reply-To: <1115908243.32202.114.camel@moss-spartans.epoch.ncsc.mil>
References: <428368FF.2080603@redhat.com>
	 <1115908243.32202.114.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Fri, 13 May 2005 11:35:36 -0400
Message-Id: <1115998536.3576.72.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2005-05-12 at 10:30 -0400, Stephen Smalley wrote:
> The AVC just sees that a given permission was denied, not what component
> of the policy engine denied it.  See "Flask architecture", "policy-
> flexibility", ...

BTW, to elaborate on this point, when a permission check is first made
for a given (subject security context, object security context, object
security class) triple, the AVC gets a complete access vector (all
permission decisions) for that triple from the security server, so the
security server does the complete policy computation at that time and
never sees subsequent permission checks on the same triple as long as
the cache entry isn't evicted.  Hence, even if we modified the kernel
security server to log a message about the cause when it receives a
request for a computation and one of the requested permissions is
denied, we'd still never see the causes for denials that are handled
entirely by the AVC using the cached access vector.   To support that in
the kernel (vs. creating a utility like audit2why), we'd have to have
the kernel security server return a vector of _reasons_ for each denied
permission in the access vector to the AVC and have the AVC interpret
that vector when generating the audit message.  In addition to being
rather painful, that also tends to break the desired encapsulation of
policy logic within the security server in the kernel (vs. having some
policy-aware applications like audit2why).

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
