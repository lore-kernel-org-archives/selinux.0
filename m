Message-ID: <47D1AEB2.2000209@redhat.com>
Date: Fri, 07 Mar 2008 16:08:02 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
CC: Stephen Smalley <sds@tycho.nsa.gov>, jwcart2@tycho.nsa.gov,
        SELinux <selinux@tycho.nsa.gov>
Subject: Re: [PATCH 1/1] refpolicy: Do not want to transition to sysadm_t
 when upstart runs a shell
References: <1204837907.13547.36.camel@moss-lions.epoch.ncsc.mil>	 <1204838797.1397.378.camel@moss-spartans.epoch.ncsc.mil>	 <47D065E2.3000702@redhat.com> <1204916629.20251.44.camel@gorn.columbia.tresys.com>
In-Reply-To: <1204916629.20251.44.camel@gorn.columbia.tresys.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Christopher J. PeBenito wrote:
> On Thu, 2008-03-06 at 16:45 -0500, Daniel J Walsh wrote:
>> Stephen Smalley wrote:
>>> On Thu, 2008-03-06 at 16:11 -0500, James Carter wrote:
>>>> Upstart spawns a shell during boot and, without this patch, it will
>>>> transition to the sysadm_t domain, but remain in the system_r role.
>>>> Services started by that shell will fail to start, even in permissive
>>>> mode, if system_u:system_r:sysadm_someservice_t is an invalid context.
>>>> We really don't want to be starting services from the sysadm_t domain
>>>> during boot.
>> So it should probably transition to initrc_t, so apps started this way
>> would have a chance of transitioning properly.
> 
> No, the shell will execute /etc/rc.d/rc to start processing the init
> scripts, and thats when it'll transition to initrc_t.  If we do it on
> shell execution, it may cause problems for things executed directly out
> of init, like getty.
> 
Ok corecmd_exec_shell then.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.8 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iEYEARECAAYFAkfRrq8ACgkQrlYvE4MpobPtnQCgohT2MZsmSBR4xqflB2UPLTw1
mm0AoJV1PFk+ZAHiI+EPCG0jPAEqO2pL
=G+EA
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
