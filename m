Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j9MEIRNs023441
	for <selinux@tycho.nsa.gov>; Sat, 22 Oct 2005 10:18:28 -0400 (EDT)
Received: from mail.nagafix.co.uk (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j9MEEoM0010946
	for <selinux@tycho.nsa.gov>; Sat, 22 Oct 2005 14:14:50 GMT
Subject: mysql 4.1 requires shlib_t:file execmod?
From: Antoine Martin <antoine@nagafix.co.uk>
To: SELinux <selinux@tycho.nsa.gov>, gentoo-hardened@gentoo.org
Content-Type: text/plain
Date: Sat, 22 Oct 2005 15:15:09 +0100
Message-Id: <1129990510.31615.53.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

I've upgraded a (gentoo x86 selinux) system from MySQL 4.0 to 4.1, and
since then some of the software that uses mysql-libs refuse to run
without 'shlib_t:file execmod'.

ie: when starting postfix (built and rebuilt with mysql support):
postfix: error while loading shared
libraries: /usr/lib/libmysqlclient.so.14: cannot restore segment prot
after reloc: Permission denied

And here is the audit message:
[ 3159.289877] audit(1130082418.254:1085): avc:  denied  { execmod } for
pid=7905 comm="postfix" name="libmysqlclient.so.14.0.0" dev=md3
ino=84506 scontext=root:sysadm_r:postfix_postdrop_t
tcontext=system_u:object_r:shlib_t tclass=file

But other software does not needed it (mysql client, pdns, etc) even
though they are linked to the same library file...
What gives?

Thanks
Antoine


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
