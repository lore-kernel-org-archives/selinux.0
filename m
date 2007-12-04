Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id lB4ECpVG016908
	for <selinux@tycho.nsa.gov>; Tue, 4 Dec 2007 09:12:51 -0500
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id lB4ECoNt013616
	for <selinux@tycho.nsa.gov>; Tue, 4 Dec 2007 14:12:50 GMT
Message-ID: <47556017.1040703@redhat.com>
Date: Tue, 04 Dec 2007 09:11:35 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Shintaro Fujiwara <shintaro.fujiwara@gmail.com>
CC: selinux <selinux@tycho.nsa.gov>
Subject: Re: libsepol.expand_terule_helper: duplicate TE rule
References: <f71a82820712010015yafc65dfm21d3f21fbb264008@mail.gmail.com>
In-Reply-To: <f71a82820712010015yafc65dfm21d3f21fbb264008@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Shintaro Fujiwara wrote:
> When I try to install apache.pp,
> 
> libsepol.expand_terule_helper: duplicate TE rule for httpd_t
> exim_exec_t:process system_mail_t
> libsepol.expand_module: Error during expand
> libsemanage.semanage_expand_sandbox: Expand module failed
> semodule:  Failed!
> 
> I can't find any lines concerning exim_exec_t anywhere...
> Please help.
> 
> 
in mta.if,

mta_send_mail has the following


	domtrans_pattern($1, mailclient_exec_type, system_mail_t)
	allow system_mail_t mailclient_exec_type:file entrypoint;


And

interface(`mta_mailclient',`
	gen_require(`
		attribute mailclient_exec_type;
	')

	typeattribute $1 mailclient_exec_type;
')


In exim.te

mta_mailclient(exim_exec_t)
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFHVWAXrlYvE4MpobMRAsGsAJ9yGCZ4fMMuLn8FIf5V7IdOIjcYVgCeJVwo
45S6MoKx9nAW6430eJiaJNY=
=L/mO
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
