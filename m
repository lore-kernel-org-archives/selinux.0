Message-ID: <47DE7A05.2010105@redhat.com>
Date: Mon, 17 Mar 2008 10:02:45 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Hasan Rezaul-CHR010 <CHR010@motorola.com>
CC: Stephen Smalley <sds@tycho.nsa.gov>, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: First Attempt at root login on console always FAILS ??
References: <47D9B0DB.90308@redhat.com> <47D9B8BB.2080402@redhat.com> <47D9BBEE.5090105@redhat.com> <1205501760.22912.38.camel@moss-spartans.epoch.ncsc.mil> <47DA9A3C.3080802@redhat.com>  <47DAD18F.5000309@tycho.nsa.gov> <1205525125.22912.96.camel@moss-spartans.epoch.ncsc.mil> <D06FE0A2807BC145B0D38744789D4F5D0472B132@de01exm68.ds.mot.com>
In-Reply-To: <D06FE0A2807BC145B0D38744789D4F5D0472B132@de01exm68.ds.mot.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hasan Rezaul-CHR010 wrote:
> Hi All,
> 
> I am getting an irritating problem on my Linux card (running selinux in
> permissive mode), that I didn't use to see before, and am not sure whats
> causing it :
> 
> When I reset my Linux Card, once it boots up, and I get the login
> prompt, my first attempt at logging in as root on the console, ALWAYS
> fails ! My second attempt and afterwards ALWAYS succeeds !
> 
> unknown host login: root
> password: root
> Login Failure
> unknown host login: root
> Password: root
> root@unknown host#
> 
> 
> 
> This didn't used to happen before, and I am not sure what's causing it.
> I do know that if I disable selinux, the problem goes away !  I am
> guessing the problem is somewhere in between PAM and SELinux. Any
> suggestions on what may be causing it ?  I have versions:
> 
> checkpolicy     1.34.1
> libselinux         1.34.7
> libsemanage     1.10.3
> libsepol            1.16.1
> policycoreutils  1.34.6
> 
> 
> Contents of  /etc/pam.d/login file
> ------------------------------------------------
> 
> # Begin /etc/pam.d/login
> auth        required       pam_tally.so onerr=fail deny=3
> unlock_time=300
> auth        requisite      pam_securetty.so
> auth        requisite      pam_nologin.so
> auth        required       pam_env.so
> auth        required       pam_unix.so
> account     required       pam_tally.so onerr=fail
> account     required       pam_access.so
> account     required       pam_unix.so
> # pam_selinux.so close should be the first session rule
> session     required       pam_selinux.so close
> session     required       pam_loginuid.so
> session     required       pam_motd.so
> session     required       pam_limits.so
> session     optional       pam_mail.so     dir=/var/mail standard
> session     optional       pam_lastlog.so
> session     required       pam_unix.so
> # pam_selinux.so open should only be followed by sessions to be executed
> in the
> user context
> session     required       pam_selinux.so open
> # End /etc/pam.d/login
> 
I would doubt this has anything to do with SELinux, especially when you
are in permissive mode.  Does /var/log/secure show you anything?
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.8 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iEYEARECAAYFAkfeegUACgkQrlYvE4MpobMriACdGK3iBx7qnKdM8m1ilfMo09Dm
cxgAn2oTzMMGj3U7iqv6kKLmiqABFzFA
=rBSn
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
