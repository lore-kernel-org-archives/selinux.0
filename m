Message-ID: <43699220.1060100@anchor.com.au>
Date: Thu, 03 Nov 2005 15:29:20 +1100
From: Oliver Hookins <oliver.hookins@anchor.com.au>
MIME-Version: 1.0
To: SELinux@tycho.nsa.gov
Subject: Transitions using su command
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I'm having some funny behaviour from one of our init scripts. We're 
running a multi-user tomcat environment, which as part of its init 
script runs a command like the following:

su - $USER -c "$TOMCAT_SCRIPT start < /dev/null >& /dev/null"

If you run this as root, replacing the variables with the appropriate 
values, the command runs as expected without any problems. If you run 
the init script using the service command it prompts the following:

Your default context is user_u:system_r:unconfined_t.

Do you want to choose a different one? [n]

If you just press enter here, it goes back to the bash prompt and seems 
to succeed, however it worries me that when run automatically at startup 
and shutdown it might fail. Is there some sort of transition 
configuration I am missing, or something I can change to allow this 
transition?

-- 
Thanks,
Oliver

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
