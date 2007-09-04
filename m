Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l84BPdSl022384
	for <selinux@tycho.nsa.gov>; Tue, 4 Sep 2007 07:25:39 -0400
Received: from py-out-1112.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l84BPc7Q002440
	for <selinux@tycho.nsa.gov>; Tue, 4 Sep 2007 11:25:38 GMT
Received: by py-out-1112.google.com with SMTP id u77so5988722pyb
        for <selinux@tycho.nsa.gov>; Tue, 04 Sep 2007 04:25:37 -0700 (PDT)
Message-ID: <8f34198c0709040425u48adae75g48e1035ecb4f1305@mail.gmail.com>
Date: Tue, 4 Sep 2007 19:25:35 +0800
From: "Ian jonhson" <jonhson.ian@gmail.com>
To: "Daniel J Walsh" <dwalsh@redhat.com>
Subject: Re: About the polgengui in FC7
Cc: "SE Linux" <selinux@tycho.nsa.gov>
In-Reply-To: <8f34198c0709020104g35d5e311w2fc9a3d137882e22@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <8f34198c0708300703g7b75cdfbpe65a675e78a56dff@mail.gmail.com>
	 <46D6FD7E.6060306@redhat.com>
	 <8f34198c0708302015v1daba3e5n3111bf6da628b13d@mail.gmail.com>
	 <46D7E619.40601@redhat.com>
	 <8f34198c0709020104g35d5e311w2fc9a3d137882e22@mail.gmail.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> yum install selinux-policy-devel
> Then run the script again
>

I still met some problem in running the script. The message are as follows:

------------- dump screen --------------
[root@Fedora7 policy]# sh rwho.sh
rwho.if:14: Error: duplicate definition of rwho_domtrans(). Original
definition on 14.
Compiling targeted rwho module
/usr/bin/checkmodule:  loading policy configuration from tmp/rwho.tmp
/usr/bin/checkmodule:  policy configuration loaded
/usr/bin/checkmodule:  writing binary representation (version 6) to tmp/rwho.mod
Creating targeted rwho.pp policy package
rm tmp/rwho.mod tmp/rwho.mod.fc
/sbin/restorecon reset /usr/bin/rwho context
system_u:object_r:rwho_exec_t:s0->system_u:object_r:rwho_exec_t:s0
[root@Fedora7 policy]# setenforce 0
bash: setenforce: command not found
...
------------------------------------------------

I am not sure whether the duplicate definition would affect the policy
creation, but I got the difference from description in article. Also,
I can not execute setenforce, and not find the the command.

When I run the audit2allow, the output messages are:

----------  dump screen ------------------
[root@Fedora7 tmp]# grep rwho /var/log/audit/audit.log | audit2allow -R

require {
       type rwho_t;
}

#============= rwho_t ==============
files_search_spool(rwho_t)


[root@Fedora7 tmp]# grep rwho /var/log/audit/audit.log
type=AVC msg=audit(1188717730.985:106): avc:  denied  { search } for
pid=3753 comm="rwhod" name="spool" dev=dm-0 ino=130473
scontext=user_u:system_r:rwho_t:s0
tcontext=system_u:object_r:var_spool_t:s0 tclass=dir
type=SYSCALL msg=audit(1188717730.985:106): arch=40000003 syscall=12
success=no exit=-13 a0=8000270c a1=2 a2=80003b5c a3=1 items=0
ppid=3752 pid=3753 auid=500 uid=0 gid=0 euid=0 suid=0 fsuid=0 egid=0
sgid=0 fsgid=0 tty=(none) comm="rwhod" exe="/usr/sbin/rwhod"
subj=user_u:system_r:rwho_t:s0 key=(null)
[root@Fedora7 tmp]#
--------------------------------------------------

Did I forget anything?


> yes you can do this,  The extension that I am adding, is to setup logged
> in users who can not talk to the network, or only one port on the
> network.  These users will not be able to run any setuid applications or
>  even execute files in the home directories.

Very good, but in current FC7, that functionalities are not supported,
right? If the polgengui in FC7 does not support the above
functionality, can I do my jobs by editing policy source files
manually? what to do?

Thank you very much !!



Best regards,

ian

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
