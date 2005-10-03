Subject: RE: [RFC][PATCH] New interface for loading policy
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Karl MacMillan <kmacmillan@tresys.com>
Cc: "'Ivan Gyurdiev'" <ivg2@cornell.edu>, selinux@tycho.nsa.gov,
   "'Daniel J Walsh'" <dwalsh@redhat.com>, SELinux-dev@tresys.com
In-Reply-To: <200510031348.j93DmWYs014504@gotham.columbia.tresys.com>
References: <200510031348.j93DmWYs014504@gotham.columbia.tresys.com>
Content-Type: text/plain
Date: Mon, 03 Oct 2005 10:22:06 -0400
Message-Id: <1128349326.26285.62.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2005-10-03 at 09:48 -0400, Karl MacMillan wrote:
> Agreed. How can libselinux support module and non-module installs then,
> though? Seems like it needs to determine whether it is handling the adding
> of users, etc or it has been handled already. If you make it an option
> passed in as an arg, libsemanage can just call it correctly (either directly
> or through an option to load_policy).

I assumed that even with a non-module install, libsemanage (or policy
server) would handle regeneration of the kernel binary policy file with
all local settings (users, saved/persistent booleans) so that libselinux
can just load that file unmodified except possibly for preserving the
current boolean settings in the preservebools case.  So I didn't think
we needed to retain the sepol_genusers/sepol_genbools support in the
libselinux function at all once we have converted over to the new
approach.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
