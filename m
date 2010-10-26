Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o9QCVhPs031512
	for <selinux@tycho.nsa.gov>; Tue, 26 Oct 2010 08:31:47 -0400
Received: from mx1.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id o9QCVkjW029362
	for <selinux@tycho.nsa.gov>; Tue, 26 Oct 2010 12:31:46 GMT
Message-ID: <4CC6CA2F.6010605@redhat.com>
Date: Tue, 26 Oct 2010 08:31:43 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Shaz <shazalive@gmail.com>
CC: mohit verma <mohit89mlnc@gmail.com>, selinux <selinux@tycho.nsa.gov>
Subject: Re: Confining Java application with SELinux
References: <AANLkTi=1q+3VqY4it_eCDJ6KE1_57q61_9jgkrH377NK@mail.gmail.com>	<AANLkTi=rnig-t8YiCp7xZUeCoVWNdkjwA0Rx3Lwk6Nd_@mail.gmail.com> <AANLkTinZAT8b-qCfvwZ9iO4z1StXTGSjXWvth0gag7AW@mail.gmail.com>
In-Reply-To: <AANLkTinZAT8b-qCfvwZ9iO4z1StXTGSjXWvth0gag7AW@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 10/25/2010 07:20 PM, Shaz wrote:
> On Mon, Oct 25, 2010 at 11:14 PM, mohit verma <mohit89mlnc@gmail.com> wrote:
> 
>> shaz ,will u please explain ur idea in more detail?
>>
>>
> I want to confine a Java application with SELinux policy so I wanted to know
> how I can really do that. Will the application be visible to the native
> platform with SELinux? Or only the Java VM is visible and that we use Java
> ACL to confine the application inside the VM?
> 
> Thanks.
> 
I am not quite sure of the nomenclature here, but you can confine the
entire java process, as long was you wrap the startup script.

cat /usr/bin/myjavaapp
#!/usr/bin/sh
java -class myjavaapp.jar

chcon -t myjavaapp_exec_t /usr/bin/myjavaapp

...

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAkzGyi8ACgkQrlYvE4MpobNdVwCfewWGUpTyTTLqscOOPdB/QE/I
1dwAoOAw1FMLTQm+mvfzzMSKTZcZX79o
=y9Qg
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
