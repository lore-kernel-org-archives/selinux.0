Message-ID: <41FEAD91.4060205@redhat.com>
Date: Mon, 31 Jan 2005 17:13:37 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@epoch.ncsc.mil>, SELinux <SELinux@tycho.nsa.gov>
Subject: Any problems with adding the following.
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

 /opt/.*\.so(\.[^/]*)* --      system_u:object_r:shlib_t
 /usr/local/.*\.so(\.[^/]*)* --      system_u:object_r:shlib_t

Third party vendors do not always put sharelibaries under a "lib/" 
directory.

Dan

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
