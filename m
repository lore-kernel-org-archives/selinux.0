Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id JAA13511
	for <selinux@tycho.nsa.gov>; Fri, 1 Nov 2002 09:44:58 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id OAA05239
	for <selinux@tycho.nsa.gov>; Fri, 1 Nov 2002 14:43:03 GMT
Received: from csoc-fire1.csoconline.com (csoc-mail-imc.csoconline.com [140.169.2.142])
        by jazzband.ncsc.mil  with SMTP id OAA05234 for <selinux@tycho.nsa.gov>; Fri, 1 Nov 2002 14:42:58 GMT
Message-ID: <72222DC86846D411ABD300A0C9EB08A10152444B@csoc-mail-box.csoconline.com>
From: "Westerman, Mark" <Mark.Westerman@csoconline.com>
To: "'azeredo@qmc.ufsc.br'" <azeredo@qmc.ufsc.br>, selinux@tycho.nsa.gov
Subject: RE: Problems with policy in RH8
Date: Fri, 1 Nov 2002 08:44:07 -0600 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I have run across this before. Look at  file_context/programs/postfix.fc

See if the following line are in the file

/var/spool/postfix/lib(/.*)?                    system_u:object_r:lib_t
/var/spool/postfix/lib/ld.*\.so.*               system_u:object_r:ld_so_t
/var/spool/postfix/lib/lib.*\.so.*              system_u:object_r:shlib_t
/var/spool/postfix/lib/[^/]*/lib.*\.so.*        system_u:object_r:shlib_t
/var/spool/postfix/lib/devfsd/.*\.so.*  system_u:object_r:shlib_t
/var/spool/postfix/etc/services         system_u:object_r:etc_t

Add to the end of the postfix context file. I have not look at the
new version, but this problem existed on the previous version.


Mark

> -----Original Message-----
> From: azeredo@qmc.ufsc.br [mailto:azeredo@qmc.ufsc.br]
> Sent: Friday, November 01, 2002 8:38 AM
> To: selinux@tycho.nsa.gov
> Subject: Problems with policy in RH8
> 
> 
> 
> 
>   I saw at the  mail list someone was trying to get selinux 
> to run in RH8.
> I am trying too. And got many audit messages. The first one was:
> 
> avc: denied  {execute} for pid=9 exe=/bin/bash
> path=/lib/libnss_files-2.2.93.so dev=16:01 ino=159491
> scontext=system_u:system_r:initrc_t
> tcontext=system_u:obeject_r:var_spool_t tclass=file
> 
> after that many other related to atd, sendmail and others daemons.
> I read the work Configuring the SELinux Policy and I am 
> getting used to
> that structure, but still have many doubts. There, it is 
> explained how to
> solve problems like that but I dont feel secure enough to try 
> myself to
> solve mine.  Any help is very welcome.
> 
>                            Aldrovando  Azeredo (Bazil - UFSC)
>                             azeredo@qmc.ufsc.br
> 
> 
> 
> 
> --
> This message was distributed to subscribers of the selinux 
> mailing list.
> If you no longer wish to subscribe, send mail to 
> majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
> 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
