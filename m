Subject: Re: vsftpd and chrooted home directories
From: "David A. Cafaro" <dcafaro@tresys.com>
To: ryan.graham+cr@gmail.com
Cc: SELinux@tycho.nsa.gov
In-Reply-To: <42efd069041012162143f7aa9a@mail.gmail.com>
References: <42efd069041012162143f7aa9a@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1097675234.24296.27.camel@rogue.columbia.tresys.com>
Mime-Version: 1.0
Date: Wed, 13 Oct 2004 09:47:15 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

It looks like the policy has not given vsFTPd access to the users home
directory (hence the denial of ftpd_t type from searching the
user_home_dir_t type).  Since it appears that your /home directories are
labeled with user_home_dir_t, for the vsFTPd to access them you will
need to allow ftpd_t to search user_home_dir_t.  That or label each of
you users directories individually and give vsFTPd separate permissions
for each different label.

Hope that helps some.
-David

On Tue, 2004-10-12 at 19:21, Ryan Graham wrote:
> Hi, I'm going to throw out an AVC message and part of my config here.
> Maybe someone will recognize this.
> 
> audit(1097622518.160:0): avc:  denied  { getattr } for  pid=2774
> exe=/usr/sbin/vsftpd path=/proc/2774/mounts dev= ino=181796880
> scontext=root:system_r:ftpd_t tcontext=root:system_r:ftpd_t
> tclass=file
> 
> audit(1097622518.174:0): avc:  denied  { search } for  pid=2778
> exe=/usr/sbin/vsftpd name=media dev=hda2 ino=5210119
> scontext=root:system_r:ftpd_t
> tcontext=system_u:object_r:user_home_dir_t tclass=dir
> 
> Response:	220 (vsFTPd 1.2.1)
> Command:	USER media
> Response:	331 Please specify the password.
> Command:	PASS *****
> Response:	500 OOPS: cannot change directory:/home/media
> Error:	Unable to connect!
> 
> local_enable=YES
> write_enable=YES
> local_umask=022
> chroot_local_user=YES
> pam_service_name=vsftpd
> userlist_enable=YES
> listen=YES
> tcp_wrappers=YES
> 
> This all works on an almost identical FC2 box with enforcing off.
> 
> Am I being stupid here? Should I go back to the manuals or spam
> audit2allow at it?
> 
> Thanks,
> Ryan
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
