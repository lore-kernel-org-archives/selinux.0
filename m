Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hB5280Rb002116
	for <selinux@tycho.nsa.gov>; Thu, 4 Dec 2003 21:08:00 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id hB527JlU012950
	for <selinux@tycho.nsa.gov>; Fri, 5 Dec 2003 02:07:19 GMT
Received: from ns.sws.net.au (ns.sws.net.au [61.95.69.3])
	by jazzswing.ncsc.mil  with ESMTP id hB527ISX012947
	for <selinux@tycho.nsa.gov>; Fri, 5 Dec 2003 02:07:18 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: nagray@austin.rr.com, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: ssh policy
Date: Fri, 5 Dec 2003 13:07:48 +1100
References: <1070587102.27071.159.camel@hawaii.efficax.net>
In-Reply-To: <1070587102.27071.159.camel@hawaii.efficax.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200312051307.48320.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 5 Dec 2003 12:18, Nick <nagray@austin.rr.com> wrote:
> avc:  denied  { signal } for  pid=1002 exe=/usr/sbin/sshd
> scontext=system_u:system_r:sshd_t tcontext=system_u:system_r:sshd_t
> tclass=process
>
> I dont think I get this one at all, unless the process which is starting
> sshd is what is not able to send a signal or is it sshd can't send a
> signal out?

I don't get it either.  Usually sshd runs fine with that blocked, but 
sometimes it doesn't work correctly.  In my latest policy I have enabled that 
access, but it needs more review.

> avc:  denied  { getattr } for  pid=1055 exe=/usr/sbin/sshd name=xauth
> dev=03:02 ino=2261013 scontext=system_u:system_r:sshd_t
> tcontext=system_u:object_r:bin_t tclass=file

You are logging in with X11 forwarding enabled.  I strongly recommend that you 
set "ForwardX11 no" in your ssh_config file and then specifically enable X11 
forwarding when you want it with the "-X" option to ssh.  Otherwise whenever 
you ssh to a hostile machine they can use X to take over your account.

> avc:  denied  { name_bind } for  pid=1055 exe=/usr/sbin/sshd port=6010
> scontext=system_u:system_r:sshd_t tcontext=system_u:object_r:port_t
> tclass=tcp_socket

6010 is for DISPLAY=:10.0 .  In my current policy I don't enable this unless 
you have startx or xdm policy included.  I can see that this was an error, it 
should be included for ssh as it's quite valid to have an ssh tunnel be the 
only X server on a machine.  In my next release I will also check for xauth 
policy.

If you don't have xauth policy then using sshd with X forwarding is probably a 
bad idea.


PS  Please choose an appropriate subject for your messages.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
