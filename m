Message-ID: <3C1D909C.6070805@pcez.com>
Date: Sun, 16 Dec 2001 22:28:44 -0800
From: Shaun Savage <savages@pcez.com>
MIME-Version: 1.0
To: SELinux@tycho.nsa.gov
Subject: two different domains from on program
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I have a question.

courier has one program the has two different usage. I would like one 
program to transistion into two different domains depending on the 
starting domain.

domain_auto_trans(domain1, exec_file_t, domain2)
domain_auto_trans(domain3, exec_file_t, domain4)

where the context of the executable file is exec_file_t

Shaun Savage


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
