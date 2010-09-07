Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o87Emu1b025426
	for <selinux@tycho.nsa.gov>; Tue, 7 Sep 2010 10:48:56 -0400
Received: from mx1.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id o87Emrjn013340
	for <selinux@tycho.nsa.gov>; Tue, 7 Sep 2010 14:48:53 GMT
Message-ID: <4C86508B.2030800@redhat.com>
Date: Tue, 07 Sep 2010 10:47:39 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Jason Axelson <jaxelson@referentia.com>
CC: selinux@tycho.nsa.gov
Subject: Re: What is the risk of allowing audit_write?
References: <AANLkTinseSQrjX7QoLo8wxh_HX6o_nKDUOeiN4-FvZBy@mail.gmail.com>
In-Reply-To: <AANLkTinseSQrjX7QoLo8wxh_HX6o_nKDUOeiN4-FvZBy@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 09/03/2010 05:31 PM, Jason Axelson wrote:
> Hi,
> 
> I have a bash script that I've written that runs in its own domain,
> let's call it my_domain_t. When I run this script, I get a denial
> stating that the script was denied audit_write. But all the script is
> doing when it gets this denial is printing to the screen and asking
> for user input.
> 
> From the SELinux wiki I know that audit_write allows the program to
> "send audit messsages from user space". But does that mean it is able
> to write to /var/log/audit/audit.log? Or more likely send a message to
> the audit daemon which then appends to the audit log?
> 
> So given that I currently don't feel any need to audit the results of
> my script should I use an allow rule or something like dontaudit?
> 
> allow my_domain_t self:capability audit_write
> or
> dontaudit my_domain_t self:capability audit_write
> 
> I'm running this script on CLIP.
> 
> Thanks,
> Jason
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
Just add dontaudit rule.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.16 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAkyGUIsACgkQrlYvE4MpobPZxgCfU6HQw4TXYmMrrCoCcvUVNREr
eMgAn3s4ks6EqSW3BDxwQ4J2A43mUmkm
=Wpod
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
