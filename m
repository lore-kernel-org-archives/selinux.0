Message-ID: <3FC4AF2B.3060301@redhat.com>
Date: Wed, 26 Nov 2003 08:48:27 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: SELinux <SELinux@tycho.nsa.gov>
Subject: Problems with /dev/tty on reboot.
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

How should we handle the situation where contexts end up in the wrong 
contexts because of crashes or reboots.

Currently if you login to a box as user_t, and then the system crashes 
or you reboot the /dev/tty has the wrong context on it, so if the next 
user that attempts to login has staff_t he will not be able to gain 
access to the device.  I have put a
setfiles file_context /dev/tty in my rc scripts as a stop gap, but that 
is not a clean solution.  Also this can probably happen to other files 
that have their contexts changed by running processes.  Ideas on how to 
solve this problem??

Dan


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
