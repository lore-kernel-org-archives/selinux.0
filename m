Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n1RN1cjA023730
	for <selinux@tycho.nsa.gov>; Fri, 27 Feb 2009 18:01:38 -0500
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id n1RN1Xxc027045
	for <selinux@tycho.nsa.gov>; Fri, 27 Feb 2009 23:01:34 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Daniel J Walsh <dwalsh@redhat.com>
Subject: Re: Patch to libsemanage to remove labeling of /root
Date: Sat, 28 Feb 2009 10:01:22 +1100
Cc: SE Linux <selinux@tycho.nsa.gov>
References: <496C9A96.1080805@redhat.com> <200902271322.18928.russell@coker.com.au> <49A8646A.5050604@redhat.com>
In-Reply-To: <49A8646A.5050604@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200902281001.27831.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 28 Feb 2009, Daniel J Walsh <dwalsh@redhat.com> wrote:
> > We should not be allowing confined daemons to write to /root.
>
> There is potential to allow confine domains to write to subdirs of
> /root. or at least read it.
>
> sshd_t needs to be able to read /root/.ssh/*

Well if you have the boolean set to allow sysadm_t logins then sshd can 
entirely break your security anyway.

> Others like xauth_t need to be able to write but this is more a confined
> helper app then a real confined app.
>
> In current targeted policy I see the following
>
> # sesearch --allow -t admin_home_t  -c dir | grep write | awk '{ print
> $2 " " $3 }'
> sysadm_t admin_home_t
> rpm_t admin_home_t
> rpm_script_t admin_home_t
> xauth_t admin_home_t
> nfsd_t admin_home_t
> nmbd_t admin_home_t
> smbd_t admin_home_t
> ftpd_t admin_home_t
> kernel_t admin_home_t
>
> Where these are either an unconfined_domain or have a boolean that
> allows them to write anywhere.

Those cases all have genuine reasons for accessing /root (at least in certain 
configurations based on boolean settings).

I recall that at one time the RHGB used to write files under /root because the 
library code was too complex to allow them to do otherwise.  While RHGB was 
unlikely to break your system, other programs with similar design would be a 
risk.

-- 
russell@coker.com.au
http://etbe.coker.com.au/          My Main Blog
http://doc.coker.com.au/           My Documents Blog

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
