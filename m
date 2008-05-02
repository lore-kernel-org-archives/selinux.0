Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m42FjPok006539
	for <selinux@tycho.nsa.gov>; Fri, 2 May 2008 11:45:25 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m42FjMJ3025843
	for <selinux@tycho.nsa.gov>; Fri, 2 May 2008 15:45:23 GMT
Message-ID: <481B2E15.7070703@redhat.com>
Date: Fri, 02 May 2008 11:07:01 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: =?ISO-8859-1?Q?V=E1clav_Ovs=EDk?= <vaclav.ovsik@i.cz>
CC: selinux@tycho.nsa.gov, selinux-devel@lists.alioth.debian.org,
        debian-ssh@lists.debian.org
Subject: Re: [refpolicy] initrc_t access to sshd /proc to adjust OOM killer
References: <20080502143041.GA26592@bobek.pm.i.cz>
In-Reply-To: <20080502143041.GA26592@bobek.pm.i.cz>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Václav Ovsík wrote:
> Hi,
> the startup script of Open SSH server on the Debian Sid adjusts the OOM
> killer to not kill sshd in the condition of OOM. It simply does
> 
>     printf '%s' "$SSHD_OOM_ADJUST" >"/proc/$PID/oom_adj" || true
> 
> BTW: I am not certain if this do exactly what was intended, because this
> parameter is inherited by all child processes, as one can see using
> attached simple script.
> 
> Nevertheless I don't know how to enable such write under SE Linux. It
> triggers:
> 
> [   66.417499] type=1400 audit(1209737438.955:6): avc:  denied  { write
> } for  pid=1600 comm="S16ssh" name="oom_adj" dev=proc ino=70952 s
> context=system_u:system_r:initrc_t:s0
> tcontext=system_u:system_r:sshd_t:s0-s0:c0.c1023 tclass=file
> 
> I wrote attached patch, but the denial still appears.
> 
> sid:~# sesearch --allow -s initrc_t  -t sshd_t -c file 
> WARNING: This policy contained disabled aliases; they have been removed.
> Found 3 semantic av rules:
>    allow @ttr1634 @ttr2356 : file { ioctl read getattr lock }; 
>    allow initrc_t sshd_t : file { ioctl write getattr lock append }; 
>    allow initrc_t @ttr2356 : file { ioctl read getattr lock }; 
> 
> sid:~# sestatus   
> SELinux status:                 enabled
> SELinuxfs mount:                /selinux
> Current mode:                   permissive
> Mode from config file:          permissive
> Policy version:                 22
> Policy from config file:        refpolicy
> sid:~# uname -a
> Linux sid 2.6.25-1-686 #1 SMP Mon Apr 28 13:54:58 UTC 2008 i686 GNU/Linux
> 
> What am I doing wrong please?
> Best Regards
> 
Run the avc messages through audit2why
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iEYEARECAAYFAkgbLhQACgkQrlYvE4MpobPWYgCeJk1o6mgpEESA92OMKdB1/cDh
SagAn3IXRfQ36jry/E6UB6K2c/rZf1G3
=y3Lj
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
