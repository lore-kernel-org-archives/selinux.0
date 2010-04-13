Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o3DCkC8m031388
	for <selinux@tycho.nsa.gov>; Tue, 13 Apr 2010 08:46:12 -0400
Received: from mx1.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id o3DCl4r0013283
	for <selinux@tycho.nsa.gov>; Tue, 13 Apr 2010 12:47:05 GMT
Message-ID: <4BC4678E.807@redhat.com>
Date: Tue, 13 Apr 2010 08:46:06 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Alan Rouse <alan.rouse@ericsson.com>
CC: SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: AVC accesing shadow during gnome login
References: <5A5E55DF96F73844AF7DFB0F48721F0F52E48FE523@EUSAACMS0703.eamcs.ericsson.se>
In-Reply-To: <5A5E55DF96F73844AF7DFB0F48721F0F52E48FE523@EUSAACMS0703.eamcs.ericsson.se>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 04/12/2010 03:24 PM, Alan Rouse wrote:
> I'm getting the following when I log in via the gnome login gui (OpenSUSE 11.2) with dontaudit turned off:
> 
> type=AVC msg=audit(1271099674.777:3): avc:  denied  { read } for  pid=2475 comm="gdm-session-wor" name="shadow" dev=sda2 ino=129609 scontext=system_u:system_r:xdm_t:s0-s0:c0.c1023 tcontext=system_u:object_r:shadow_t:s0 tclass=file
> type=AVC msg=audit(1271099674.780:4): avc:  denied  { open } for  pid=2475 comm="gdm-session-wor" name="shadow" dev=sda2 ino=129609 scontext=system_u:system_r:xdm_t:s0-s0:c0.c1023 tcontext=system_u:object_r:shadow_t:s0 tclass=file
> type=AVC msg=audit(1271099674.792:5): avc:  denied  { getattr } for  pid=2475 comm="gdm-session-wor" path="/etc/shadow" dev=sda2 ino=129609 scontext=system_u:system_r:xdm_t:s0-s0:c0.c1023 tcontext=system_u:object_r:shadow_t:s0 tclass=file
> 
> But I think the required access is prohibited via 'neverallow'.   Suggestions welcome.
> 
> Thanks
> 
> 
> 
> 

xdm_t uses /sbin/unix_chkpwd to read the shadow file.  The pam stack
will execute this program if it can not read shadow directly.  In Fedora
and RHEL products we now attempt to execute /sbin/unix_chkpwd first and
then fail over to trying to read the shadow file.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.14 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAkvEZ44ACgkQrlYvE4MpobPI9gCfWmdjXO2iYgqrVMbt8mayugYJ
OP0An043xjA72tP9svgx89XBXF3ZTlsI
=Qkji
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
