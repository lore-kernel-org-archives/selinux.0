Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j9EF8oNs007341
	for <selinux@tycho.nsa.gov>; Fri, 14 Oct 2005 11:08:50 -0400 (EDT)
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j9EF6sTX006724
	for <selinux@tycho.nsa.gov>; Fri, 14 Oct 2005 15:06:55 GMT
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.12.11/8.12.11) with ESMTP id j9EF6ubn011882
	for <selinux@tycho.nsa.gov>; Fri, 14 Oct 2005 11:06:56 -0400
Received: from mail.boston.redhat.com (mail.boston.redhat.com [172.16.76.12])
	by int-mx1.corp.redhat.com (8.11.6/8.11.6) with ESMTP id j9EF6oV12851
	for <selinux@tycho.nsa.gov>; Fri, 14 Oct 2005 11:06:51 -0400
Received: from [172.16.83.104] (dhcp83-104.boston.redhat.com [172.16.83.104])
	by mail.boston.redhat.com (8.12.8/8.12.8) with ESMTP id j9EF6ofb010928
	for <selinux@tycho.nsa.gov>; Fri, 14 Oct 2005 11:06:50 -0400
Message-ID: <434FC994.1090203@redhat.com>
Date: Fri, 14 Oct 2005 11:07:00 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: SE Linux <selinux@tycho.nsa.gov>
Subject: Rawhide updated to use getseuserbyname for logins.
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This means that gdm, pam, sshd have been update to use the seusers file 
to map Linux Users to SELinux Users.
(gdm will be there tonight)

This means that people can start taking advantage of labeled files on 
your system and try to create documents with different categories.  You 
can also generate users who will not be allowed to access these files.

How does seusers work?

A new file /etc/selinux/TYPE/seusers file has been added to all 
policies.  In strict and targeted policy it looks like

 cat /etc/selinux/targeted/seusers
root:root:s0-s0:c0.c255
default:user_u:s0

In MLS
cat /etc/selinux/mls/seusers
root:root:s0-s15:c0.c255
default:user_u:s0

Most users will map directly to the "default" user which usually gives 
user_u and Level S0.  So most users do
not need to change anything.

Policy has been updated to support 256 categories and 16 sensitivity 
levels (for MLS).  You may need to change
your /etc/mcs.conf file for SystemHigh to reflect this change. Change 
c127 to c255.

You can manipulate the seusers file to change the role/level of 
individual users on your system.  For example
if I added a dwalsh "selinux user" on my system and wanted to allow 
maximum MCS access for dwalsh,
I would add an entry of

dwalsh:dwalsh:s0-s0:c0.c255
to the seusers file.

If I wanted to add a user, bgates,  to have limited privs, but allow 
access to Secret Documents c1 I would add
bgates:user_u:s0-s0:c1

(I would also define "s0:c1=Secret" in /etc/mcs.conf)

If I do not add a Linux user I get the "default" entry

default:user_u:s0

If I wanted all my users do have full MCS privs by default, I could 
modify the "default" entry to

default:user_u:s0-s0:c0.c255

In strict policy you could add an entry like

dwalsh:staff_u:s0-s0:c0.c255

Genhomedircon had not been modified yet to read this though  :^(

Dan


-- 



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
