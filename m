Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7ODTnrT026225
	for <selinux@tycho.nsa.gov>; Tue, 24 Aug 2004 09:29:49 -0400 (EDT)
Received: from gotham.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i7ODT4MZ005125
	for <selinux@tycho.nsa.gov>; Tue, 24 Aug 2004 13:29:04 GMT
Message-Id: <200408241329.i7ODTPSf028829@gotham.columbia.tresys.com>
From: "Karl MacMillan" <kmacmillan@tresys.com>
To: "'Christopher J. PeBenito'" <cpebenito@tresys.com>,
   "'James R. Marcus'" <jmarcus@mvalent.net>
Cc: <selinux@tycho.nsa.gov>, <selinux-dev@tresys.com>
Subject: RE: Users writting to home directory
Date: Tue, 24 Aug 2004 09:29:26 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <1093353229.8030.178.camel@selinux>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> -----Original Message-----
> From: Christopher J. PeBenito [mailto:cpebenito@tresys.com]
> Sent: Tuesday, August 24, 2004 9:14 AM
> To: James R. Marcus
> Cc: selinux@tycho.nsa.gov
> Subject: Re: Users writting to home directory
> 
> There are a few problems:
> 
> On Mon, 2004-08-23 at 21:28, James R. Marcus wrote:
> > I'm trying to understand how to let a user write to their home
> > directory.
> [cut]
> > Aug 21 07:35:55 ftp useradd[3985]: new user: name=jmarcus, uid=1000,
> > gid=100, home=/usr/people/jmarcus, shell=/bin/bash
> >
> > Aug 21 07:35:55 ftp audit(1093088155.035:0): avc:  denied  { add_name
> > } for  pid=3985 exe=/usr/sbin/useradd name=jmarcus
> > scontext=root:staff_r:staff_t tcontext=root:object_r:usr_t tclass=dir
> 
> You didn't run useradd in the sysadm_r role, so useradd didn't
> transition into useradd_t; your /etc/shadow is probably now mislabeled.
> 
> > Aug 23 12:05:36 ftp audit(1093277136.698:0): avc:  denied  { write }
> > for  pid=7909 exe=/bin/nano path=/usr/people/jmarcus/test.txt dev=hda3
> > ino=1907251 scontext=user_u:user_r:user_t
> > tcontext=user_u:object_r:usr_t tclass=file
> 
> You need to relabel the user's home directory; either by hand or by
> relabeling.  Useradd doesn't automatically relabel a user's home
> directory.
> 

That is one of the advantages of seuser and seuseradd - they automatically
label a user's home directory after creating it. It is available as a
package for many distributions, but also from http://www.tresys.com/selinux.

Karl

Karl MacMillan
Tresys Technology
http://www.tresys.com
(410)290-1411 ext 134

> --
> Chris PeBenito
> Tresys Technology, LLC
> (410) 290-1411 x150



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
