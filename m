Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k9JEQlD6006251
	for <selinux@tycho.nsa.gov>; Thu, 19 Oct 2006 10:26:47 -0400
Received: from mailgate1.arcor-ip.de (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k9JEQ3wO001885
	for <selinux@tycho.nsa.gov>; Thu, 19 Oct 2006 14:26:04 GMT
Received: from relay.brunellocal.de (ffmcospub2ffmbrunelfw2lo-cs-nat-mail-server.adm.arcor.net [145.254.28.157])
	by mailgate1.adm.arcor.net (Arcor-CN-MailRelay-l-A) with ESMTP id 41BA81B8A0B
	for <selinux@tycho.nsa.gov>; Thu, 19 Oct 2006 16:26:45 +0200 (CEST)
Received: from localhost (unknown [127.0.0.1])
	by relay.brunellocal.de (Postfix) with ESMTP id 251495582
	for <selinux@tycho.nsa.gov>; Thu, 19 Oct 2006 14:26:45 +0000 (UTC)
Received: from relay.brunellocal.de ([127.0.0.1])
 by localhost (relay.brunellocal.de [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 04944-05 for <selinux@tycho.nsa.gov>;
 Thu, 19 Oct 2006 16:26:44 +0200 (CEST)
Received: from mail-hv.brunel.de (mail-hv.brunellocal.de [192.168.1.234])
	by relay.brunellocal.de (Postfix) with ESMTP id F144B55D5
	for <selinux@tycho.nsa.gov>; Thu, 19 Oct 2006 16:26:43 +0200 (CEST)
From: Daniel Gil Mayol <Daniel.Gil-Mayol@brunel.de>
To: selinux@tycho.nsa.gov
Subject: Re: allow tomcat_t self:capability 0x80000000; ??
Date: Thu, 19 Oct 2006 16:26:40 +0200
References: <200610190933.19483.Daniel.Gil-Mayol@brunel.de> <200610191446.12206.Daniel.Gil-Mayol@brunel.de> <1161263545.14632.109.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1161263545.14632.109.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Message-Id: <200610191626.40684.Daniel.Gil-Mayol@brunel.de>
Content-Type: text/plain;
  charset="utf-8"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I have added "vs_context" in the class capability but don't seems enough, 
after a "make load" I have the next

flask/access_vectors:362:ERROR 'too many permissions to fit in an access 
vector' at token '}' on line 485:
        vs_context
}

The problem is that currently I can't recompile the kernel. I have written the 
next (although is not very nice, is temporal until I become a re-compiled 
kernel):

dontaudit tomcat_t self:capability *;



> On Thu, 2006-10-19 at 14:46 +0200, Daniel Gil Mayol wrote:
> > My kernel is  2.6.16.9vs2.0.2rc16.
>
> That obviously isn't a Red Hat kernel.  I'm guessing from the name that
> it is a Linux-VServer kernel?  Linux-Vserver patches likely claim that
> capability for their own use, and don't update SELinux to know about it.
>
> > After start auditd and run "/sbin/ausearch -i -c java" I see the next
> >
> > type=PATH msg=audit(10/19/2006 14:39:57.885:4742) : item=0
> > name=/proc/self/exe flags=none inode=1526923273 dev=00:03
> > mode=symlink,777 ouid=root ogid=root rdev=00:00
> > type=CWD msg=audit(10/19/2006 14:39:57.885:4742) :  cwd=/work/dagi
> > type=SYSCALL msg=audit(10/19/2006 14:39:57.885:4742) : arch=i386
> > syscall=readlink per=400000 success=yes exit=30 a0=80553c1 a1=bf82ba50
> > a2=fff a3=0 items=1 pid=23299 auid=unknown(4294967295) uid=root gid=root
> > euid=root suid=root fsuid=root egid=root sgid=root fsgid=root comm=java
> > exe=/usr/java/jre1.5.0_04/bin/java
> > type=AVC msg=audit(10/19/2006 14:39:57.885:4742) : avc:  denied
> > { 0x80000000 } for  pid=23299 comm=java capability=31
> > scontext=root:system_r:tomcat_t tcontext=root:system_r:tomcat_t
> > tclass=capability
>
> Taking a quick glance at the vs patch, it appears to apply this new
> capability check on accesses to /proc to decide whether to skip certain
> other checks.  Thus, everything that touches /proc will end up
> triggering these audit messages, but you almost never want to allow them
> (only to admin for the virtual server itself).
>
> Normally, we'd deal with this via a dontaudit statement to silence the
> audit message without allowing it.
>
> In order to reference this capability in such a statement, it needs to
> be defined in the policy/flask/access_vectors file.  In that file, go to
> the "class capability" section, and at the end of the list of
> capabilities (after "audit_control" and before the closing "}") add
> something like "vs_context".  Then you can write a policy statement
> like:
> 	dontaudit tomcat_t self:capability vs_context;
> and it should compile and load ok.
>
> If you want the kernel audit messages to use that name instead of the
> number, you have to regenerate the SELinux headers and rebuild your
> kernel.  To do that, after adding the "vs_context" definition to
> access_vectors as above, you would run make in the policy/flask
> subdirectory, then copy the generated .h files in that directory to the
> security/selinux/include directory of your kernel tree (you can also do
> that by running make LINUXDIR=/path/to/kerneltree tokern).
>
> If you want to avoid such headaches in the future, you should then
> submit a diff of the old and new headers back to the Linux-VServer
> project so that they can incorporate it into their patches and releases.

-- 
Mit freundlichen Grüßen / Best regards
Daniel Gil Mayol
------------------------------------------------------------------------------------
Brunel Communications
Daimlerring 9
31135 Hildesheim
Telefon	+49 5121 1760 839  
Fax 	+49 5121 1760 999
Daniel.Gil-Mayol@brunel.de


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
