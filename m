Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h56F5pI4004145
	for <selinux@tycho.nsa.gov>; Fri, 6 Jun 2003 11:05:52 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h56F5Ess027550
	for <selinux@tycho.nsa.gov>; Fri, 6 Jun 2003 15:05:15 GMT
Received: from sat.sws.net.au ([202.5.161.49])
	by jazzswing.ncsc.mil  with ESMTP id h56F4khY027526
	for <selinux@tycho.nsa.gov>; Fri, 6 Jun 2003 15:05:11 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Wayne Salamon <wsalamon@nailabs.com>, <selinux@tycho.nsa.gov>
Subject: Re: A vulnerability in SELinux (fwd)
Date: Sat, 7 Jun 2003 01:04:13 +1000
References: <Pine.LNX.4.33.0306060554430.10200-300000@vox.rv.nailabs.com>
In-Reply-To: <Pine.LNX.4.33.0306060554430.10200-300000@vox.rv.nailabs.com>
Cc: rafal_wojtczuk@nai.com
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200306070104.13987.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 6 Jun 2003 19:55, Wayne Salamon wrote:
>   Here's the reply from Rafal with the details on the SELinux exploit.

In my policy tree I have changed the macro general_domain_access() to not 
permit ptrace access, and I have also changed the sshd policy to not use 
general_domain_access() but to instead have specific rules for what it needs.

Rafal is correct that even without ptrace access a sshd compromise can be used 
to give a system compromise by ptrace'ing another user_t process when a 
newrole command is attempted.  However there are easier ways of doing this.

Over the last few days on the #selinux list there has been discussion of these 
things.  The easiest implementation of such an attack (which was successfully 
used in practise) was to create a shell function named newrole() which gets 
called instead of the real newrole program.  Of course the person who ran 
"newrole" realised that something was amiss, but their password had already 
been sent off-site by that time and the machine had to be taken down.  This 
particular attack did not start with an sshd exploit but with the ability to 
create files in the home directory of the user through a mislabelling, but 
the same result could occur from a sshd exploit.

Running a sshd in user_t is one potential solution, however this requires 
giving the following additional capabilities to user_t:
dac_override fsetid setuid net_bind_service sys_tty_config sys_chroot 
sys_resource

Or alternatively sshd could be modified to not use some of those capabilities.

One thing I have been considering is writing policy for multiple sshd domains.  
Then you could have one sshd domain that is permitted to transition to 
sysadm_t which runs inside the firewall and one that is only permitted to 
transition to user domains which is exposed to the outside world.  However 
you would have to prevent proxying a connection, and prevent local 
connections.  Also of course if you have two machines on the border of your 
network then without labeled networking someone could login to one as user_t 
and then login to the internal interface of the other as sysadm_t.

One thing I have started work on is policy for domains that have only enough 
access to allow them to run newrole (no ptrace, no writing files, no reading 
/dev/pts, etc).  Then you could login as user_newr_t via ssh and then safely 
run newrole to transition to user_t.  This will be optional however as I 
think that only a minority of SE Linux users will want that.

I have uploaded a new version of my policy tree to the usual places to remove 
ptrace access from sshd_t.  I will look into the other parts of your message 
tomorrow.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
