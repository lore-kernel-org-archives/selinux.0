Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: John Doe <r2q2@rocketmail.com>, SELinux@tycho.nsa.gov
Subject: Re: LD problems
Date: Thu, 28 Mar 2002 15:02:57 +0100
References: <20020328085204.23784.qmail@web14607.mail.yahoo.com>
In-Reply-To: <20020328085204.23784.qmail@web14607.mail.yahoo.com>
MIME-Version: 1.0
Message-Id: <20020328140257.426302799D@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 28 Mar 2002 09:52, John Doe wrote:
> I just compiled the 2.4 kernal and it keeps on giving me this error
> message.
> INIT: ld Respawning too fast : disabled for 5 minutes.

That is a capital 'i' not a lower case 'L'.

> Did I do something wrong in the kernel compile or something?

Mar 28 14:55:50 lyta init: Id "9" respawning too fast: disabled for 5 minutes

Usually you see messages such as the above where I had a line in my inittab 
starting with "9:" which aborted every time.

The thing to do in such situations is to read the syslogs and determine what 
is failing in that server program, that's if you can even login (if your 
getty type programs are the cause of this you may be forced to just press 
reset).

I suggest compiling an SE Linux kernel with CONFIG_SECURITY_SELINUX_DEVELOP 
turned on for your first use of SE Linux.  Then a mistake in policy or 
labelling will not stop the system from booting, and probably not prevent you 
from logging in.

Also note that certain types of errors in policy configuration can prevent 
the login program from assigning a context to the session which thus prevent 
you from logging in.  Having an option to log in using a method that is not 
changed for SE Linux on your first attempt is a good idea.  I started by 
leaving /bin/login untouched and compiling support for SE Linux into sshd.  
Then when I could ssh in correctly I changed /bin/login.

-- 
If you send email to me or to a mailing list that I use which has >4 lines
of legalistic junk at the end then you are specifically authorizing me to do
whatever I wish with the message and all other messages from your domain, by
posting the message you agree that your long legalistic sig is void.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
