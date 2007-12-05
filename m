Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id lB53bg68030762
	for <selinux@tycho.nsa.gov>; Tue, 4 Dec 2007 22:37:43 -0500
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id lB53bgDc028824
	for <selinux@tycho.nsa.gov>; Wed, 5 Dec 2007 03:37:42 GMT
Message-ID: <47561D02.4050800@redhat.com>
Date: Tue, 04 Dec 2007 22:37:38 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Shintaro Fujiwara <shintaro.fujiwara@gmail.com>
CC: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        selinux <selinux@tycho.nsa.gov>
Subject: Re: libsepol.expand_terule_helper: duplicate TE rule
References: <f71a82820712010015yafc65dfm21d3f21fbb264008@mail.gmail.com>	 <47556017.1040703@redhat.com> <f71a82820712041345v7a1bdbf2mbc4201ae42fb83ff@mail.gmail.com>
In-Reply-To: <f71a82820712041345v7a1bdbf2mbc4201ae42fb83ff@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Shintaro Fujiwara wrote:
> 2007/12/4, Daniel J Walsh <dwalsh@redhat.com>:
> Shintaro Fujiwara wrote:
>>>> When I try to install apache.pp,
>>>>
>>>> libsepol.expand_terule_helper: duplicate TE rule for httpd_t
>>>> exim_exec_t:process system_mail_t
>>>> libsepol.expand_module: Error during expand
>>>> libsemanage.semanage_expand_sandbox: Expand module failed
>>>> semodule:  Failed!
>>>>
>>>> I can't find any lines concerning exim_exec_t anywhere...
>>>> Please help.
>>>>
>>>>
> in mta.if,
> 
> mta_send_mail has the following
> 
> 
>         domtrans_pattern($1, mailclient_exec_type, system_mail_t)
>         allow system_mail_t mailclient_exec_type:file entrypoint;
> 
> 
> And
> 
> interface(`mta_mailclient',`
>         gen_require(`
>                 attribute mailclient_exec_type;
>         ')
> 
>         typeattribute $1 mailclient_exec_type;
> ')
>at
> 
> In exim.te
> 
> mta_mailclient(exim_exec_t)
> 
>> Thank you, but, I commented line,
> 
>> mta_send_mail(httpd_t)
> 
>> and make apache.pp again but still I have an error.
>> I'm stuck.
> 
> 
>>
Same error? I would check your source file to make sure mta_send_mail is
not coming from somewhere else.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFHVh0CrlYvE4MpobMRAgRiAJ9zuF7+6nNB7JWxd+88aMhl1eHEEQCeLPpo
DY9lWAfx29hWmugTTSrDw+c=
=P9KS
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
