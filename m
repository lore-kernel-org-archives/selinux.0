Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id lAQEmaVQ006725
	for <selinux@tycho.nsa.gov>; Mon, 26 Nov 2007 09:48:36 -0500
Received: from nz-out-0506.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id lAQEmaMA000951
	for <selinux@tycho.nsa.gov>; Mon, 26 Nov 2007 14:48:36 GMT
Received: by nz-out-0506.google.com with SMTP id i1so345360nzh
        for <selinux@tycho.nsa.gov>; Mon, 26 Nov 2007 06:48:35 -0800 (PST)
Message-ID: <f71a82820711260648x5ad7b3a8q46af3803fadca41a@mail.gmail.com>
Date: Mon, 26 Nov 2007 23:48:34 +0900
From: "Shintaro Fujiwara" <shintaro.fujiwara@gmail.com>
To: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        selinux <selinux@tycho.nsa.gov>
Subject: Re: semodule -i postgresql.pp fails on F8
In-Reply-To: <1196082719.20918.4.camel@gorn>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <f71a82820711222214i46474da1ucd1b402fbbc9d38d@mail.gmail.com>
	 <1196082719.20918.4.camel@gorn>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

As soon as you gave me a hint, I tried to edit
my postgresql.te file like this (under).
Also I fixed my postgresql.fc file.
Because, I installed from source.gz.
Path is different from RPM version, you know.

And succeeded make .pp file and install.
I guess in base.pp types are declared,
but I don't know how to check.

Anyway I'm happy succeeded installing .pp file.
Now I started relabeling the system.

Thanks !


#policy_module(postgresql,1.4.0)
policy_module(postgresql,100.4.0)

#################################
#
# Declarations
#
require {
        type postgresql_t;
        type postgresql_exec_t;
        type postgresql_db_t;
        type postgresql_etc_t;
        type postgresql_lock_t;
        type postgresql_var_run_t;
        type postgresql_log_t;
        type postgresql_tmp_t;
}

#type postgresql_t;
#type postgresql_exec_t;
init_daemon_domain(postgresql_t,postgresql_exec_t)

#type postgresql_db_t;
files_type(postgresql_db_t)

#type postgresql_etc_t;
files_config_file(postgresql_etc_t)

#type postgresql_lock_t;
files_lock_file(postgresql_lock_t)

#type postgresql_log_t;
logging_log_file(postgresql_log_t)

#type postgresql_tmp_t;
files_tmp_file(postgresql_tmp_t)

#type postgresql_var_run_t;
files_pid_file(postgresql_var_run_t)


2007/11/26, Christopher J. PeBenito <cpebenito@tresys.com>:
> On Fri, 2007-11-23 at 15:14 +0900, Shintaro Fujiwara wrote:
> > I got src package of selinux-policy-3.0.8
> >
> > #cd serefpolicy-3.0.8/policy/modules/services
> > #make -f /usr/share/selinux/devel/Makefile postgresql.pp
> > #semodule -i postgresql.pp
> >
> > libsepol.scope_copy_callback: postgresql: Duplicate declaration in
> > module: type/attribute postgresql_var_run_t
> > libsemanage.semanage_link_sandbox: Link packages failed
> > semodule:  Failed!
> >
> >
> > I doubted that in base.pp having postgresql ( it should not have, though)
>
> >From what I see in the Fedora CVS, postgresql is in the base module.
>
> --
> Chris PeBenito
> Tresys Technology, LLC
> (410) 290-1411 x150
>
>


-- 
Shintaro Fujiwara
segatex project (SELinux policy tool)
http://sourceforge.net/projects/segatex/
Home page
http://intrajp.no-ip.com/
Blog
http://intrajp.no-ip.com/nucleus/
CMS
http://intrajp.no-ip.com/xoops/
Wiki
http://intrajp.no-ip.com/pukiwiki/

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
