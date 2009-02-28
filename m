Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n1SCdZfJ009579
	for <selinux@tycho.nsa.gov>; Sat, 28 Feb 2009 07:39:35 -0500
Received: from ey-out-1920.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id n1SCdYv6019775
	for <selinux@tycho.nsa.gov>; Sat, 28 Feb 2009 12:39:34 GMT
Received: by ey-out-1920.google.com with SMTP id 5so352480eyb.30
        for <selinux@tycho.nsa.gov>; Sat, 28 Feb 2009 04:39:33 -0800 (PST)
Subject: Re: Patch to libsemanage to remove labeling of /root
From: Dominick Grift <domg472@gmail.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: russell@coker.com.au, SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <49A92E31.8040608@redhat.com>
References: <496C9A96.1080805@redhat.com>
	 <200902271322.18928.russell@coker.com.au> <49A8646A.5050604@redhat.com>
	 <200902281001.27831.russell@coker.com.au>
	 <1235822979.11365.16.camel@notebook1.grift.internal>
	 <49A92E31.8040608@redhat.com>
Content-Type: text/plain
Date: Sat, 28 Feb 2009 13:39:31 +0100
Message-Id: <1235824771.11365.17.camel@notebook1.grift.internal>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 2009-02-28 at 07:29 -0500, Daniel J Walsh wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Dominick Grift wrote:
> > On Sat, 2009-02-28 at 10:01 +1100, Russell Coker wrote:
> >> On Sat, 28 Feb 2009, Daniel J Walsh <dwalsh@redhat.com> wrote:
> >>>> We should not be allowing confined daemons to write to /root.
> >>> There is potential to allow confine domains to write to subdirs of
> >>> /root. or at least read it.
> >>>
> >>> sshd_t needs to be able to read /root/.ssh/*
> >> Well if you have the boolean set to allow sysadm_t logins then sshd can 
> >> entirely break your security anyway.
> > 
> > A bit offtopic but on Fedora that boolean does not seem to work
> > (completely):
> > 
> > sh-4.0# getsebool -a | grep sysadm
> > allow_sysadm_exec_content --> on
> > ssh_sysadm_login --> off
> > xdm_sysadm_login --> off
> > 
> > [dgrift@notebook1 ~]$ ssh dgrift/sysadm_r@localhost
> > WARNING!!! You have accessed a private network.
> > UNAUTHORIZED ACCESS IS PROHIBITED BY LAW
> > Violators may be prosecuted to the full extend of the law.
> > Your access to this network may be monitored and recorded for quality
> > assurance, security, performance, and maintenance purposes.
> > dgrift/sysadm_r@localhost's password: 
> > Last login: Fri Feb 27 13:35:33 2009 from localhost.localdomain
> > [dgrift@notebook1 ~]$ id -Z
> > dgrift:sysadm_r:sysadm_t:SystemLow-SystemHigh
> > [dgrift@notebook1 ~]$ 
> > 
> >>> Others like xauth_t need to be able to write but this is more a confined
> >>> helper app then a real confined app.
> >>>
> >>> In current targeted policy I see the following
> >>>
> >>> # sesearch --allow -t admin_home_t  -c dir | grep write | awk '{ print
> >>> $2 " " $3 }'
> >>> sysadm_t admin_home_t
> >>> rpm_t admin_home_t
> >>> rpm_script_t admin_home_t
> >>> xauth_t admin_home_t
> >>> nfsd_t admin_home_t
> >>> nmbd_t admin_home_t
> >>> smbd_t admin_home_t
> >>> ftpd_t admin_home_t
> >>> kernel_t admin_home_t
> >>>
> >>> Where these are either an unconfined_domain or have a boolean that
> >>> allows them to write anywhere.
> >> Those cases all have genuine reasons for accessing /root (at least in certain 
> >> configurations based on boolean settings).
> >>
> >> I recall that at one time the RHGB used to write files under /root because the 
> >> library code was too complex to allow them to do otherwise.  While RHGB was 
> >> unlikely to break your system, other programs with similar design would be a 
> >> risk.
> >>
> > 
> > 
> > --
> > This message was distributed to subscribers of the selinux mailing list.
> > If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> > the words "unsubscribe selinux" without quotes as the message.
> Dominick can you open a bugzilla.

Sure: https://bugzilla.redhat.com/show_bug.cgi?id=487860

> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.4.9 (GNU/Linux)
> Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org
> 
> iEYEARECAAYFAkmpLjAACgkQrlYvE4MpobPwiQCgm2+ElFC98W7KnYtysngi4Wih
> P3EAn3wwB11nR7pOpBz3Q98nThrncBvS
> =5ADb
> -----END PGP SIGNATURE-----


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
