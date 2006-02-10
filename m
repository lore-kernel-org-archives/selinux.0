Message-ID: <43ECA42C.5050800@tresys.com>
Date: Fri, 10 Feb 2006 09:33:16 -0500
From: Joshua Brindle <jbrindle@tresys.com>
MIME-Version: 1.0
To: SELinux List <SELinux@tycho.nsa.gov>, Ivan Gyurdiev <ivg2@cornell.edu>
Subject: semanage doing translations?
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Why is semanage doing translations? The translations have nothing to do 
with libsemanage and libsetrans is RedHat specific. Does anyone else 
have plans to use libsetrans? I know Gentoo does not. Personally I'd 
rather keep semanage limited to things being managed by libsemanage.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
