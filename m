Message-ID: <417D20F6.1080607@gentoo.org>
Date: Mon, 25 Oct 2004 18:51:18 +0300
From: petre rodan <kaiowas@gentoo.org>
MIME-Version: 1.0
To: Park Lee <parklee_sel@yahoo.com>
CC: sds@epoch.ncsc.mil, SELinux@tycho.nsa.gov, rusinskystanislas@yahoo.fr
Subject: Re: SELinux with IPSec - something going on ?
References: <20041024093014.14853.qmail@web51506.mail.yahoo.com>
In-Reply-To: <20041024093014.14853.qmail@web51506.mail.yahoo.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig9AC0251582368AB7AD20F4A5"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig9AC0251582368AB7AD20F4A5
Content-Type: multipart/mixed;
 boundary="------------000700010104090508070007"

This is a multi-part message in MIME format.
--------------000700010104090508070007
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit


Hi,

here is a fresh ipsec-tools [1] policy made for gentoo.
works flawlessly with my setup [2] (the doc is work in progress).

[1] http://ipsec-tools.sourceforge.net/
[2] http://dev.gentoo.org/~kaiowas/doc/wifi_ipsec-howto.html

is this usable for any of you?

bye,
peter

Park Lee wrote:
> On 2003-11-17 at 14:37 Stephen Smalley wrote:
>  
>  >We have not done any work on integrating SELinux with IPSEC yet;
>  >at this point, such work would presumably be done based on the new
>  >Linux 2.6 IPSEC implementation.
>  
> Now, 11 months have passed, has any work been made to integrate IPSec 
> with SELinux?
> I also want to see if there is something I can do with it.
>  
> Thanks.
> 

--
petre rodan
<kaiowas@gentoo.org>
Developer,
Hardened Gentoo Linux

--------------000700010104090508070007
Content-Type: text/plain;
 name="racoon.fc"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="racoon.fc"


/etc/ipsec\.conf	--	system_u:object_r:setkey_conf_file_t
/etc/racoon(/.*)?		system_u:object_r:racoon_conf_file_t
/etc/racoon/certs(/.*)?		system_u:object_r:racoon_key_file_t
/etc/racoon/psk\.txt	--	system_u:object_r:racoon_key_file_t

/usr/sbin/racoon	--	system_u:object_r:racoon_exec_t
/usr/sbin/setkey	--	system_u:object_r:setkey_exec_t

/var/run/pluto\.ctl	-s	system_u:object_r:racoon_var_run_t
/var/run/racoon\.pid	--	system_u:object_r:racoon_var_run_t

--------------000700010104090508070007
Content-Type: text/plain;
 name="racoon.te"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="racoon.te"

#DESC ipsec-tools
#
# Author: petre rodan <kaiowas@gentoo.org>


daemon_base_domain(racoon, `, privlog')

type racoon_conf_file_t, file_type, sysadmfile;
type racoon_key_file_t, file_type, sysadmfile;

var_run_domain(racoon)
read_locale(racoon_t)
can_network(racoon_t)

allow racoon_t self:capability { net_admin net_bind_service };

r_dir_file(racoon_t, racoon_conf_file_t)
r_dir_file(racoon_t, racoon_key_file_t)


daemon_domain(setkey)

type setkey_conf_file_t, file_type, sysadmfile;


define(`setkey_domain', `

uses_shlib($1_t)
read_locale($1_t)

allow $1_t self:capability { net_admin };
allow $1_t setkey_conf_file_t:file r_file_perms;

') dnl end setkey_domain


define(`setkey_userdomain', `

# derived domain based on the calling user domain
type $1_setkey_t, domain;

domain_auto_trans($1_t, setkey_exec_t, $1_setkey_t)
role $1_r types $1_setkey_t;

setkey_domain($1_setkey)

# this is why there is a setkey_userdomain :)
allow $1_setkey_t { $1_tty_device_t $1_devpts_t }:chr_file { getattr read write };
allow $1_setkey_t privfd:fd use;
') dnl end setkey_userdomain


# one for initrc
setkey_domain(setkey)

# and one for sysadm
setkey_userdomain(sysadm)

--------------000700010104090508070007--

--------------enig9AC0251582368AB7AD20F4A5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFBfSD7GSBEIeh4AEYRAqYPAJ9s6GaN1p70TV4rAJUbGPs3LtuzJwCffvZU
7DCJrOAfE6o9OrRZZ3He1z0=
=dP4Y
-----END PGP SIGNATURE-----

--------------enig9AC0251582368AB7AD20F4A5--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
