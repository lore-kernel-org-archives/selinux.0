Message-ID: <372de840711210432p748bb35br9dd1b3a8e29ee014@mail.gmail.com>
Date: Wed, 21 Nov 2007 07:32:58 -0500
From: "joe shoemaker" <joemystery123@gmail.com>
To: SELinux@tycho.nsa.gov
Subject: plz Help! SELinux Re-enabled from disabled mode, CentOS 5 won't startup
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello, I need help. When I re-enabled the selinux, it asked me if you
want to relabel the system, I said no. Now I can't start or shutdown
the computer.

What are the ways to get my computer back?

I just booted the computer. Didn't do anything. What I am getting is as follows:

*** An error occurred during the file system check.
*** Dropping you to a shell; the system will reboot
*** when you leave the shell.
*** Warning --SELinux is active
*** Disabling security enforcement for system recovery.
*** Run 'setenforce 1' to reenable.
Give root password for maintenance
(or type Control-D to continue):

Once I type the root password, I get a shell like this:

(Repair filesystem) 1#

Any suggestion on going about disabling from this terminal or setting
the "selinux=0" in what file?

I did echo 0 >/selinux/enforce.

I tried to open the "/etc/selinux/config" and tried setting it to
"SELINUX=permissive", but I can't write to it. I get something like
this:

W10: Warning: Changing a readonly file
E303: Unable to open swap file for "/etc/selinux/config", recovery impossible.

I have tried this also, "/boot/grub/grub.conf" and on the kernel line,
added enforcing=0 at the end. But I can't write to the file. Same as
before regarding readonly and unable to open swap file.

What about "newrole -r sysadm_r" command? sysadm_r command I have to
worry about? I tried "newrole -r sysadm_r" on the shell after logging
in as root, but it doesn't recognize the command "newrole".


Unable to open swap file is coming from vi editor:

Unable to open swap file for "{filename}", recovery impossible

Vim was not able to create a swap file. You can still edit the file, but if
Vim unexpected exits the changes will be lost. And Vim may consume a lot of
memory when editing a big file. You may want to change the 'directory' option
to avoid this error. See |swap-file|.

Even when I edit the file vi, changes made are not saved.  Any suggestions?

thnx,
joey

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
