Message-ID: <44710A40.4060309@us.ibm.com>
Date: Sun, 21 May 2006 20:48:00 -0400
From: Janak Desai <janak@us.ibm.com>
MIME-Version: 1.0
To: Russell Coker <russell@coker.com.au>, tmraz@redhat.com, sds@tycho.nsa.gov,
        valdis.kletnieks@vt.edu
CC: serue@us.ibm.com, klaus@atsec.com, selinux@tycho.nsa.gov
Subject: pam_namespace improvements ..
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


Hi Russell,

After going thorugh the pam_namespace thread again and after talking to
some of my peeps, I do see that a mode 000 instance parent can thwart
attacks by non-root daemons and non-polyinstanted users on polyinstanted
users.

The current implementation of pam_namespace already depends on the
existance of the instance parent and allows the admin to configure the names
of different instances. I will update the namespace.conf man page, and
the comment text in the namespace.conf file to guide admins to
appropriately create a different instance parent (and not use the poly
dir itself, like the current example suggests). That way, an admin can
create an intermediate directory like .inst with 000 or create a whole
different directory with 000.

Thanks.

-Janak



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
