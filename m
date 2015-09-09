Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t89Ixaw2028777
 for <selinux@tycho.nsa.gov>; Wed, 9 Sep 2015 14:59:36 -0400
Received: by wicfx3 with SMTP id fx3so32514041wic.0
 for <selinux@tycho.nsa.gov>; Wed, 09 Sep 2015 11:59:05 -0700 (PDT)
Date: Wed, 9 Sep 2015 20:59:02 +0200
From: Dominick Grift <dac.override@gmail.com>
To: Divya Vyas <dvyas@mvista.com>
Cc: selinux <selinux@tycho.nsa.gov>
Subject: Re: No http boolean
Message-ID: <20150909185901.GB22288@x250>
References: <CA+=dQ-_UrusjCYEvonfGxs3czxRWiV6iEm6Mk929iOL24UMzTg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; x-action=pgp-signed
In-Reply-To: <CA+=dQ-_UrusjCYEvonfGxs3czxRWiV6iEm6Mk929iOL24UMzTg@mail.gmail.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

On Wed, Sep 09, 2015 at 05:33:51PM +0530, Divya Vyas wrote:
> Hi,
> 
> I am running selinux on my ubuntu machine and wants apache server
> restriction to /etc/passwd.
> 
> I am just trying to play with http booleans to allow rules:
> 
> setsebool -P httpd_enable_homedirs on
> libsemanage.dbase_llist_set: record not found in the database (No such file
> or directory).
> libsemanage.dbase_llist_set: could not set record value (No such file or
> directory).
> Could not change boolean httpd_enable_homedirs
> Could not change policy booleans
> 
> getsebool -a | grep http
> no result
> 
> 
> dpkg -l | grep selinux
> ii  libselinux1
> 2.1.0-4.1ubuntu1                    SELinux runtime shared libraries
> ii  python-selinux
> 2.1.0-4.1ubuntu1                    Python bindings to SELinux shared
> libraries
> ii  selinux
> 1:0.11                              Security-Enhanced Linux runtime support
> ii  selinux-policy-dev
> 2:2.20110726-3                      Headers from the SELinux reference
> policy for building modules
> ii  selinux-policy-ubuntu
> 0.2.20091117-0ubuntu2               Security-Enhanced Linux Reference Policy
> ii  selinux-utils
> 2.1.0-4.1ubuntu1                    SELinux utility programs
> 
> 
> semoule -l | grep apache
> no result
> 
>  From where I can get  http booleans?

Your distribution provided selinux security policy configuration does not appear to
have that boolean configuration. Either you configure it yourself or
you are your selinux-policy distribution maintainer to implement it for you.

information on how to configure your selinux can be found here:

http://selinuxproject.org/page/AdvancedUsers

> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to Selinux-request@tycho.nsa.gov.


- -- 
02DFF788
4D30 903A 1CF3 B756 FB48  1514 3148 83A2 02DF F788
https://sks-keyservers.net/pks/lookup?op=get&search=0x314883A202DFF788
Dominick Grift
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQGcBAEBCgAGBQJV8IFxAAoJENAR6kfG5xmcbqcL/01NmlPC3m/xOmVqi5mLbinX
sAMtIy/bFt+KhgeD58HDCRIrQi7tanPl3KUIcBDawGKSb5hnIrViYHQqG2a7VcKG
+twt4x0ZWuXiBeZ3YNTIrrFgKj0Z58Kbr32vC06xZMnsFfHdyBn8V5yVW+UHkoa4
3JSExaTVJ9XQKyX8/ymDczsSg3AEvqN9lQRRGqC5Pvcdl/yKrOdVE9QBeauUfG9B
/ZV7Z1VB+FsAqDQQUmCklrGcaRu43ln4lT9YNEtcWafZ7DsbIepip4FBLFGueseH
XT+aoEpKwhsSrAV0E6n2dvDoISxqe54ue8ob3kBW35yYD3zstMKnBWBZVCVYgo8+
lB2qVUCiSpWi5ZeB71dqS7fdESqKWgiyY48J1FlGeAfJvtXJyZ/bStuZpnJxrxMy
RXp5FdNbsklp1RarclPYiQZf6ax3qEJZ+0k4L8W9ojcYK4sbnx8EPOQk2XTYcaTq
NbxGw6+TrrARJr9Iv2YGFqlH4ic14dvf0cEL9x0+eQ==
=lV5p
-----END PGP SIGNATURE-----
