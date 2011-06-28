Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p5SDTDIH005608
	for <selinux@tycho.nsa.gov>; Tue, 28 Jun 2011 09:29:14 -0400
Received: from smtp.sws.net.au (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id p5SDTAgJ011272
	for <selinux@tycho.nsa.gov>; Tue, 28 Jun 2011 13:29:12 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Sam Gandhi <samgandhi9@gmail.com>
Subject: Re: login process unable to execute /bin/sh
Date: Tue, 28 Jun 2011 23:29:06 +1000
Cc: Guido Trentalancia <guido@trentalancia.com>, selinux@tycho.nsa.gov
References: <BANLkTiknN0tGP7xJmUO7Enxmqw2TjtgVKg@mail.gmail.com> <4E08B41F.80608@trentalancia.com> <BANLkTimY8OOEzZjfA=z=vfY_p3+XN3N8EQ@mail.gmail.com>
In-Reply-To: <BANLkTimY8OOEzZjfA=z=vfY_p3+XN3N8EQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201106282329.06313.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 28 Jun 2011, Sam Gandhi <samgandhi9@gmail.com> wrote:
> > Perhaps, you should try adding the other rule ?
> > 
> > allow initrc_t local_login_t:process transition;

Why would that be desirable?  /bin/login is generally run from getty which is 
run from init.  Do we have a need for scripts under /etc/init.d/ to run 
/bin/login?
 
> Jan  1 10:00:37 192.168.137.1 kernel: type=1400 audit(37.230:44): avc:
>  granted  { transition } for  pid=600 comm="getty" path="/bin/login"
> dev=ubifs ino=99 scontext=system_u:system_r:initrc_t
> tcontext=system_u:system_r:local_login_t tclass=process
> 
> Am I wrong in assuming that getty is not an issue because audit
> message indicates that when getty executed program /bin/login , domain
> transition was done successfully to local_login_t

Why is getty running in initrc_t?  What label is on the getty executable and 
what is the context of the program that runs it?

> Jan  1 10:00:39 192.168.137.1 kernel: type=1400 audit(39.090:45): avc:
>  denied  { transition } for  pid=812 comm="login" path="/bin/sh"
> dev=ubifs ino=93 scontext=system_u:system_r:local_login_t
> tcontext=root:system_r:initrc_t tclass=process
> 
> One more piece of information I didn't include in previous email was,
> /bin/sh is labeled as shell_exec_t and I do see following rules in my
> policy.conf.

/bin/sh is usually a symlink (labelled as bin_t) and points to something else 
matching /bin/*sh - which should have shell_exec_t as the type.  Not that it 
matters in a normal situation.

> type_transition initrc_t shell_exec_t:process initrc_t;

That looks wrong.

> allow initrc_t shell_exec_t:file { read { getattr execute } Ballow
> initrc_t shell_exec_t:file { read getattr lock execute ioctl };
> allow initrc_t shell_exec_t:file entrypoint;
> 
> allow local_login_t shell_exec_t:file { read { getattr execute } };
> type_transition local_login_t shell_exec_t:process initrc_t;
> allow local_login_t shell_exec_t:file { read { getattr execute } };
> allow local_login_t shell_exec_t:file { { read getattr lock execute
> ioctl } execute_no_trans };
> allow local_login_t shell_exec_t:file entrypoint;
> 
> The best as I understand allow rules, the local_login_t rules above
> says, when process running in context local_login_t (login program in
> my case) tries to execute program of type shell_exec_t it should be
> allowed, and process should transition to context initrc_t (because of
> type_transition statement above).
> 
> Still puzzled as to why I keep getting local_login deny message
> (help!). I am running the system with  'auditallow domain
> domain:process transition;'  and I don't see any other domain
> transitions happening when I try to login to my system.

You shouldn't have a login session with the domain initrc_t.  You should have 
the login program tell the kernel which context to use and it should be 
something with a different domain.  Either the login program should be patched 
or you should use PAM with pam_selinux.so configured.

-- 
My Main Blog         http://etbe.coker.com.au/
My Documents Blog    http://doc.coker.com.au/

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
