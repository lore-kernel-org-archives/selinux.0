Message-ID: <3C152F3D.A17A8DC1@student.kuleuven.ac.be>
Date: Mon, 10 Dec 2001 22:55:09 +0100
From: Johan Camp <johan.camp@student.kuleuven.ac.be>
MIME-Version: 1.0
To: SELinux@tycho.nsa.gov
Subject: problems after installing selinux
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi

I recently installed selinux (the 2.4-14-lsm kernel) on my SuSE 7.2
system. After compiling and installing the kernel and all other
utilities (exactly as described in the selinux/README file). I have the
folowing problem:

- when entering the 'ls --context' command I get the message "Sorry,
--context can be used only on a flask-enabled kernel".

- when entering the 'ps -e --context' command, all processes have SID =
3 and CONTEXT = -

Can anyone tell me how I can solve this problem?

Thank you


Johan Camp
KULeuven

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
