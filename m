Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7ODG2rT026128
	for <selinux@tycho.nsa.gov>; Tue, 24 Aug 2004 09:16:02 -0400 (EDT)
Received: from oe-im1.bizmailsrvcs.net (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i7ODG0CV002444
	for <selinux@tycho.nsa.gov>; Tue, 24 Aug 2004 13:16:01 GMT
Subject: Re: Users writting to home directory
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: "James R. Marcus" <jmarcus@mvalent.net>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <E6E16A6D4277CD459BBDE6713766033CA51515@exchange.mvalent.local>
References: <E6E16A6D4277CD459BBDE6713766033CA51515@exchange.mvalent.local>
Content-Type: text/plain; charset=iso-8859-13
Message-Id: <1093353229.8030.178.camel@selinux>
Mime-Version: 1.0
Date: Tue, 24 Aug 2004 09:13:49 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

There are a few problems:

On Mon, 2004-08-23 at 21:28, James R. Marcus wrote:
> Iÿm trying to understand how to let a user write to their home
> directory.
[cut]
> Aug 21 07:35:55 ftp useradd[3985]: new user: name=jmarcus, uid=1000,
> gid=100, home=/usr/people/jmarcus, shell=/bin/bash 
> 
> Aug 21 07:35:55 ftp audit(1093088155.035:0): avc:  denied  { add_name
> } for  pid=3985 exe=/usr/sbin/useradd name=jmarcus
> scontext=root:staff_r:staff_t tcontext=root:object_r:usr_t tclass=dir 

You didn't run useradd in the sysadm_r role, so useradd didn't
transition into useradd_t; your /etc/shadow is probably now mislabeled.

> Aug 23 12:05:36 ftp audit(1093277136.698:0): avc:  denied  { write }
> for  pid=7909 exe=/bin/nano path=/usr/people/jmarcus/test.txt dev=hda3
> ino=1907251 scontext=user_u:user_r:user_t
> tcontext=user_u:object_r:usr_t tclass=file

You need to relabel the user's home directory; either by hand or by
relabeling.  Useradd doesn't automatically relabel a user's home
directory.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
