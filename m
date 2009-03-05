Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n25F1he0014258
	for <selinux@tycho.nsa.gov>; Thu, 5 Mar 2009 10:01:43 -0500
Received: from mx2.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id n25F1gMb008384
	for <selinux@tycho.nsa.gov>; Thu, 5 Mar 2009 15:01:43 GMT
Message-ID: <49AFE945.8000307@redhat.com>
Date: Thu, 05 Mar 2009 10:01:25 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: russell@coker.com.au
CC: SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: PAM, GNOME, etc
References: <200903051749.31665.russell@coker.com.au>
In-Reply-To: <200903051749.31665.russell@coker.com.au>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Russell Coker wrote:
> Currently the gdm package in Debian has some degree of SE Linux support (I 
> haven't yet read the source to see what it does).  However it seems that the 
> pam_selinux.so module is required and that it can't be the last module 
> (previously I just appended a line to the pam configuration).
> 
> session required pam_selinux.so
> session optional        pam_gnome_keyring.so auto_start
> 
> The above is part of my /etc/pam.d/gdm file.  The SE Linux module needs to be 
> run before the pam_gnome_keyring.so module so that the daemon it spawns for 
> the user will get the correct context.
> 
> It seems that we have three broad classes of session modules.  Those which 
> launch no child processes, those which launch system processes (EG automatic 
> home directory creation), and those which launch user processes (such as a 
> GNOME keyring).
> 
> Dan, what are you guys doing in Fedora in this regard?  Are you integrating SE 
> Linux support manually in every pam.d file to make sure you get it right?  It 
> seems that any automatic method (such as just appending a line to every one 
> of a set of files) is not going to work.
> 
> Or have you patched a bunch of PAM modules to call setexeccon(NULL) before 
> they call exec()?
> 
No we have the pam modules written pretty well.  No patching. And we are
trying to get rid of all pam modules that exec system processes.

pam_oddjob_mkhomedir instead of pam_mkhomedir. consolekit/dbus/policykit
instead of pam_console.

pam modules doing extremely privileged apps is always a problem.
pam_mount for example.  pam_namespace.

I believe system-config-auth and the defaults all work in Fedora.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iEYEARECAAYFAkmv6UUACgkQrlYvE4MpobMiIgCg0cAAhkbsIRVegfvU4qZac5+2
dF0AoOF737Dp2gev+MpJVJL4V12U7UoM
=t2qk
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
