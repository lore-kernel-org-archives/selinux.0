Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p66JH3wa007792
	for <selinux@tycho.nsa.gov>; Wed, 6 Jul 2011 15:17:05 -0400
Received: from mx1.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id p66JH4kJ006558
	for <selinux@tycho.nsa.gov>; Wed, 6 Jul 2011 19:17:04 GMT
Message-ID: <4E14B4AC.9000905@redhat.com>
Date: Wed, 06 Jul 2011 15:17:00 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Kurt.Nelson@gtri.gatech.edu
CC: selinux@tycho.nsa.gov
Subject: Re: MLS Not enforcing secadm and auditadm
References: <BC2F7132E56EEE4E864092975C1447BA730123@apatlisdmbx02>
In-Reply-To: <BC2F7132E56EEE4E864092975C1447BA730123@apatlisdmbx02>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 07/06/2011 08:42 AM, Kurt.Nelson@gtri.gatech.edu wrote:
> I?m setting up a RHEL6 box with MLS and am having issues with it
> enforcing the use of roles. Secadm_r and auditadm_r are not required to
> run setenforce or semanage and no role is able to write in /etc/audit/
> at all. The IRC channel seems to believe there is an issue with the
> ifndef(?enable_mls?? not triggering.
> 
>  
> 
> [root@hatch ~]$ id -Z
> 
> staff_u:sysadm_r:sysadm_t:s0
> 
>  
> 
> [knelson6@hatch ~]$ ls -Z /usr/sbin/semanage
> 
> -rwxr-xr-x. root root system_u:object_r:semanage_exec_t:s0
> /usr/sbin/semanage
> 
>  
> 
> [knelson6@hatch ~]$ sestatus
> 
> SELinux status:                 enabled
> 
> SELinuxfs mount:                /selinux
> 
> Current mode:                   enforcing
> 
> Mode from config file:          enforcing
> 
> Policy version:                 24
> 
> Policy from config file:        mls
> 
>  
> 
> [root@hatch ~]# sesearch --allow -s sysadm_t -t semanage_exec_t -c file
> -p execute
> 
> Found 3 semantic av rules:
> 
>    allow sysadm_t application_exec_type : file { ioctl read getattr lock
> execute execute_no_trans open } ;
> 
>    allow sysadm_usertype application_exec_type : file { ioctl read
> getattr lock execute execute_no_trans open } ;
> 
>    allow sysadm_t semanage_exec_t : file { ioctl read write create
> getattr setattr lock relabelfrom relabelto append unlink link rename
> execute open } ;
> 
>  
> 
> [root@hatch ~]# sesearch -SCT --allow -s sysadm_t -t semanage_exec_t
> 
> Found 11 semantic av rules:
> 
>    allow sysadm_t application_exec_type : file { ioctl read getattr lock
> execute execute_no_trans open } ;
> 
>    allow sysadm_t file_type : filesystem getattr ;
> 
>    allow sysadm_usertype application_exec_type : file { ioctl read
> getattr lock execute execute_no_trans open } ;
> 
>    allow sysadm_usertype file_type : filesystem getattr ;
> 
>    allow sysadm_t semanage_exec_t : file { ioctl read write create
> getattr setattr lock relabelfrom relabelto append unlink link rename
> execute open } ;
> 
>    allow sysadm_t semanage_exec_t : dir { ioctl read write create
> getattr setattr lock relabelfrom relabelto unlink link rename add_name
> remove_name reparent search rmdir open } ;
> 
>    allow sysadm_t semanage_exec_t : lnk_file { ioctl read write create
> getattr setattr lock relabelfrom relabelto append unlink link rename } ;
> 
>    allow sysadm_t semanage_exec_t : chr_file { getattr relabelfrom
> relabelto } ;
> 
>    allow sysadm_t semanage_exec_t : blk_file { getattr relabelfrom
> relabelto } ;
> 
>    allow sysadm_t semanage_exec_t : sock_file { ioctl read write create
> getattr setattr lock relabelfrom relabelto append unlink link rename
> open } ;
> 
>    allow sysadm_t semanage_exec_t : fifo_file { ioctl read write create
> getattr setattr lock relabelfrom relabelto append unlink link rename
> open } ;
> 
>  
> 
> Found 1 semantic te rules:
> 
>    type_transition sysadm_t semanage_exec_t : process semanage_t;
> 
> --
> 
> Kurt Nelson
> 
> GTRI-STL IT Coop
> 
>  
> 
Did you destribute your own policy or are you using the RHEL6 MLS Policy?
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAk4UtKwACgkQrlYvE4MpobMnhgCdEHw0Mc6ci02ZqdHs9cFTnq6w
/ukAnAuvjE2WsfkVCW4O1aqiNt/kUerV
=h8Dn
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
