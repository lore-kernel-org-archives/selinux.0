Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7QJV3rT015575
	for <selinux@tycho.nsa.gov>; Thu, 26 Aug 2004 15:31:03 -0400 (EDT)
Received: from mail.mvalent.net (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i7QJUGfU022447
	for <selinux@tycho.nsa.gov>; Thu, 26 Aug 2004 19:30:17 GMT
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: Users writting to home directory
Date: Thu, 26 Aug 2004 15:30:58 -0400
Message-ID: <E6E16A6D4277CD459BBDE6713766033CAE7D68@exchange.mvalent.local>
From: "James R. Marcus" <jmarcus@mvalent.net>
To: "Karl MacMillan" <kmacmillan@tresys.com>,
   "Stephen Smalley" <sds@epoch.ncsc.mil>
Cc: <selinux@tycho.nsa.gov>, <selinux-dev@tresys.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I used the setfiles command to relabel the users home directory, but I
am still having problems with ftp.  I'm using vsftpd and not really
seeing any message in /var/log/messages.  I will roll the logs and make
sure I haven't missed anything.

ftp home # ls -Z /home/
drwxr-xr-x  jmarcus7 users root:object_r:user_home_dir_t     jmarcus7
ftp home # setfiles /etc/security/selinux/file_contexts /home/jmarcus7
setfiles:  read 587 specifications
setfiles:  labeling files under /home/jmarcus7
setfiles:  hash table stats: 4 elements, 4/65536 buckets used, longest
chain length 1
setfiles:  Done.
ftp home # ls -Z /home/
drwxr-xr-x  jmarcus7 users system_u:object_r:user_home_dir_t jmarcus7
ftp home # avc_toggle 
enforcing
ftp home # ls -Z /etc/shadow
-rw-------  root root system_u:object_r:shadow_t /etc/shadow
ftp home # avc_toggle 
enforcing
ftp home # ls -Z /etc/shadow
-rw-------  root root system_u:object_r:shadow_t /etc/shadow

>From DOS:
Microsoft Windows XP [Version 5.1.2600]
(C) Copyright 1985-2001 Microsoft Corp.

C:\Documents and Settings\jmarcus>ftp ftp
Connected to ftp.mvalent.local.
220 Welcome to mValent, Inc. FTP service.
User (ftp.mvalent.local:(none)): jmarcus7
331 Please specify the password.
Password:
500 OOPS: cannot change directory:/home/jmarcus7
500 OOPS: child died
Connection closed by remote host.

C:\Documents and Settings\jmarcus>


Thanks,
James


-----Original Message-----
From: owner-selinux@tycho.nsa.gov [mailto:owner-selinux@tycho.nsa.gov]
On Behalf Of Karl MacMillan
Sent: Tuesday, August 24, 2004 8:48 PM
To: James R. Marcus; Stephen Smalley
Cc: selinux@tycho.nsa.gov; selinux-dev@tresys.com
Subject: Re: Users writting to home directory


----- Original Message ----- 
From: "James R. Marcus" <jmarcus@mvalent.net>
To: "Stephen Smalley" <sds@epoch.ncsc.mil>
Cc: <selinux@tycho.nsa.gov>
Sent: Tuesday, August 24, 2004 2:14 PM
Subject: RE: Users writting to home directory


> Okay I tried just creating a user under home.  While in permissive
mode
> they can login to the ftp server and upload and download.  However
when
> I turn on enforced mode they get this message:
>
> C:\Documents and Settings\jmarcus\Desktop>ftp ftp
> Connected to ftp.mvalent.local.
> 220 Welcome to mValent, Inc. FTP service.
> User (ftp.mvalent.local:(none)): jmarcus7
> 331 Please specify the password.
> Password:
> 500 OOPS: cannot change directory:/home/jmarcus7
> 500 OOPS: child died
> Connection closed by remote host.
>
> C:\Documents and Settings\jmarcus\Desktop>
>
> ftp policy # seuseradd -g users -d /home/jmarcus7 -m -s /bin/bash  -c
> "James R. Marcus" jmarcus7
> loading new policy...
>
> Error relabeling users home directory files: User is not defined in
the
> policy.
>

I'll look into this bug. You may have mentioned this earlier in the
thread,
but can you give me some details of your configuration. Also, what does
ls -Z /home give you?

Thanks,

Karl

> ftp policy # seuseradd -A
> loading new policy...
>
> /var/log/messages
> Aug 24 12:01:23 ftp useradd[2850]: new user: name=jmarcus7, uid=1006,
> gid=100, home=/home/jmarcus7, shell=/bin/bash
>
> I have seen this message a few times:
>
> Aug 24 07:01:49 ftp sshd[10945]: error: open /dev/tty failed - could
not
> set controlling tty: Permission denied
>
>
> Thanks,
> James
>
>
>
> -----Original Message-----
> From: owner-selinux@tycho.nsa.gov [mailto:owner-selinux@tycho.nsa.gov]
> On Behalf Of Stephen Smalley
> Sent: Tuesday, August 24, 2004 8:36 AM
> To: James R. Marcus
> Cc: selinux@tycho.nsa.gov
> Subject: Re: Users writting to home directory
>
> On Mon, 2004-08-23 at 21:28, James R. Marcus wrote:
> > I created the user with:
> >
> > useradd -g users -d /usr/people/jmarcus -m -s /bin/bash -c "James R.
> > Marcus" jmarcus
>
> You need to set HOME to /usr/people in /etc/default/useradd and
rebuild
> your policy and relabel /usr/people.  Or just put the home directory
> under /home, which is the current default.
>
> > Aug 21 07:35:55 ftp audit(1093088155.035:0): avc:  denied  {
add_name
> > } for  pid=3985 exe=/usr/sbin/useradd name=jmarcus
> > scontext=root:staff_r:staff_t tcontext=root:object_r:usr_t
tclass=dir
>
> Two obvious problems:  1) You are running useradd in the staff_r role
> rather than the sysadm_r role.  newrole -r sysadm_r to switch to the
> admin role.  2) The type on /usr/people is usr_t, whereas the policy
> expects home directory root to have home_root_t.  This can be fixed as
> described above, or more easily just by putting home directories under
> /home as usual.
>
> -- 
> Stephen Smalley <sds@epoch.ncsc.mil>
> National Security Agency
>
>
> --
> This message was distributed to subscribers of the selinux mailing
list.
> If you no longer wish to subscribe, send mail to
majordomo@tycho.nsa.gov
> with
> the words "unsubscribe selinux" without quotes as the message.
>
>
>
> --
> This message was distributed to subscribers of the selinux mailing
list.
> If you no longer wish to subscribe, send mail to
majordomo@tycho.nsa.gov
with
> the words "unsubscribe selinux" without quotes as the message.
>


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov
with
the words "unsubscribe selinux" without quotes as the message.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
