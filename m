Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7P0mxrT002054
	for <selinux@tycho.nsa.gov>; Tue, 24 Aug 2004 20:48:59 -0400 (EDT)
Received: from gotham.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i7P0mvCV024698
	for <selinux@tycho.nsa.gov>; Wed, 25 Aug 2004 00:48:57 GMT
Message-ID: <006001c48a3d$400e8cb0$0102a8c0@DESKTOP>
From: "Karl MacMillan" <kmacmillan@tresys.com>
To: "James R. Marcus" <jmarcus@mvalent.net>,
   "Stephen Smalley" <sds@epoch.ncsc.mil>
Cc: <selinux@tycho.nsa.gov>, <selinux-dev@tresys.com>
References: <E6E16A6D4277CD459BBDE6713766033CA515CD@exchange.mvalent.local>
Subject: Re: Users writting to home directory
Date: Tue, 24 Aug 2004 20:47:56 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


----- Original Message ----- 
From: "James R. Marcus" <jmarcus@mvalent.net>
To: "Stephen Smalley" <sds@epoch.ncsc.mil>
Cc: <selinux@tycho.nsa.gov>
Sent: Tuesday, August 24, 2004 2:14 PM
Subject: RE: Users writting to home directory


> Okay I tried just creating a user under home.  While in permissive mode
> they can login to the ftp server and upload and download.  However when
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
> Error relabeling users home directory files: User is not defined in the
> policy.
>

I'll look into this bug. You may have mentioned this earlier in the thread,
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
> Aug 24 07:01:49 ftp sshd[10945]: error: open /dev/tty failed - could not
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
> You need to set HOME to /usr/people in /etc/default/useradd and rebuild
> your policy and relabel /usr/people.  Or just put the home directory
> under /home, which is the current default.
>
> > Aug 21 07:35:55 ftp audit(1093088155.035:0): avc:  denied  { add_name
> > } for  pid=3985 exe=/usr/sbin/useradd name=jmarcus
> > scontext=root:staff_r:staff_t tcontext=root:object_r:usr_t tclass=dir
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
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov
> with
> the words "unsubscribe selinux" without quotes as the message.
>
>
>
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov
with
> the words "unsubscribe selinux" without quotes as the message.
>


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
