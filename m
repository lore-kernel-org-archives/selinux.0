Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iA5JrJIi002617
	for <selinux@tycho.nsa.gov>; Fri, 5 Nov 2004 14:53:19 -0500 (EST)
Received: from wproxy.gmail.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id iA5JrLF9007319
	for <selinux@tycho.nsa.gov>; Fri, 5 Nov 2004 19:53:22 GMT
Received: by wproxy.gmail.com with SMTP id 64so58616wri
        for <selinux@tycho.nsa.gov>; Fri, 05 Nov 2004 11:53:19 -0800 (PST)
Message-ID: <561dc32604110511531fbd1e33@mail.gmail.com>
Date: Fri, 5 Nov 2004 14:53:19 -0500
From: Jiann-Ming Su <sujiannming@gmail.com>
Reply-To: Jiann-Ming Su <sujiannming@gmail.com>
To: selinux@tycho.nsa.gov
Subject: Re: MySQL Policy Patch
In-Reply-To: <1098205374.29525.99.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
References: <A52BEA1D8EE8634B9196A136333637B130F3@maat.darkhonor.net>
	 <561dc326041019095644afc579@mail.gmail.com>
	 <1098205374.29525.99.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 19 Oct 2004 13:02:54 -0400, Stephen Smalley <sds@epoch.ncsc.mil> wrote:
> 
> IIRC, on FC2, you would do:
> yum install policy-sources
> cd /etc/security/selinux/src/policy
> vi domains/program/mysqld.te
> 
> to look at the mysqld policy that shipped with FC2.  But you would
> likely do better to update to FC3T3 if using SELinux, as much has
> changed and FC2 policy hasn't had any updates AFAIK.
> 
FC3T3 wouldn't install on my system, so I'm having to work through
FC2.  When I try to run "/etc/init.d/mysql start" as root, I get the
following in dmesg:

audit(1099684144.872:0): avc:  denied  { read } for  pid=5099
exe=/bin/su name=.default_contexts dev=sda5 ino=213003
scontext=jms:user_r:user_su_t tcontext=root:object_r:staff_home_dir_t
tclass=file
inode_doinit_with_dentry: 
context_to_sid(system_u:object_r:mysql_home_dir_t) returned 22 for
dev=sda8 ino=1107617
audit(1099684153.056:0): avc:  denied  { associate } for  pid=5163
exe=/usr/sbin/mysqld-max name=booboo.lower-test
scontext=root:object_r:unlabeled_t tcontext=system_u:object_r:fs_t
tclass=filesystem
audit(1099684153.094:0): avc:  denied  { associate } for  pid=5163
exe=/usr/sbin/mysqld-max name=mysql.sock
scontext=root:object_r:unlabeled_t tcontext=system_u:object_r:fs_t
tclass=filesystem

What do I need to do so that mysql will start on my system, and users
can access the mysql database?  I've tried adding mysqld_r to the
users file, but mysqld_r is not a role.  Sorry for being so slow with
this.  Thanks for any info.

-- 
Jiann-Ming Su
"I have to decide between two equally frightening options. 
 If I wanted to do that, I'd vote." --Duckman

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
