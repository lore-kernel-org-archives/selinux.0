Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r3BF5JDP025274
	for <selinux@tycho.nsa.gov>; Thu, 11 Apr 2013 11:05:19 -0400
Message-ID: <5166D12A.1050104@redhat.com>
Date: Thu, 11 Apr 2013 11:05:14 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Rodney Simioni <rodney.simioni@verio.net>
CC: selinux@tycho.nsa.gov
Subject: Re: I am new to selinux
References: <0971982CF6B9AB418FFD5FEF7F50CB9F05E09976@IAD-WPRD-XCHB03.corp.verio.net>
In-Reply-To: <0971982CF6B9AB418FFD5FEF7F50CB9F05E09976@IAD-WPRD-XCHB03.corp.verio.net>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 04/11/2013 10:03 AM, Rodney Simioni wrote:
> Greetings,
> 
> I?ve been tasked to setup selinux on a web hosting server where users will
> have accounts, able to ftp, able to shell, and able to store their web
> content.
> 
> This server will have some of its services running unconventionally. This
> is how I am approaching selinux and please comment if something concerns
> you on my way of configuring selinux.
> 
> 
> 
> I am the developer of this server but I?m also doing system administration 
> duties. All my code works as expected when the server is in permissive
> mode; however, I do see the failed AVC denials in audit.log.
> 
> 
> 
> Here are my steps:
> 
> 
> 
> 1.       Run all my tests on the code I have written, which will write to
> the audit.log.
> 
> 2.       Do a audit2why ?a, to see the errors and the recommended
> solution.
> 
This will only show you boolean settings.  You might also have labeling issues.

If the content is all going to be in users homedirs ~/public_html, then you
probably need to set a couple of booleans.

I would figure you need.

# setsebool -P ftp_home_dir=1 httpd_enable_homedirs=1

You might also want to turn on httpd_read_user_content.

Of course this might differ depending on the OS and Policy Version you are using.


> 3.       Run all the setsebool commands that was recommended.
> 
> 4.       Then I?ll grep the ?Missing type enforcement (TE) allow rule? AVC 
> errors and pipe them to a file.
> 
> 5.       I?ll create a module from the file and then ? semodule ?i?  the
> module.
> 
> 
> 
> Any comments will be greatly appreciated.
> 
> 
> 
> Rod Simioni
> 
> Software Development Engineer II
> 
> Verio, Inc.
> 
> 
> This email message is intended for the use of the person to whom it has
> been sent, and may contain information that is confidential or legally
> protected. If you are not the intended recipient or have received this
> message in error, you are not authorized to copy, distribute, or otherwise
> use this message or its attachments. Please notify the sender immediately
> by return e-mail and permanently delete this message and any attachments.
> Verio Inc. makes no warranty that this email is error or virus free. Thank
> you.
> 

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.13 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlFm0SoACgkQrlYvE4MpobM2wACfdQqHsfid5NgL0DHJe4Mvvrpa
ivgAn3kpXd5lNYToTdTwDh2iz6KK1hMR
=+99G
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
