Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p8GExZsG023099
	for <selinux@tycho.nsa.gov>; Fri, 16 Sep 2011 10:59:35 -0400
Received: from mx1.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id p8GExXej029505
	for <selinux@tycho.nsa.gov>; Fri, 16 Sep 2011 14:59:34 GMT
Message-ID: <4E736453.8000506@redhat.com>
Date: Fri, 16 Sep 2011 10:59:31 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Justin Mattock <justinmattock@yahoo.com>
CC: tresys <refpolicy@oss1.tresys.com>, SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: [refpolicy] pam_selinux(gdm-password:session): Security Context
 justin:staff_r:insmod_t:s0 Assigned
References: <1316144432.85313.YahooMailNeo@web114304.mail.gq1.yahoo.com>
In-Reply-To: <1316144432.85313.YahooMailNeo@web114304.mail.gq1.yahoo.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 09/15/2011 11:40 PM, Justin Mattock wrote:
> I know this may seem stupid, but why is SELinux PAM transitioning
> me like this?
> 
> Sep 15 20:25:48 Linux-2 pam: gdm-password[957]:
> pam_selinux(gdm-password:session): Open Session Sep 15 20:25:48
> Linux-2 pam: gdm-password[957]: pam_selinux(gdm-password:session):
> Open Session Sep 15 20:25:48 Linux-2 pam: gdm-password[957]:
> pam_selinux(gdm-password:session): Username= justin SELinux User =
> justin Level= s0 Sep 15 20:25:48 Linux-2 pam: gdm-password[957]:
> pam_selinux(gdm-password:session): Security Context
> justin:staff_r:insmod_t:s0 Assigned Sep 15 20:25:48 Linux-2 pam:
> gdm-password[957]: pam_selinux(gdm-password:session): set justin
> security context to justin:staff_r:insmod_t:s0 Sep 15 20:25:48
> Linux-2 pam: gdm-password[957]: pam_selinux(gdm-password:session):
> Key Creation Context justin:staff_r:insmod_t:s0 Assigned Sep 15
> 20:25:48 Linux-2 pam: gdm-password[957]:
> pam_selinux(gdm-password:session): set justin key creation context
> to justin:staff_r:insmod_t:s0 Sep 15 20:25:48 Linux-2 pam:
> gdm-password[957]: pam_unix(gdm-password:session): session opened
> for user justin by (uid=0)
> 
> 
> I have had this in the past with other systems, but a relabel has
> always resolved this., now with using fedora 15 seems I have no
> idea! any ideas on what I may need to check? boolean?
> 
> Justin P. Mattock
> 
> _______________________________________________ refpolicy mailing
> list refpolicy@oss.tresys.com 
> http://oss.tresys.com/mailman/listinfo/refpolicy
What is the context of the login program.

ps -eZ |grep sshd

For example.

The code asks what context to log in justin at based on its current
context.  If the login program has a bizare context like unconfined_t
or initrc_t the code can get confused.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk5zZFMACgkQrlYvE4MpobNmCACfRirK7RP5I1rQPy193KZAapl9
droAoK8wKjd9xgB+p5QSmueukch3ZUha
=1iP6
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
