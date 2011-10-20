Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p9KDdtsn004709
	for <selinux@tycho.nsa.gov>; Thu, 20 Oct 2011 09:39:55 -0400
Received: from mx1.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id p9KDdsSn005532
	for <selinux@tycho.nsa.gov>; Thu, 20 Oct 2011 13:39:55 GMT
Message-ID: <4EA024A6.9030706@redhat.com>
Date: Thu, 20 Oct 2011 09:39:50 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Ken Smith <kens@kensnet.org>
CC: selinux@tycho.nsa.gov
Subject: Re: Help Please with SELinux fail report
References: <4E9D248C.50700@kensnet.org>
In-Reply-To: <4E9D248C.50700@kensnet.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 10/18/2011 03:02 AM, Ken Smith wrote:
> Hi, I have a fair idea on using SELinux but I'd appreciate some
> guidance with a fail message I'm getting. Full message is
> appended.
> 
> Its from a Centos 5 system running the MythTV application. Part of
> that application uses ffmpeg to convert a video file (in
> /mnt/store) to .flv format and streams it using flowplayer to be
> viewed in remote web browser session. The application pipes the
> .flv output from ffmpeg via /dev/stdout
> 
> Any guidance most welcome.
> 
> Thanks
> 
> Ken
> 
> Reject Message is below
> 
> sealert -l 9c08728b-42e7-4836-857d-662884998dee
> 
> Summary:
> 
> SELinux is preventing the mythweb.pl from using potentially
> mislabeled files / (mnt_t).
> 
> Detailed Description:
> 
> SELinux has denied the mythweb.pl access to potentially mislabeled
> files /. This means that SELinux will not allow httpd to use these
> files. Many third party apps install html files in directories that
> SELinux policy cannot predict. These directories have to be labeled
> with a file context which httpd can access.
> 
> Allowing Access:
> 
> If you want to change the file context of / so that the httpd
> daemon can access it, you need to execute it using chcon -t
> httpd_sys_content_t '/'. You can look at the httpd_selinux man page
> for additional information.
> 
> Additional Information:
> 
> Source Context                root:system_r:httpd_sys_script_t 
> Target Context                system_u:object_r:mnt_t Target
> Objects                / [ dir ] Source
> mythweb.pl Source Path                   /usr/bin/perl Port
> <Unknown> Host                          ************************ 
> Source RPM Packages           perl-5.8.8-32.el5_6.3 Target RPM
> Packages           filesystem-2.4.0-3.el5.centos Policy RPM
> selinux-policy-2.4.6-300.el5_6.1 Selinux Enabled
> True Policy Type                   targeted MLS Enabled
> True Enforcing Mode                Enforcing Plugin Name
> httpd_bad_labels Host Name                     ************ 
> Platform                      Linux*********** 
> 2.6.18-238.12.1.el5.centos.plus #1 SMP Wed Jun 1 11:12:25 EDT 2011
> x86_64 x86_64 Alert Count                   2 First Seen
> Thu Oct 13 12:19:53 2011 Last Seen                     Thu Oct 13
> 12:19:53 2011 Local ID
> 9c08728b-42e7-4836-857d-662884998dee Line Numbers
> 
> Raw Audit Messages
> 
> host=knetgate.kensnet.org type=AVC
> msg=audit(1318504793.669:894697): avc:  denied  { search } for
> pid=8468 comm="mythweb.pl" name="/" dev=dm-1 ino=2
> scontext=root:system_r:httpd_sys_script_t:s0 
> tcontext=system_u:object_r:mnt_t:s0 tclass=dir
> 
> host=knetgate.kensnet.org type=SYSCALL
> msg=audit(1318504793.669:894697): arch=c000003e syscall=4
> success=no exit=-13 a0=1f5f79e0 a1=1f45e140 a2=1f45e140
> a3=3132323130 items=0 ppid=12664 pid=8468 auid=0 uid=48 gid=48
> euid=48 suid=48 fsuid=48 egid=48 sgid=48 fsgid=48 tty=(none) 
> ses=960 comm="mythweb.pl" exe="/usr/bin/perl" 
> subj=root:system_r:httpd_sys_script_t:s0 key=(null)
> 

If you are going to store apache content on the /mnt directory you
need to add rules to allow apache to search through the mnt_t directory

Easiest way to do this is by creating a policy module


# grep mnt_t /var/log/audit/audit.log | audit2allow -R -M myapache
# semodule -i myappache.pp

Not you might end up also needing a getattr access.  If so you could
run these commands above again or simply editit the myapache.te file
created and change the line

allow httpd_sys_script_t mnt_t:dir search;

To

allow httpd_sys_script_t mnt_t:dir search_dir_perms;

THen execute

# make -f /usr/share/selinux/devel/Makefile
# semodule -i myapache.pp
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk6gJKUACgkQrlYvE4MpobPrIACeNeGor+ymZp6VsCArxxDQoBdk
WgEAn2m3RVDBuRMo22nafXPwjsjklejc
=i8f2
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
