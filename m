From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Bartlomiej Balcerek <Bartlomiej.Balcerek@pwr.wroc.pl>
Subject: Re: Changing context with UID - doubt
Date: Wed, 19 Jan 2005 21:02:59 +1100
Cc: SELinux@tycho.nsa.gov
References: <Pine.GSO.4.44.0501091400340.4757-100000@sun1000.pwr.wroc.pl>
In-Reply-To: <Pine.GSO.4.44.0501091400340.4757-100000@sun1000.pwr.wroc.pl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200501192103.02201.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Monday 10 January 2005 00:37, Bartlomiej Balcerek 
<Bartlomiej.Balcerek@pwr.wroc.pl> wrote:
> I'am still newbie in SELinux. I'am confused, if SELinux can
> automaticaly change process context when changing system EUID ?

If you have a SETUID program then you will also need policy for it if using 
the "strict" policy.  In that case you will have the program automatically 
change domain and UID at the same time.

When a program wants to specify a new security context for a child process 
(for example /bin/login launching a shell for a user) the UID is changed 
through the setuid(2) system call before execution (the change takes affect 
before exec) and the SE Linux context is changed through the setexeccon(3) 
library call which works by writing to /proc/self/attr/exec.  The requested 
context change does not apply to the current process, it applies to the 
program that is executed (if the SE Linux policy permits it).

So your program can do setexeccon(context); setuid(100); exec...

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
