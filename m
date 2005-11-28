Subject: [PATCH] wrap char*** for user_get_roles()
From: Joshua Brindle <jbrindle@tresys.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, SELinux List <SELinux@tycho.nsa.gov>
Content-Type: text/plain
Date: Mon, 28 Nov 2005 14:13:12 -0500
Message-Id: <1133205192.17541.1.camel@twoface.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This adds wrappers for char*** so that semanage_user_get_roles will
work. I added the test to the user test (-u), please let me know if
there are any issues with this.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
