Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o3KEkTQR028628
	for <selinux@tycho.nsa.gov>; Tue, 20 Apr 2010 10:46:34 -0400
Received: from mx1.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id o3KEk1Ya019035
	for <selinux@tycho.nsa.gov>; Tue, 20 Apr 2010 14:46:02 GMT
Message-ID: <4BCDBE46.5060507@redhat.com>
Date: Tue, 20 Apr 2010 10:46:30 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Karl MacMillan <kmacmillan@tresys.com>, SELinux <selinux@tycho.nsa.gov>
Subject: Re: refpolicy is missing on lots of hits with audit2allow -R.
References: <4BCC69C0.5040502@redhat.com>
In-Reply-To: <4BCC69C0.5040502@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 04/19/2010 10:33 AM, Daniel J Walsh wrote:
> The reason for this is threshold, setting.  I think the interfaces are
> getting more complicated and one AVC that is looking for read ends up
> being two far different from the threshold, so audit2allow does not
> report it.
> 
> For example.
> 
> node=(removed) type=AVC msg=audit(1271587735.632:422): avc:  denied  {
> getattr } for  pid=13239 comm="openvpn"
> path="/home/bbaetz/.pki/vpn01_cacert.pem" dev=dm-3 ino=565334
> scontext=system_u:system_r:openvpn_t:s0
> tcontext=unconfined_u:object_r:home_cert_t:s0 tclass=file
> 
> node=(removed) type=SYSCALL msg=audit(1271587735.632:422): arch=c000003e
> syscall=5 success=yes exit=0 a0=6 a1=7fffd84f4a20 a2=7fffd84f4a20 a3=18
> items=0 ppid=13235 pid=13239 auid=4294967295 uid=0 gid=0 euid=0 suid=0
> fsuid=0 egid=0 sgid=0 fsgid=0 tty=(none) ses=4294967295 comm="openvpn"
> exe="/usr/sbin/openvpn" subj=system_u:system_r:openvpn_t:s0 key=(null)
> 
> Finds userdom_read_home_certs but it's threshold is two far off, so it
> reports nothing.
> 
> I think we should either eliminate the threshold and report the best
> interface that we have, and let the policy writer decide if he wants the
> match.
> 
> If you look at the interface userdom_read_home_certs.
> 
> [InterfaceVector userdom_read_home_certs $1:source ]
> $1,home_cert_t,file,read,lock,getattr,open,ioctl
> $1,home_cert_t,dir,ioctl,search,read,lock,open,getattr
> $1,home_cert_t,lnk_file,read,getattr
> $1,home_root_t,dir,getattr,open,search
> $1,home_root_t,lnk_file,read,getattr
> $1,user_home_dir_t,dir,getattr,open,search
> $1,user_home_dir_t,lnk_file,read,getattr
> 
> A domain that is allowed to search the homedir is always going to
> generate an AVC that is a long way off.
> 
> I thing we should either remove the bastards and just add all as childs,
> or recode it like the attachment.
> 
I tried that but we got down to,

#   userdom_read_home_certs(openvpn_t) # [283]

Which is still way higher then 120.

Isn't the problem that openvpn_t has

1# sesearch -A -s openvpn_t -t home_root_t
Found 2 semantic av rules:
   allow openvpn_t home_root_t : dir { getattr search open } ;
   allow openvpn_t home_root_t : lnk_file { read getattr } ;

- -bash-4.1# sesearch -A -s openvpn_t -t user_home_dir_t
Found 1 semantic av rules:
   allow openvpn_t user_home_dir_t : dir { ioctl read getattr lock
search open } ;


But these count towards the total?

Should we be checking in the policy what access is already present in
the domain, to make a better decision.  Or would this end up taking to long.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.14 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAkvNvkYACgkQrlYvE4MpobPVGQCfZEeAd1f7424uWXrJGbiUDyPZ
Z5UAn1k60lKjKJxZtq5d6ON51iKMvda2
=2SYZ
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
