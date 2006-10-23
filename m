Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k9NAYdVd031559
	for <selinux@tycho.nsa.gov>; Mon, 23 Oct 2006 06:34:39 -0400
Received: from mailgate1.arcor-ip.de (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k9NAXpUW009568
	for <selinux@tycho.nsa.gov>; Mon, 23 Oct 2006 10:33:54 GMT
Received: from relay.brunellocal.de (ffmcospub2ffmbrunelfw2lo-cs-nat-mail-server.adm.arcor.net [145.254.28.157])
	by mailgate1.adm.arcor.net (Arcor-CN-MailRelay-l-A) with ESMTP id E00561D090A
	for <selinux@tycho.nsa.gov>; Mon, 23 Oct 2006 12:34:34 +0200 (CEST)
Received: from localhost (unknown [127.0.0.1])
	by relay.brunellocal.de (Postfix) with ESMTP id 9A93D58D1
	for <selinux@tycho.nsa.gov>; Mon, 23 Oct 2006 10:34:32 +0000 (UTC)
Received: from relay.brunellocal.de ([127.0.0.1])
 by localhost (relay.brunellocal.de [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 21311-01 for <selinux@tycho.nsa.gov>;
 Mon, 23 Oct 2006 12:34:26 +0200 (CEST)
Received: from mail-hv.brunel.de (mail-hv.brunellocal.de [192.168.1.234])
	by relay.brunellocal.de (Postfix) with ESMTP id B5B5D5915
	for <selinux@tycho.nsa.gov>; Mon, 23 Oct 2006 12:33:50 +0200 (CEST)
From: Daniel Gil Mayol <Daniel.Gil-Mayol@brunel.de>
To: selinux@tycho.nsa.gov
Subject: Re: Policy tests failed
Date: Mon, 23 Oct 2006 10:50:13 +0200
References: <200610191700.20138.Daniel.Gil-Mayol@brunel.de> <200610201458.42923.Daniel.Gil-Mayol@brunel.de> <1161366031.29755.204.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1161366031.29755.204.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Message-Id: <200610231050.14167.Daniel.Gil-Mayol@brunel.de>
Content-Type: text/plain;
  charset="utf-8"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> (no html mail please)
>
> On Fri, 2006-10-20 at 14:58 +0200, Daniel Gil Mayol wrote:
> > The version number of the SELinux policy language that I am using to
> > create the binary policy is 18 (policy.18).
>
> I meant the policy package version, e.g. rpm -q selinux-policy-targeted
> if using the RHEL 4 policy, or whatever you used as your baseline.

selinux-policy-targeted-1.17.30-2.126

> > I want that the script makes a transition into a different domain. For
> > this reason now I have the script relabel with the type
> > "initrc_exec_t" and seems that after execute "runcon -t crond_t" it
> > makes a transition to the crond_t domain.
>
> The above description suggests that you have two scripts, say "foo" and
> "bar", and you have labeled "foo" with initrc_exec_t so that it
> transitions to initrc_t automatically and the "foo" script contains a
> line that does "runcon -t crond_t bar", where the "bar" script contains
> the actual test code that you want to run in crond_t.  Is that correct?
> BTW, in that case, "bar" should be labeled crond_exec_t.

I have one script called  'exectest.py' labelled as 
system_u:object_r:initrc_exec_t. This script get a list of all the services 
to test. Then the "execute test" call one service of this list (supose 
anacron). All the services, with the name format 'SERVICE_NAME.exectest.py', 
are links to the script  'exectest.py' but labelled each one as 
'SERVICE_NAME_exec_t'. For example, anacron has the following link file:

lrwxrwxrwx  root     root     system_u:object_r:anacron_exec_t 
anacron.exectest.py -> /work/SElinux-test/exectest.py

The idea was the following, we have only one test script program (it is  
'exectest.py') and one link for each service (with the corresponding label).


> > The script don't execute crond, only prove that being in the crond_t
> > domain can not access to data of another domain (for example
> > httpd_exec_t).
>
> Ok, but the script itself needs to be run in crond_t then, which means
> that it needs to be labeled with crond_exec_t.
>
> > Now the script get into anacron_t (now I am testing with anacron)
> > domain using the command "runcon -t anacron_t". The script shows now
> > after execute the command "id" the next:
> >
> > uid=0(root) gid=0(root)
> > groups=0(root),1(bin),2(daemon),3(sys),4(adm),6(disk),10(wheel)
> > context=root:system_r:anacron_t
>
> Ok, so the script is running in anacron_t in that case.  Whatever
> anacron_t means in your particular policy.
>
> > I don't have any test scripts but i think rolling back the packages to
> > one with a known vulerability would work, but since one goal of a
> > hacker is to get a root shell, you could use runcon with a shell
> > script to simulate what would happen if a hacker was successfull.
> >
> > runcon -t httpd_t /bin/sh
> >
> > Of course I can only get this to work in permissive mode. Setting it
> > to enforcing kills the shell since it can not access the tty.
>
> There should be a boolean that controls tty access.
> Try:
> setsebool httpd_tty_comm=1
>
> > Also get an error "execvp: Permission denied" in enforcing.
>
> It needs to be labeled with the entrypoint type for the domain.
> Try:
> cp /bin/sh myhttpd
> chcon -t httpd_exec_t myhttpd
> runcon -t httpd_t ./myhttpd
>
> > I thought I must run my policy test script in a enforce mode but I get
> > the permission denied error (like the mail says). So, I have to run
> > the script in permissive mode and look the 'audit denies' that appears
> > in /var/log/messages?
>
> No, you can test in enforcing mode but you have to set up the necessary
> preconditions and you may need slightly customized policy to do it.

I am trying also to use the macro for dbusd calling "dbusd_domain(system);" 
but I receive the following error:

domains/cnsu/messagebus.te:36:ERROR 'unknown boolean read_default_t in 
conditional expression' at token 'read_default_t' on line 30533:
if (read_default_t) {
#line 36
domains/cnsu/messagebus.te:36:ERROR 'illegal conditional expression' at token 
'allow' on line 30553:
allow system_dbusd_t { root_t usr_t lib_t etc_t }:dir { read getattr lock 
search ioctl };
#line 36




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
