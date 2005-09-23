Subject: Re: [PATCH] sepol, write.c policy version
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Joshua Brindle <jbrindle@tresys.com>
Cc: Karl MacMillan <kmacmillan@tresys.com>,
   SELinux List <SELinux@tycho.nsa.gov>
In-Reply-To: <1127422608.21806.49.camel@twoface.columbia.tresys.com>
References: <1127422608.21806.49.camel@twoface.columbia.tresys.com>
Content-Type: text/plain
Date: Fri, 23 Sep 2005 13:00:17 -0400
Message-Id: <1127494817.27851.32.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2005-09-22 at 16:56 -0400, Joshua Brindle wrote:
> Make version comparisons correctly compare kernel policies with kernel
> versions and module policies with module versions.

Ok, entire patch set merged except for the one diff in patch 7.

With this change, the base module now uses the module version numbers
instead of the kernel policy version numbers.  What does this mean for
other cases where the policy version is checked, e.g.:
MLS check in context_write/read
validatetrans check in class_write/read
MLS check in user_write/read
MLS check in policydb_write/read for call to range_write/read

Should the MLS/validatetrans elements be unconditionally included in the
base module?

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
