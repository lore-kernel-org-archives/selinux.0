Reply-To: <david.chatterton@adacel.com.au>
From: "David Chatterton" <david.chatterton@adacel.com.au>
To: <SELinux@tycho.nsa.gov>
Subject: Support for multiple SELinux hosts
Date: Sun, 1 Apr 2001 15:50:11 +1000
Message-ID: <000b01c0ba6f$9f26a4e0$e8022dcb@stratos.vic.bigpond.net.au>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

>From what I can tell from the documentation,
SELinux's support for networking consists of
specifying domains for network interfaces,
port numbers and NFS. This provides a default
SID for incomming connections and restricts
what outgoing connections may be made.

There is currently no support for the translation
and/or transportation of SIDs between two SELinux
hosts which would allow, for example, proper MAC
enforcement across NFS. Is this a fair comment?

Are there any plans to improve support for
networks of SELinux hosts in the future?

David

---
David Chatterton             Phone: +61 3 8530 7864
Adacel Technologies Ltd        Fax: +61 3 9596 2960
www.adacel.com   Email: david.chatterton@adacel.com


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
