From: "cheng weifang" <study_box@hotmail.com>
To: SELinux@tycho.nsa.gov
Subject: I have trouble with selinux packages
Date: Wed, 07 Jan 2004 11:51:29 +0000
Mime-Version: 1.0
Content-Type: text/plain; charset=gb2312; format=flowed
Message-ID: <BAY2-F124CSYIeaZIGN0006bff1@hotmail.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Sorry to interrupt you.
I have downloaded '2.4.23 kernel with SELinux patch applied' and 'SELinux 
Full Userland Archive' from http://www.nsa.gov/selinux. But when I build 
and install the SELinux-patched packages, there is something wrong with 
building 'prelink-0.3.0-16.sel.src.rpm'. It said that PT_GNU_STACK is 
undeclared.

I guessed that maybe my GCC and glibc cann't support PT_GNU_STACK .The 
automake on my Redhat 9.01 Linux is automake-1.6.3-5, and autoconf is 
autoconf-2.57-3. What version should I use? Or should I install other 
packages?Can you help me?

I am waiting your answer. Thank you very much!

_________________________________________________________________
享用世界上最大的电子邮件系统— MSN Hotmail。  http://www.hotmail.com  


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
