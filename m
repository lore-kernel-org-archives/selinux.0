Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o6EJMH2B006239
	for <selinux@tycho.nsa.gov>; Wed, 14 Jul 2010 15:22:18 -0400
Received: from exprod8og103.obsmtp.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with SMTP id o6EJLKnY019755
	for <selinux@tycho.nsa.gov>; Wed, 14 Jul 2010 19:21:23 GMT
Received: by pvh1 with SMTP id 1so3887030pvh.41
        for <selinux@tycho.nsa.gov>; Wed, 14 Jul 2010 12:22:13 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4C3DAEBD.5020402@manicmethod.com>
References: <AANLkTilEZmTTTYxSXlFY343Le2EyvSGD_zWAr8K4ZDVI@mail.gmail.com>
	<4C3DAEBD.5020402@manicmethod.com>
From: Jason Axelson <jaxelson@referentia.com>
Date: Wed, 14 Jul 2010 09:21:53 -1000
Message-ID: <AANLkTikAWngCdcZOOe5oGoWPqiGvfRs-S8xufKXeIvEG@mail.gmail.com>
Subject: Re: Using checkmodule to build "old module versions"
To: Joshua Brindle <method@manicmethod.com>
Cc: selinux@tycho.nsa.gov
Content-Type: multipart/mixed; boundary=000e0cd32d3a2c8603048b5de77b
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--000e0cd32d3a2c8603048b5de77b
Content-Type: text/plain; charset=ISO-8859-1

Hi Joshua,

On Wed, Jul 14, 2010 at 2:34 AM, Joshua Brindle <method@manicmethod.com> wrote:
> The writer is technically capable of writing old versions but we never added
> the option to checkmodule.
>
> There has been little testing around building modules on a different
> toolchain than the target so while it is suppose to work I wouldn't really
> recommend it.

Thanks for the explanation. Does anyone know if it is possible to
change the checkmodule man page to make it more clear that you can't
build old versions.

I propose to change:
Show policy versions created by this program

to this:
Show policy versions created by this program. Note that you cannot
currently build older versions.

I have attached a (trivial) patch that should apply against the
current head. Of course there may be better wording.

Thanks,
Jason
--000e0cd32d3a2c8603048b5de77b--
