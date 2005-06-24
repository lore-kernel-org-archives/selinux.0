Subject: RE: Alternative user management approach
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Karl MacMillan <kmacmillan@tresys.com>
Cc: "'Casey Schaufler'" <casey@schaufler-ca.com>, selinux@tycho.nsa.gov
In-Reply-To: <200506241704.j5OH4jqc017398@gotham.columbia.tresys.com>
References: <200506241704.j5OH4jqc017398@gotham.columbia.tresys.com>
Content-Type: text/plain
Date: Fri, 24 Jun 2005 15:34:50 -0400
Message-Id: <1119641690.12865.162.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2005-06-24 at 13:04 -0400, Karl MacMillan wrote:
> To make my suggestion more concrete, I think a mapping file in
> /etc/selinux/policyname that maps from users to SELinux users. The config would
> be an ordered list of mappings that use username and group information. That
> means that if the admin wants to use group info they can, otherwise it is
> ignored. The first match in the ordered list would win. Maybe something like:
> 
> id:root	sysadm
> group:wheel staff
> default	normal

Default group?  Supplemental groups?

This only happens at login time (or su), not newgrp.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
