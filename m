Subject: RE: Restorecon script
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Karl MacMillan <kmacmillan@tresys.com>
Cc: "'Joshua Brindle'" <jbrindle@tresys.com>,
   Ivan Gyurdiev <gyurdiev@redhat.com>, "'Daniel J Walsh'" <dwalsh@redhat.com>,
   "'SELinux'" <selinux@tycho.nsa.gov>, selinux-dev@tresys.com
In-Reply-To: <200506101744.j5AHi55F008714@gotham.columbia.tresys.com>
References: <200506101744.j5AHi55F008714@gotham.columbia.tresys.com>
Content-Type: text/plain
Date: Fri, 10 Jun 2005 13:41:32 -0400
Message-Id: <1118425292.3774.137.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2005-06-10 at 13:44 -0400, Karl MacMillan wrote:
> It would probably still be better practice to execute the script in the user's
> domain or a limited version of that domain from the trusted domain (e.g. rpm) -
> if nothing else that means that the relabeling happens less often. Of course, if
> the user's domain has this relabel privilege anyway, having the privileged
> domain doing the relabeling, either directly or indirectly, doesn't really help
> at all. The user can just install / write the script themselves. Removing the
> relabeling privilege from the user is probably difficult and they can just copy
> files into the appropriate directories and get the same result (assuming type
> transition rules are in place).

These files are under the user's control anyway; the purpose of labeling
them with their own type is to allow particular user apps to access them
without allowing those apps to access all of the user's files.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
