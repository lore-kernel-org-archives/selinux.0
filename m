Subject: Emacs major mode for policy editing
From: Eamon Walsh <ewalsh@epoch.ncsc.mil>
To: selinux@tycho.ncsc.mil
Content-Type: text/plain
Message-Id: <1064504193.3885.14.camel@moss-tarheels.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 25 Sep 2003 11:36:33 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

My name is Eamon Walsh; I recently joined the NSA selinux team.
I will be working on putting policy enforcement into XFree86.

I've attached a simple Emacs major mode definition for policy editing.
It highlights keywords, comments etc. in different colors.

Drop the file into your Emacs library (/usr/share/emacs/site-lisp on
RH9).  Add the following to your ~/.emacs: 
(load-library "selinux-policy")
and make sure you have font-lock mode turned on:
(global-font-lock-mode t)

In Emacs, use M-x selinuxpolicy-mode to enter the mode.  .te files go
into in automatically.

Enjoy,
Eamon W.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
