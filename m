Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m18DYc8m007202
	for <selinux@tycho.nsa.gov>; Fri, 8 Feb 2008 08:34:38 -0500
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m18DYaA1022323
	for <selinux@tycho.nsa.gov>; Fri, 8 Feb 2008 13:34:36 GMT
Message-ID: <47AC5A69.2070202@redhat.com>
Date: Fri, 08 Feb 2008 08:34:33 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Jeremiah Jahn <jeremiah@goodinassociates.com>
CC: selinux <selinux@tycho.nsa.gov>
Subject: Re: new user types
References: <1202426088.2801.500.camel@bluejay.goodinassociates.com>
In-Reply-To: <1202426088.2801.500.camel@bluejay.goodinassociates.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Jeremiah Jahn wrote:
> I can't seem to login as the right user, and I'm not sure what I missed.
> 
> I added the following roles and users to my monetra.te file:
> 
> 
> #admin roles
> role monetra_admin_r types monetra_t;
> role monetra_admin_r types monetra_lib_t;
> 
> #client roles
> role monetra_client_r types monetra_t;
> role monetra_client_r types monetra_lib_t;
> role monetra_client_r types monetra_client_t;
> 
> #monetra users
> user monetra_u roles { monetra_client_r monetra_admin_r } level s0 range s0 - s0;
> 
> 
> 
> 
> I ran the add login command:
> semanage login -a -s monetra_u bob
> 
> 
> 
> I get the following output:
> [root@xxx ~]# semanage login -l
> 
> Login Name                SELinux User              MLS/MCS Range            
> 
> __default__               user_u                    s0                       
> root                      root                      s0-s0:c0.c255            
> system_u                  system_u                  s0-s0:c0.c255            
> bob                      monetra_u                 s0                       
> 
> [root@xxx ~]# semanage user -l
> 
>                 Labeling   MLS/       MLS/                          
> SELinux User    Prefix     MCS Level  MCS Range                      SELinux Roles
> 
> 
> monetra_u       user       s0         s0                             monetra_admin_r monetra_client_r
> root            sysadm     s0         s0-s0:c0.c255                  sysadm_r staff_r
> staff_u         staff      s0         s0-s0:c0.c255                  sysadm_r staff_r
> sysadm_u        sysadm     s0         s0-s0:c0.c255                  sysadm_r
> system_u        user       s0         s0-s0:c0.c255                  system_r
> unconfined_u    unconfined s0         s0-s0:c0.c255                  unconfined_r
> user_u          user       s0         s0                             user_r
> 
> yet when I login I get:
> [bob@xxx ~]$ id -Z
> system_u:system_r:unconfined_t:s0-s0:c0.c255
> 
> 
> thanx for any help you can give.
> 
> 
You need to create a contexts file for monetra_u.

/etc/selinux/targeted/contexts/users/monetra_u
Then set it up for the appropriate commands
xguest_u looks like

system_r:local_login_t	xguest_r:xguest_t:s0
system_r:remote_login_t	xguest_r:xguest_t:s0
system_r:sshd_t		xguest_r:xguest_t:s0
system_r:crond_t	xguest_r:xguest_crond_t:s0
system_r:xdm_t		xguest_r:xguest_t:s0


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.8 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iEYEARECAAYFAkesWmkACgkQrlYvE4MpobMjxgCfYEe9Sq1qlHRR4D3SkMViIeqG
KdcAoJ2mrdBBcxNoWVsy9ITDXInaYdUs
=dhVO
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
