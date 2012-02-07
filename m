Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q17H2N0b015352
	for <selinux@tycho.nsa.gov>; Tue, 7 Feb 2012 12:02:24 -0500
Received: from mx1.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id q17H2MIs018722
	for <selinux@tycho.nsa.gov>; Tue, 7 Feb 2012 17:02:23 GMT
Message-ID: <4F31591B.8090402@redhat.com>
Date: Tue, 07 Feb 2012 12:02:19 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Devendra Talegaonkar <Devendra.Talegaonkar@kpitcummins.com>,
        SELinux <selinux@tycho.nsa.gov>
Subject: Re: SELinux query
References: <A2F8C1DC917AEC409BE49BB1E1DEF34D1FDF6F78@KCHJEXMB02.kpit.com> <4F2FE956.3050403@redhat.com> <A2F8C1DC917AEC409BE49BB1E1DEF34D1FDF7074@KCHJEXMB02.kpit.com>
In-Reply-To: <A2F8C1DC917AEC409BE49BB1E1DEF34D1FDF7074@KCHJEXMB02.kpit.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 02/07/2012 01:00 AM, Devendra Talegaonkar wrote:
> Thanks a lot Dan,
> 
> Problem is solved. I am trying SELinux on IMX-53 QSB target. I am
> using kernel 2.6.38. Is there any information available about
> compiling and running SELinux on embedded targets?
> 
> 
You would probably get better response on SELinux
<selinux@tycho.nsa.gov> mail list

> Thanks & Regards, Devendra Talegaonkar | Lead Technical Consultant
> - Automotive & Engineering | KPIT Cummins Infosystems Ltd | Ph: +
> 91 20 6652 5000 | M: +91 9822860528
> 
> -----Original Message----- From: Daniel J Walsh
> [mailto:dwalsh@redhat.com] Sent: Monday, February 06, 2012 8:23 PM 
> To: Devendra Talegaonkar Subject: Re: SELinux query
> 
> On 02/06/2012 02:19 AM, Devendra Talegaonkar wrote:
> 
> Seems like you have a policy /checkpolicy version problem.  IE
> Newer checkpolicy compiler require roles to be specified before
> use.
> 
> 
> role system_r;
> 
> role system_r type httpd_t;
> 
> Older compilers allowed you to just specify the second command.
> 
> What policy and what version of checkpolicy are you compiling and
> is this on fedora?
> 
> 

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk8xWRoACgkQrlYvE4MpobOtCgCdGsmOByZ5SusGZp7VM3AguZST
T1MAn1rwVFjnfj3NUumVZmnJmrLplSUi
=DUPr
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
