Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7R0OrrT017023
	for <selinux@tycho.nsa.gov>; Thu, 26 Aug 2004 20:24:53 -0400 (EDT)
Received: from oe-im2.bizmailsrvcs.net (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i7R0Op0g004043
	for <selinux@tycho.nsa.gov>; Fri, 27 Aug 2004 00:24:52 GMT
Subject: RE: Users writting to home directory
From: "David A. Cafaro" <dcafaro@tresys.com>
To: "James R. Marcus" <jmarcus@mvalent.net>
Cc: selinux@tycho.nsa.gov, selinux-dev@tresys.com
In-Reply-To: <E6E16A6D4277CD459BBDE6713766033CAE7D85@exchange.mvalent.local>
References: <E6E16A6D4277CD459BBDE6713766033CAE7D85@exchange.mvalent.local>
Content-Type: text/plain
Message-Id: <1093566325.2551.3.camel@localhost.localdomain>
Mime-Version: 1.0
Date: Thu, 26 Aug 2004 20:25:26 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

It looks like you haven't given ftpd_t access rights to
user_home_dir_t.  Something like this (may not be the best solution):

allow ftpd_t user_home_dir_t:dir { getattr search read };

in your ftpd policy would probably fix that.  

-David


On Thu, 2004-08-26 at 16:47, James R. Marcus wrote:
> I got these messages after a reboot in the messages log. I also have
> dmesg if anyone thinks it's important.
> 
> Aug 26 14:41:22 ftp audit(1093545682.841:0): avc:  denied  { getattr }
> for  pid=3999 exe=/usr/sbin/vsftpd path=/proc/3999/mounts dev=proc
> ino=262078480 scontext=system_u:system_r:ftpd_t
> tcontext=system_u:system_r:ftpd_t tclass=file
> Aug 26 14:41:22 ftp audit(1093545682.875:0): avc:  denied  { search }
> for  pid=4001 exe=/usr/sbin/vsftpd name=jmarcus7 dev=hda3 ino=1547603
> scontext=system_u:system_r:ftpd_t
> tcontext=system_u:object_r:user_home_dir_t tclass=dir
> Aug 26 14:41:24 ftp audit(1093545684.028:0): avc:  denied  { read } for
> pid=4001 exe=/usr/sbin/vsftpd name=jmarcus7 dev=hda3 ino=1547603
> scontext=system_u:system_r:ftpd_t
> tcontext=system_u:object_r:user_home_dir_t tclass=dir
> Aug 26 14:41:24 ftp audit(1093545684.028:0): avc:  denied  { getattr }
> for  pid=4001 exe=/usr/sbin/vsftpd path=/ dev=hda3 ino=1547603
> scontext=system_u:system_r:ftpd_t
> tcontext=system_u:object_r:user_home_dir_t tclass=dir
> 
> 
> ftp root # find / -inum 262078480
> /proc/3999/mounts
> find: /proc/4036/task/4036/fd/4: No such file or directory
> ftp root # ls -Z /proc/3999/mounts 
> Segmentation fault
> ftp root #  
> 
> ftp root # find / -inum 1547603 
> /home/jmarcus7
> find: /proc/4038/task/4038/fd/4: No such file or directory
> ftp root # ls -Z /home/jmarcus7
> -rw-r--r--  jmarcus7 users system_u:object_r:user_home_t
> san2004.SP2-9131-Win32-OVC.exe
> ftp root #
> 
> 
> 
> Thanks,
> James
> 
> 
> -----Original Message-----
> From: owner-selinux@tycho.nsa.gov [mailto:owner-selinux@tycho.nsa.gov]
> On Behalf Of Karl MacMillan
> Sent: Tuesday, August 24, 2004 8:48 PM
> To: James R. Marcus; Stephen Smalley
> Cc: selinux@tycho.nsa.gov; selinux-dev@tresys.com
> Subject: Re: Users writting to home directory
> 
> 
> ----- Original Message ----- 
> From: "James R. Marcus" <jmarcus@mvalent.net>
> To: "Stephen Smalley" <sds@epoch.ncsc.mil>
> Cc: <selinux@tycho.nsa.gov>
> Sent: Tuesday, August 24, 2004 2:14 PM
> Subject: RE: Users writting to home directory
> 
> 
> > Okay I tried just creating a user under home.  While in permissive
> mode
> > they can login to the ftp server and upload and download.  However
> when
> > I turn on enforced mode they get this message:
> >
> > C:\Documents and Settings\jmarcus\Desktop>ftp ftp
> > Connected to ftp.mvalent.local.
> > 220 Welcome to mValent, Inc. FTP service.
> > User (ftp.mvalent.local:(none)): jmarcus7
> > 331 Please specify the password.
> > Password:
> > 500 OOPS: cannot change directory:/home/jmarcus7
> > 500 OOPS: child died
> > Connection closed by remote host.
> >
> > C:\Documents and Settings\jmarcus\Desktop>
> >
> > ftp policy # seuseradd -g users -d /home/jmarcus7 -m -s /bin/bash  -c
> > "James R. Marcus" jmarcus7
> > loading new policy...
> >
> > Error relabeling users home directory files: User is not defined in
> the
> > policy.
> >
> 
> I'll look into this bug. You may have mentioned this earlier in the
> thread,
> but can you give me some details of your configuration. Also, what does
> ls -Z /home give you?
> 
> Thanks,
> 
> Karl
> 
> > ftp policy # seuseradd -A
> > loading new policy...
> >
> > /var/log/messages
> > Aug 24 12:01:23 ftp useradd[2850]: new user: name=jmarcus7, uid=1006,
> > gid=100, home=/home/jmarcus7, shell=/bin/bash
> >
> > I have seen this message a few times:
> >
> > Aug 24 07:01:49 ftp sshd[10945]: error: open /dev/tty failed - could
> not
> > set controlling tty: Permission denied
> >
> >
> > Thanks,
> > James
> >
> >
> >
> > -----Original Message-----
> > From: owner-selinux@tycho.nsa.gov [mailto:owner-selinux@tycho.nsa.gov]
> > On Behalf Of Stephen Smalley
> > Sent: Tuesday, August 24, 2004 8:36 AM
> > To: James R. Marcus
> > Cc: selinux@tycho.nsa.gov
> > Subject: Re: Users writting to home directory
> >
> > On Mon, 2004-08-23 at 21:28, James R. Marcus wrote:
> > > I created the user with:
> > >
> > > useradd -g users -d /usr/people/jmarcus -m -s /bin/bash -c "James R.
> > > Marcus" jmarcus
> >
> > You need to set HOME to /usr/people in /etc/default/useradd and
> rebuild
> > your policy and relabel /usr/people.  Or just put the home directory
> > under /home, which is the current default.
> >
> > > Aug 21 07:35:55 ftp audit(1093088155.035:0): avc:  denied  {
> add_name
> > > } for  pid=3985 exe=/usr/sbin/useradd name=jmarcus
> > > scontext=root:staff_r:staff_t tcontext=root:object_r:usr_t
> tclass=dir
> >
> > Two obvious problems:  1) You are running useradd in the staff_r role
> > rather than the sysadm_r role.  newrole -r sysadm_r to switch to the
> > admin role.  2) The type on /usr/people is usr_t, whereas the policy
> > expects home directory root to have home_root_t.  This can be fixed as
> > described above, or more easily just by putting home directories under
> > /home as usual.
> >
> > -- 
> > Stephen Smalley <sds@epoch.ncsc.mil>
> > National Security Agency
> >
> >
> > --
> > This message was distributed to subscribers of the selinux mailing
> list.
> > If you no longer wish to subscribe, send mail to
> majordomo@tycho.nsa.gov
> > with
> > the words "unsubscribe selinux" without quotes as the message.
> >
> >
> >
> > --
> > This message was distributed to subscribers of the selinux mailing
> list.
> > If you no longer wish to subscribe, send mail to
> majordomo@tycho.nsa.gov
> with
> > the words "unsubscribe selinux" without quotes as the message.
> >
> 
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov
> with
> the words "unsubscribe selinux" without quotes as the message.
> 
> 
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
