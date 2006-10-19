Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k9JCkhGi003205
	for <selinux@tycho.nsa.gov>; Thu, 19 Oct 2006 08:46:43 -0400
Received: from mailgate1.arcor-ip.de (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k9JCjxwO016372
	for <selinux@tycho.nsa.gov>; Thu, 19 Oct 2006 12:46:00 GMT
Received: from relay.brunellocal.de (ffmcospub2ffmbrunelfw2lo-cs-nat-mail-server.adm.arcor.net [145.254.28.157])
	by mailgate1.adm.arcor.net (Arcor-CN-MailRelay-l-A) with ESMTP id CCF1E1B9A38
	for <selinux@tycho.nsa.gov>; Thu, 19 Oct 2006 14:46:24 +0200 (CEST)
Received: from localhost (unknown [127.0.0.1])
	by relay.brunellocal.de (Postfix) with ESMTP id 2F77D55B4
	for <selinux@tycho.nsa.gov>; Thu, 19 Oct 2006 12:46:24 +0000 (UTC)
Received: from relay.brunellocal.de ([127.0.0.1])
 by localhost (relay.brunellocal.de [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 03488-07 for <selinux@tycho.nsa.gov>;
 Thu, 19 Oct 2006 14:46:23 +0200 (CEST)
Received: from mail-hv.brunel.de (mail-hv.brunellocal.de [192.168.1.234])
	by relay.brunellocal.de (Postfix) with ESMTP id 3130C5588
	for <selinux@tycho.nsa.gov>; Thu, 19 Oct 2006 14:46:23 +0200 (CEST)
From: Daniel Gil Mayol <Daniel.Gil-Mayol@brunel.de>
To: selinux@tycho.nsa.gov
Subject: Re: allow tomcat_t self:capability 0x80000000; ??
Date: Thu, 19 Oct 2006 14:46:11 +0200
References: <200610190933.19483.Daniel.Gil-Mayol@brunel.de> <1161260478.14632.80.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1161260478.14632.80.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Message-Id: <200610191446.12206.Daniel.Gil-Mayol@brunel.de>
Content-Type: text/plain;
  charset="utf-8"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

My kernel is  2.6.16.9vs2.0.2rc16.

After start auditd and run "/sbin/ausearch -i -c java" I see the next

type=PATH msg=audit(10/19/2006 14:39:57.885:4742) : item=0 name=/proc/self/exe 
flags=none inode=1526923273 dev=00:03 mode=symlink,777 ouid=root ogid=root 
rdev=00:00
type=CWD msg=audit(10/19/2006 14:39:57.885:4742) :  cwd=/work/dagi
type=SYSCALL msg=audit(10/19/2006 14:39:57.885:4742) : arch=i386 
syscall=readlink per=400000 success=yes exit=30 a0=80553c1 a1=bf82ba50 a2=fff 
a3=0 items=1 pid=23299 auid=unknown(4294967295) uid=root gid=root euid=root 
suid=root fsuid=root egid=root sgid=root fsgid=root comm=java 
exe=/usr/java/jre1.5.0_04/bin/java
type=AVC msg=audit(10/19/2006 14:39:57.885:4742) : avc:  denied  
{ 0x80000000 } for  pid=23299 comm=java capability=31 
scontext=root:system_r:tomcat_t tcontext=root:system_r:tomcat_t 
tclass=capability


> On Thu, 2006-10-19 at 09:33 +0200, Daniel Gil Mayol wrote:
> > Hello, I'm trying to write a policy for Tomcat using RedHat Enterprise 4.
> > I receive the next message:
> >
> > Oct 19 09:04:36 cnsu kernel: audit(1161248676.103:4605): avc:  denied
> > { 0x80000000 } for  pid=1223 comm="java" capability=31
> > scontext=root:system_r:tomcat_t tcontext=root:system_r:tomcat_t
> > tclass=capability
>
> Capability 31 isn't defined, so this indicates a kernel bug.
> If SELinux cannot map the capability to a defined permission, it just
> displays the value rather than a string name to at least provide some
> information.
>
> Start auditd and then reproduce the denial while it is running.
> Then run:
> 	/sbin/ausearch -i -c java
> and post the result.
>
> Also, please identify your precise kernel (uname -r).
>
> > Using the audit2allow tool, I become the next allow to add: "allow
> > tomcat_t self:capability 0x80000000;" but this don't works, after the
> > compiler shows the following error:
> >
> > /usr/bin/checkpolicy:  loading policy configuration from policy.conf
> > domains/xxx/tomcat.te:117:ERROR 'syntax error' at token '0' on line
> > 39415: allow tomcat_t self:capability 0x80000000;
> >
> > Somebody can help me to understand what I'm doing wrong?
>
> The above won't work because that isn't a defined permission.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
