Message-ID: <48528E71.3000301@manicmethod.com>
Date: Fri, 13 Jun 2008 11:12:49 -0400
From: Joshua Brindle <method@manicmethod.com>
MIME-Version: 1.0
To: SE Linux <selinux@tycho.nsa.gov>
CC: Stephen Smalley <sds@tycho.nsa.gov>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>
Subject: [rfc] refpolicy user based separation 
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

With the role based separation work being done an alternate idea was brought up here. Rather than going through the pain required for role based separation (kernel patches, policy format changes, incompatibility with older distros, long term refpolicy branch) we could do user based separation.

The work done on refpolicy to merge derived types is still necessary, and much of that work has been done. It just means that rather than separating user home dirs and user processes based on the role field it will be done on the user field. We believe that no kernel patches or format changes are necessary to do this.

Some advantages include less work, ofcourse. No incompatibility with older distros (eg., trunk refpolicy will still be usable on RHEL4/5). Some disadvantages are less flexibility, more difficult to separate roles given to the same user (TE policy with derived types would be necessary). It would be easy to use roles and users in a 1:1 mapping and force people to log out and back in to assume a new role, or to use sudo with context setting support (although that requires the selinux user identity to be non-immutable, which some have objected to)

Some work would still need to be done in userspace, such as user attribute support in the module format and libsemanage, to be able to exempt separation for specific users.

Opinions?


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
