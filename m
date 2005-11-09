Message-ID: <43718447.30709@cornell.edu>
Date: Wed, 09 Nov 2005 00:08:23 -0500
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: SELinux List <SELinux@tycho.nsa.gov>
CC: Stephen Smalley <sds@tycho.nsa.gov>
Subject: [ LIBSEMANAGE ] Cleanup patch (resync-ed)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Same cleanup patch as before, resync-ed against latest changes.

Changes:
- fold semanage_module_conn into semanage_direct_handle
- move sepol handle initialization and destruction into 
semanage_handle_create/destroy, to allow use of the handle when 
disconnected, which is consistent with current record interfaces (they 
do not require a connection).

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
