Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o3METf1g020162
	for <selinux@tycho.nsa.gov>; Thu, 22 Apr 2010 10:29:41 -0400
Received: from mail-gw0-f53.google.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id o3MEUeLM010175
	for <selinux@tycho.nsa.gov>; Thu, 22 Apr 2010 14:30:40 GMT
Received: by gwj21 with SMTP id 21so2659724gwj.12
        for <selinux@tycho.nsa.gov>; Thu, 22 Apr 2010 07:29:40 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4BD0513C.40403@redhat.com>
References: <4BCC69C0.5040502@redhat.com>
	 <t2s10143821004190853r1a114b33q7c9416e43b8b5433@mail.gmail.com>
	 <l2s10143821004200737t683832efu28214c95b3e156c@mail.gmail.com>
	 <4BCF05D3.5090700@redhat.com>
	 <u2q10143821004211853jea20406bz355fc111cd449c47@mail.gmail.com>
	 <4BD0513C.40403@redhat.com>
Date: Thu, 22 Apr 2010 10:29:40 -0400
Message-ID: <q2s10143821004220729z2e39b1fdqe16997df0cee0574@mail.gmail.com>
Subject: Re: refpolicy is missing on lots of hits with audit2allow -R.
From: Karl MacMillan <kmacmillan@tresys.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SELinux <selinux@tycho.nsa.gov>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, Apr 22, 2010 at 9:38 AM, Daniel J Walsh <dwalsh@redhat.com> wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
>
> I have not fully examined this patch but I don't believe it will do what
> I need.
>
> If I define an interface that ends up looking like this:
>
>
> [InterfaceVector files_read_etc_files $1:source ]
> $1,configfile,dir,ioctl,search,read,lock,open,getattr
> $1,configfile,file,read,lock,getattr,open,ioctl
> $1,configfile,lnk_file,read,getattr
>
>
> And have and avc that looks like this:
>
> node=(removed) type=AVC msg=audit(1271587735.632:422): avc:  denied  {
> getattr } for  pid=13239 comm="openvpn"
> path="/home/bbaetz/.pki/vpn01_cacert.pem" dev=dm-3 ino=565334
> scontext=system_u:system_r:openvpn_t:s0
> tcontext=unconfined_u:object_r:etc_t:s0 tclass=file
>
>
> This will never match.
>
> What we need is a way to expand out configfile into etc_t, or to realize
> that etc_t is a configfile.
>
> The tool you added does not do the equivalent of
>
> seinfo -aconfigfile -x

No, it doesn't do that yet, but I'll get to that soon. Now that I have
the infrastructure for digging through the binary policy for attribute
information it won't be too hard.

Karl

> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v2.0.14 (GNU/Linux)
> Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/
>
> iEYEARECAAYFAkvQUTwACgkQrlYvE4MpobMfWwCfbg6t/396jHWHCpasqosqf8Mw
> 7qkAoNiXMi8+RK5/4mBu8WbnGLvxlb7+
> =EDEY
> -----END PGP SIGNATURE-----
>
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
>


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
