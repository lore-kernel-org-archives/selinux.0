Message-ID: <45241C2B.6070504@redhat.com>
Date: Wed, 04 Oct 2006 16:40:11 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>,
        SE Linux <selinux@tycho.nsa.gov>
Subject: xdm leaks file descriptors on purpose, but this is causing random
 avc messages.
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=206709

Basically by design xdm/gdm opens a file descriptor to xsession-errors 
and then passes this to the session as stdout/stderr.  If at some time 
later a user opens up a gnome terminal and restarts a confined domain.  
AVC's are generated on this fd.

Not sure of a way to handle this other then "
dontaudit domain xdm_t:fd use;


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
