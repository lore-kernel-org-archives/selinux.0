Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n1SCI7sO005711
	for <selinux@tycho.nsa.gov>; Sat, 28 Feb 2009 07:18:07 -0500
Received: from mx2.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id n1SCI6v6015175
	for <selinux@tycho.nsa.gov>; Sat, 28 Feb 2009 12:18:06 GMT
Message-ID: <49A92B6D.9020501@redhat.com>
Date: Sat, 28 Feb 2009 07:17:49 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: russell@coker.com.au
CC: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: Patch to libsemanage to remove labeling of /root
References: <496C9A96.1080805@redhat.com> <200902271322.18928.russell@coker.com.au> <49A8646A.5050604@redhat.com> <200902281001.27831.russell@coker.com.au>
In-Reply-To: <200902281001.27831.russell@coker.com.au>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Russell Coker wrote:
> On Sat, 28 Feb 2009, Daniel J Walsh <dwalsh@redhat.com> wrote:
>>> We should not be allowing confined daemons to write to /root.
>> There is potential to allow confine domains to write to subdirs of
>> /root. or at least read it.
>>
>> sshd_t needs to be able to read /root/.ssh/*
> 
> Well if you have the boolean set to allow sysadm_t logins then sshd can 
> entirely break your security anyway.
>
Well that is one case, but the far more common case is ssh into root as
unconfined_t which is also valid.

Confinement of sshd is not necessarily full proof, since if someone gets
full control they can potentially grab passwords or transition to
unocnfined_t or sysadm_t as you say.  But sshd has been partially
subvirted in the past to allow download of files without even breaking
though password control or getting full control of the daemon.

>> Others like xauth_t need to be able to write but this is more a confined
>> helper app then a real confined app.
>>
>> In current targeted policy I see the following
>>
>> # sesearch --allow -t admin_home_t  -c dir | grep write | awk '{ print
>> $2 " " $3 }'
>> sysadm_t admin_home_t
>> rpm_t admin_home_t
>> rpm_script_t admin_home_t
>> xauth_t admin_home_t
>> nfsd_t admin_home_t
>> nmbd_t admin_home_t
>> smbd_t admin_home_t
>> ftpd_t admin_home_t
>> kernel_t admin_home_t
>>
>> Where these are either an unconfined_domain or have a boolean that
>> allows them to write anywhere.
> 
> Those cases all have genuine reasons for accessing /root (at least in certain 
> configurations based on boolean settings).
> 
> I recall that at one time the RHGB used to write files under /root because the 
> library code was too complex to allow them to do otherwise.  While RHGB was 
> unlikely to break your system, other programs with similar design would be a 
> risk.
> 

Yes we see lots of code that wants to treat /root has a homedir.  But
most we can deny getattr support and that solves the problem.  But
allowing the context to vary depending on genhomedircon is what makes
the policy complicated.  Which is why we wrote the patch in the first place.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iEYEARECAAYFAkmpK2MACgkQrlYvE4MpobPvvwCgkDTHd0sBUMMzgz3zcvuFtc37
Dg4An1obZexWmdbWDKKcUcpsjgtv1bc+
=d9pd
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
