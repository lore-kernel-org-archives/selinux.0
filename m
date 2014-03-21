Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s2LIZDJx019748
 for <selinux@tycho.nsa.gov>; Fri, 21 Mar 2014 14:35:13 -0400
Message-ID: <532C861B.2000004@redhat.com>
Date: Fri, 21 Mar 2014 14:34:03 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: kim.lawson-jenkins@nrl.navy.mil, selinux@tycho.nsa.gov
Subject: Re: How to restore a policy module
References: <01e101cf4509$9942ae60$cbc80b20$@nrl.navy.mil>
In-Reply-To: <01e101cf4509$9942ae60$cbc80b20$@nrl.navy.mil>
Content-Type: text/plain; charset=ISO-8859-1
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 03/21/2014 09:29 AM, Kim Lawson-Jenkins wrote:
> In an attempt to lockdown a system I removed the remotelogin policy module
> using semodule ?r.  I?m using the targeted policy on RHEL6.  How do I add
> this file back to my current configuration?
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> _______________________________________________ Selinux mailing list 
> Selinux@tycho.nsa.gov To unsubscribe, send email to
> Selinux-leave@tycho.nsa.gov. To get help, send an email containing "help"
> to Selinux-request@tycho.nsa.gov.
> 
yum reinstall selinux-policy-targeted

Should do it.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlMshhsACgkQrlYvE4MpobOIsQCghsLBWa3m8QxihXmjXsmm8UcE
708AmgOi7Hp1e1FRGMyuohfqonoS4fQQ
=PP3O
-----END PGP SIGNATURE-----
