Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o3FHlC6K011115
	for <selinux@tycho.nsa.gov>; Thu, 15 Apr 2010 13:47:16 -0400
Received: from mx1.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id o3FHm9aX010684
	for <selinux@tycho.nsa.gov>; Thu, 15 Apr 2010 17:48:10 GMT
Message-ID: <4BC7511F.90100@redhat.com>
Date: Thu, 15 Apr 2010 13:47:11 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: jimi@sngx.net
CC: Selinux <selinux@tycho.nsa.gov>
Subject: Re: sudo + selinux
References: <C7EA5D61.B6871%csellers@tresys.com> <a7997a4e13a79796e80e71b9ff6d31c9@sngx.net> <4BC5B6AC.1040101@redhat.com> <4fc4d1cb9c79a5ba45b92b1c6c25b8b3@sngx.net> <4BC5D183.20403@redhat.com> <3acfd6eb614d7ebec2d3c10d98940708@sngx.net> <4BC5F226.5090006@redhat.com> <34f60e632890202669f67e9498c0fa9e@sngx.net>
In-Reply-To: <34f60e632890202669f67e9498c0fa9e@sngx.net>
Content-Type: text/plain; charset=UTF-8
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 04/14/2010 09:46 AM, James Cammarata wrote:
> 
> So, I was playing with this yesterday and couldn't get it to work quite
> right.  I created a shell script (/usr/bin/audit.sh), which contains the
> following:
> 
> [root@kvm001 ~]# cat /usr/bin/audit.sh
> newrole -r sysadm_r -t sysadm_t -- $*
> 
> And sudoers has this:
> 
> test ALL=(ALL) NOPASSWD: /usr/bin/audit.sh
> 
> [root@kvm001 ~]# cat /etc/pam.d/newrole
> #%PAM-1.0
> auth       sufficient   pam_rootok.so
> auth       include      system-auth
> account    include      system-auth
> password   include      system-auth
> session    required     pam_namespace.so unmnt_remnt no_unmount_on_close
> 
> [root@kvm001 ~]# semanage login -l
> 
> Login Name                SELinux User              MLS/MCS Range
> 
> __default__               user_u                    s0
> root                      root                      SystemLow-SystemHigh
> system_u                  system_u                  SystemLow-SystemHigh
> test                      staff_u                   s0
> 
> Added some policy to allow staff_t to run audit.sh via sudo:
> 
> [root@kvm001 ~]# cat staffsudo.te
> module staffsudo 0.0.1;
> 
> require {
>         type bin_t;
>         type staff_t;
>         type staff_sudo_t;
>         class file { execute execute_no_trans };
>         class capability { dac_read_search dac_override };
> }
> 
> #============= staff_sudo_t ==============
> allow staff_sudo_t bin_t:file { execute execute_no_trans };
> 
> #============= staff_t ==============
> allow staff_t self:capability { dac_read_search dac_override };
> 
> 
> 
> But, when I try to run the command as the "test" user via sudo, here's all
> I get:
> 
> [test@kvm001 ~]$ sudo /usr/bin/audit.sh less /var/log/messages
> Password:
> /usr/bin/less: /usr/bin/less: cannot execute binary file
> 
> 
Does this work in permissive mode?
> And here is the audit.log output from that:
> 
> type=CRED_ACQ msg=audit(1271345951.906:1159790): user pid=9218 uid=0
> auid=502 subj=staff_u:staff_r:staff_sudo_t:s0 msg='PAM: setcred acct="root"
> : exe="/usr/bin/sudo" (hostname=kvm001.sandbox.pri, addr=1.1.1.100,
> terminal=/dev/pts/1 res=success)'
> type=USER_START msg=audit(1271345951.920:1159791): user pid=9218 uid=0
> auid=502 subj=staff_u:staff_r:staff_sudo_t:s0 msg='PAM: session open
> acct="root" : exe="/usr/bin/sudo" (hostname=kvm001.sandbox.pri,
> addr=1.1.1.100, terminal=/dev/pts/1 res=success)'
> type=USER_END msg=audit(1271345951.927:1159792): user pid=9218 uid=0
> auid=502 subj=staff_u:staff_r:staff_sudo_t:s0 msg='PAM: session close
> acct="root" : exe="/usr/bin/sudo" (hostname=kvm001.sandbox.pri,
> addr=1.1.1.100, terminal=/dev/pts/1 res=success)'
> type=USER_CMD msg=audit(1271345951.930:1159793): user pid=9218 uid=0
> auid=502 subj=staff_u:staff_r:staff_sudo_t:s0 msg='cwd="/home/test"
> cmd=2F7573722F62696E2F61756469742E7368206C657373202F7661722F6C6F672F6D65737361676573
> (terminal=pts/1 res=success)'
> type=USER_AUTH msg=audit(1271345954.273:1159794): user pid=9219 uid=0
> auid=502 subj=staff_u:staff_r:newrole_t:s0 msg='PAM: authentication
> acct="test" : exe="/usr/bin/newrole" (hostname=?, addr=?, terminal=pts/1
> res=success)'
> type=USER_ACCT msg=audit(1271345954.296:1159795): user pid=9219 uid=0
> auid=502 subj=staff_u:staff_r:newrole_t:s0 msg='PAM: accounting acct="test"
> : exe="/usr/bin/newrole" (hostname=?, addr=?, terminal=pts/1 res=success)'
> type=USER_START msg=audit(1271345954.304:1159796): user pid=9223 uid=0
> auid=502 subj=staff_u:staff_r:newrole_t:s0 msg='PAM: session open
> acct="test" : exe="/usr/bin/newrole" (hostname=?, addr=?, terminal=pts/1
> res=success)'
> type=USER_ROLE_CHANGE msg=audit(1271345954.304:1159797): user pid=9223
> uid=0 auid=502 subj=staff_u:staff_r:newrole_t:s0 msg='newrole:
> old-context=staff_u:staff_r:staff_t new-context=staff_u:sysadm_r:sysadm_t:
> exe="/usr/bin/newrole" (hostname=?, addr=?, terminal=/dev/pts/1
> res=success)'
> type=USER_END msg=audit(1271345954.489:1159798): user pid=9219 uid=0
> auid=502 subj=staff_u:staff_r:newrole_t:s0 msg='PAM: session close
> acct="test" : exe="/usr/bin/newrole" (hostname=?, addr=?, terminal=pts/1
> res=success)'
> 
> 
> No AVCs... weird.  Also, I thought the point of having the pam_rootok.so in
> /etc/pam.d/newrole was so that the user wouldn't need to enter their
> password when newrole was run?
> 
> 
> 

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.14 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAkvHUR8ACgkQrlYvE4MpobPPfACcDu08isi68epYlJL+GRzdahun
HO0AmwfmUDEIA1/VGtqdaVQOIP4ZCpWK
=kz+m
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
