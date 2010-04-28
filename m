Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o3SHvcPA026447
	for <selinux@tycho.nsa.gov>; Wed, 28 Apr 2010 13:57:38 -0400
Received: from mail-gx0-f224.google.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id o3SHwedF013894
	for <selinux@tycho.nsa.gov>; Wed, 28 Apr 2010 17:58:40 GMT
Received: by gxk24 with SMTP id 24so7944591gxk.18
        for <selinux@tycho.nsa.gov>; Wed, 28 Apr 2010 10:57:37 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4BD856B5.9000405@redhat.com>
References: <20100422204612.25506.16029.stgit@paris.rdu.redhat.com>
	 <1271972155.16202.55.camel@moss-pluto.epoch.ncsc.mil>
	 <4BD18CAE.4050201@redhat.com>
	 <20100426061848.GS21894@myhost.felk.cvut.cz>
	 <4BD58C7B.1000507@redhat.com>
	 <20100426143933.GU21894@myhost.felk.cvut.cz>
	 <4BD5AF15.8000301@redhat.com>
	 <u2v10143821004280732jbeab15b9n4aba3dc70e34aaa4@mail.gmail.com>
	 <4BD856B5.9000405@redhat.com>
Date: Wed, 28 Apr 2010 13:57:37 -0400
Message-ID: <h2m10143821004281057t2f22085cvc7ea1a9937a4531@mail.gmail.com>
Subject: Re: [PATCH] SELINUX: new permission controlling the ability to set
	suid
From: Karl MacMillan <karlwmacmillan@gmail.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: selinux@tycho.nsa.gov
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, Apr 28, 2010 at 11:39 AM, Daniel J Walsh <dwalsh@redhat.com> wrote:
>>> This is not default allow.  It is DAC + MAC as opposed to the way most
>>> people run, which is just DAC. I am trying to make setattr check better.
>>>
>>> DAC + sudo versus DAC + MAC + SUDO.
>>
>> I thought that the intent of the current MAC / DAC interaction was
>> that capabilities are used to decompose root and MAC can restrict
>> capabilities on processes to add extra DAC protections. Now, I'll
>> admit a good deal of ignorance here, but is there a reason that we
>> can't just write policy using that mechanism to accomplish what you
>> are after? If we prevented confined admin domains with root from
>> having the needed capability to setuid files isn't that enough? Or if
>> the right capability doesn't exist, can't you add a new capability?
>>
>> Karl
> Write now the ability to setattr on a file gives you the ability to
> chmod 4755 EXE on types you control.
>
> But we want to allow chmod 755 EXE but prevent chmod 4755.  Eric is
> adding a Access check for this.

I understand that, but I (and I think others) are concerned about
directly adding permissions for what is essentially DAC policy. I was
wondering why the current strategy of mitigating DAC with SELinux
through capabilities is not workable in this case. That has the
additional benefit of allowing non-SELinux systems to benefit as well
if new capabilities are needed.

Karl

> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v2.0.14 (GNU/Linux)
> Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/
>
> iEYEARECAAYFAkvYVrUACgkQrlYvE4MpobPCUwCfVKETZQvQKRSvmDpUyBGxFovk
> bIEAnjDYGP2oyTxMG8P5xPYOT/WyW31p
> =PSKp
> -----END PGP SIGNATURE-----
>


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
