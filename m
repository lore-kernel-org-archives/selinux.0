From: lonnie@outstep.com
To: SELinux Mailing <SELinux@tycho.nsa.gov>
Subject: rh7.2 xdmcp
Message-ID: <1008631268.3c1e7de40a5a0@mail.outstep.com>
Date: Mon, 17 Dec 2001 18:21:08 -0500 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello All,

I have gotten SELinux up and running and even talking to the network but did 
run into a little problem with trying to tell it to open up port 177 (XDMCP)

when I run "setup" it allows me to change the redhat firewall settings, but I 
am not sure that they are actually taking effect. I tell it to open up port 177 
and then exit out of the setup, but an "nmap -sI localhost" does not show the 
port is open.

has anyone else had this problem?

cheers,
Lonnie

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
