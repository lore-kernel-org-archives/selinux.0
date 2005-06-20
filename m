From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: James Morris <jmorris@redhat.com>
Subject: Re: [RFC]Kernel Built-in IDS extension
Date: Mon, 20 Jun 2005 16:21:11 +1000
Cc: Stephen Smalley <sds@tycho.nsa.gov>, horietk@nttdata.co.jp,
   selinux@tycho.nsa.gov
References: <Xine.LNX.4.44.0506171203270.2902-100000@thoron.boston.redhat.com>
In-Reply-To: <Xine.LNX.4.44.0506171203270.2902-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200506201621.16560.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Saturday 18 June 2005 02:08, James Morris <jmorris@redhat.com> wrote:
> On Fri, 17 Jun 2005, Stephen Smalley wrote:
> > Did you consider a userspace implementation, e.g. extend auditd to match
> > against avc messages it receives from the kernel (likely using a
> > libsepol function to perform the matching), and then having auditd
>
> Why limit the input to the IDS to AVC messages?  There are many ways of
> collecting attack signatures, and not necessarily even from the local
> system.

I have been considering writing an extension to the watchdog daemon (which 
currently only seems to be in Debian) to have SE Linux support.

Usually when a server has an unreasonably high load average the administrator 
can make a good guess at what the likely culprit is likely to be.  For 
example a university shell server with a high load average is probably caused 
by a badly written program written by someone studying Unix/C 101.  The 
current functionality of the watchdog daemon is to reboot the machine if the 
load stays high (or some other criteria are met).  Wheras it's quite likely 
that merely killing a certain class of process would do the job.

In the university shell server example causing all programs run by 
undergraduate students to cease operation (by flipping a SE Linux boolean) 
would be greatly preferrable to rebooting the machine and therefore killing 
processes from staff members and post-grads.  If stopping the processes from 
under-grads doesn't do the job then the second step would be to reboot the 
machine.

It would probably be best to have a user-space program that locks it's memory 
in core and sets real-time priority to monitor audit.log, the load average, 
and other sources of information that may relate to an attack.


In the example that was given changing a boolean is not something that needs 
to happen urgently.  The execution of the shell was denied so the 
administrator is apparently concerned about what operations may be done with 
the compromised ftpd other than executing a shell.  The administrator can't 
rely on the attacker trying to execute a shell as their first action, so the 
attacker may do that after launching other attacks.

Finally I have doubts about the IDS use of a single trigger.  On today's 
Internet you would not consider your server to be under attack if a single 
suspect packet comes in, the volume of such strange traffic is so great that 
strange things happen all the time.  It's only if you have a series of 
suspicious packets coming in that you would consider it to be evidence of an 
attack.  I believe that the same rules apply for SE Linux audit messages.  
One message may be a corner case that the author of the policy didn't 
consider (for example it was quite a long time after I initially wrote the 
Postfix policy that I discovered the Postfix functionality that occurs when a 
message in the queue times out while the daemon is not running).  It's only a 
series of accesses that may be considered evidence of attack.

I know that some people have programs to slowly send probe packets to servers 
over the course of days or weeks to get past IDS systems that watch for a 
barrage of packets.  There's not much we can do about that, you just have to 
make sure that your machine is reasonably secure at all times.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
