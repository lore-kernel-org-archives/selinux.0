Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o71FhiUH013777
	for <selinux@tycho.nsa.gov>; Sun, 1 Aug 2010 11:43:44 -0400
Received: from mail-yx0-f181.google.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id o71FheuB023000
	for <selinux@tycho.nsa.gov>; Sun, 1 Aug 2010 15:43:40 GMT
Received: by yxm8 with SMTP id 8so1328839yxm.12
        for <selinux@tycho.nsa.gov>; Sun, 01 Aug 2010 08:43:43 -0700 (PDT)
Message-ID: <4C559624.6040709@gmail.com>
Date: Sun, 01 Aug 2010 11:43:32 -0400
From: Ralph Blach <chipper19522@gmail.com>
MIME-Version: 1.0
To: Jason Axelson <jaxelson@referentia.com>
CC: selinux@tycho.nsa.gov
Subject: Re: semanage
References: <4C4F77D6.1080700@chipblach.net> <AANLkTin+L3kZFqLzsy8ioQze7nD3Vf45C+TPrcAYnm38@mail.gmail.com>
In-Reply-To: <AANLkTin+L3kZFqLzsy8ioQze7nD3Vf45C+TPrcAYnm38@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

I have discovered that ports 443 and 22 are in module tcp.

How do i rewrite module tcp so that I can configure as I want it.

Where do I find module tcp?

I did a semanage port -l | grep 22 and module tcp was listed.
I did the same for port 443

Thanks

Chip

On 07/27/2010 08:29 PM, Jason Axelson wrote:
> On Tue, Jul 27, 2010 at 2:20 PM, Ralph Blach <chipper19522@gmail.com> wrote:
>> how do I use semanage to list the policy modules.
> 
> Hi Chip,
> 
> Perhaps you are looking for "semodule -l"? That will list out all the
> installed policy modules (besides base).
> 
> Jason
> 

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iQIcBAEBAgAGBQJMVZYiAAoJEI46azFTGsehGfQP/0V9ZUHgAtlu7ALAyBLu4kTu
+06VDeeeAIkwxwZxeb9hYo+zGGbj3/QUkvJ1I2v3NwD4GUD2XTdmvCL1OJxk9CAl
y+433whxMa8hkGmGcyY5Fsgs7R8Cg6g8/rcerQGwzI9/rsUBEoX5ijd1/1ZP2MZx
W9RQKUnWjenwJQpTRnlXMh9u5BAx6oSDGmXEeSjQxgYYbdujPXVyRkgR8WNSuc1y
3HA8mObkWvVJ0g9Q2lt74n8CM+KQsrSucRzZnA4iPRe5hgaZE9f3B6rnkbjUi2Lz
g2YtHR5KduGwzp+yuNW3O8u72lX7OGQKQX9ExI8fEr34D6gNTIzvZeI1Fpqg7SdS
MFamLOSkgwYgCmyFG+Iu2EXr3JX+Y/51wHrpkfK0S0ICohMI6R1J7OF2Kp7YODwP
Xgr+yCvp7uo7VtVhxwdRhApOl/5YcTX2dXuhOk5JCLcxL5Yd9MeYMU/db2KGvOhE
6gqhs/p9YX3tk2E6Dd9qUgEu2eSGjov9Jm/tFBiR37PQ1Ajg0x4SXKowahjYkABw
YtRx7+nJaUuvPC8ep66U0ri1PDg6YIAddnFp0RsG3vyUErWH5k7zAdzvCbJARBAm
PpLBNqyiG1gcXk1rGoTgfL0Uv7kScSruP+LvedPbVvYkaEww4vbD4kax3+42gEAN
tTxM5Vb+58W3V5vYGgi+
=UBjr
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
