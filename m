From: lonnie@outstep.com
To: SELinux Mailing <SELinux@tycho.nsa.gov>
Subject: setting up new test user domain?
Message-ID: <1008694906.3c1f767ac3e8f@mail.outstep.com>
Date: Tue, 18 Dec 2001 12:01:46 -0500 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello All,

Since I am very new to SELinux, I hope that all of you will forgive the many 
dumb questions that I will probably end up asking.

Instead of modifying the user.te and every.te for our project, I think that it 
might be better if I simple create a new test domain and place a "test" user in 
that domain.

>From what I can understand so far, if the user does not belong to a particular 
domain then they will not have access it. 

With this in mind then if I add a user to a newly developed domain for that 
particular user and also have their HOME directory as a member if the single 
user domain then I could effectively prevent them from moving out of 
the /home/test into the /home or any other directory.

Would this be correct? If so then couls someone please help me to figure out 
how to set up a simple domain from which to begin this process?

Also, I have made a subdirectory in the selinux/domains directory because I 
have seen this in the make file as well and this will make it so that I do not 
have to modify the makefile.

All Help would be greatly appreciated,
Lonnie


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
