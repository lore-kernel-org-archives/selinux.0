Message-ID: <41FFAF5E.9000003@redhat.com>
Date: Tue, 01 Feb 2005 11:33:34 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: James Morris <jmorris@redhat.com>
CC: Stephen Smalley <sds@epoch.ncsc.mil>, SELinux <SELinux@tycho.nsa.gov>
Subject: Reminder I need the equivalent of name_bind for name_connect
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I have talked about this before, but I believe this is a critical fix 
that would allow us to tighten up security on many domains.

allow user_mozilla_t httpd_port_t:tcp_socket named_connect;

Dan

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
