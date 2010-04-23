Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o3NF9xAj031330
	for <selinux@tycho.nsa.gov>; Fri, 23 Apr 2010 11:10:01 -0400
Received: from mx1.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id o3NFAxJi003988
	for <selinux@tycho.nsa.gov>; Fri, 23 Apr 2010 15:10:59 GMT
Message-ID: <4BD1B843.1030805@redhat.com>
Date: Fri, 23 Apr 2010 11:09:55 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Karl MacMillan <kmacmillan@tresys.com>
CC: SELinux <selinux@tycho.nsa.gov>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>
Subject: Re: refpolicy is missing on lots of hits with audit2allow -R.
References: <4BCC69C0.5040502@redhat.com>	 <t2s10143821004190853r1a114b33q7c9416e43b8b5433@mail.gmail.com>	 <l2s10143821004200737t683832efu28214c95b3e156c@mail.gmail.com>	 <4BCF05D3.5090700@redhat.com>	 <u2q10143821004211853jea20406bz355fc111cd449c47@mail.gmail.com>	 <4BD0513C.40403@redhat.com>	 <q2s10143821004220729z2e39b1fdqe16997df0cee0574@mail.gmail.com> <w2q10143821004221216j96faf709w8b702c67835197d6@mail.gmail.com>
In-Reply-To: <w2q10143821004221216j96faf709w8b702c67835197d6@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

I do not totally understand your matching, but I thought if you looked for

allow TYPE etc_t:file getattr;

You could get extra matches.

I was thinking in terms of sepolgen-ifgen would take every type and
expand the attributes for the type then if you find attribute that
matches, not add weight.

seinfo -tetc_t -x
   etc_t
      file_type
      non_security_file_type
      configfile

If my target was etc_t then I would get the same weight as if I
substituted the attrbute with etc_t.



[InterfaceVector files_read_etc_files $1:source ]
$1,etc_t,file,read,lock,getattr,open,ioctl
$1,etc_t,dir,ioctl,search,read,lock,open,getattr
$1,etc_t,lnk_file,read,getattr
$1,configfile,dir,ioctl,search,read,lock,open,getattr
$1,configfile,file,read,lock,getattr,open,ioctl
$1,configfile,lnk_file,read,getattr

Would get translated at

[InterfaceVector files_read_etc_files $1:source ]
$1,etc_t,file,read,lock,getattr,open,ioctl
$1,etc_t,dir,ioctl,search,read,lock,open,getattr
$1,etc_t,lnk_file,read,getattr
$1,etc_t,dir,ioctl,search,read,lock,open,getattr
$1,etc_t,file,read,lock,getattr,open,ioctl
$1,etc_t,lnk_file,read,getattr

If I am looking for a target of etc_t

Which would then get boiled down to.

[InterfaceVector files_read_etc_files $1:source ]
$1,etc_t,file,read,lock,getattr,open,ioctl
$1,etc_t,dir,ioctl,search,read,lock,open,getattr
$1,etc_t,lnk_file,read,getattr


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.14 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAkvRuEMACgkQrlYvE4MpobPKzwCg3T0NUD5u1dQV6DmFHmPd22V1
uqYAnj/ytX750LXS6Um5izsloK4jhO7w
=oSpR
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
