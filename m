From: "Femitha Majeed" <m_femitha@hotmail.com>
To: SELinux@tycho.nsa.gov
Subject: SELinux and kernel module compatibility
Date: Mon, 16 Sep 2002 17:52:05 +0000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <F3105knsCKH0D8r8e4D000074cc@hotmail.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov



Hi,

This is a newbie question.

I have a loadable kernel module that works on linux (RH6.2), when I try to 
compile it in SELinux, it compiles (it looks like that). When I do an insmod 
module.o,I get the error saying that it was compiled for a different linux 
version, while this is an lsm version.

Probably my Makefile is wrong.

Could anyone tell me how to compile in SELinux?


Thanks in advance,
Femitha Majeed



_________________________________________________________________
Chat with friends online, try MSN Messenger: http://messenger.msn.com


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
