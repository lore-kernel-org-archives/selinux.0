Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o6ECY35Z010014
	for <selinux@tycho.nsa.gov>; Wed, 14 Jul 2010 08:34:03 -0400
Received: from manicmethod.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id o6ECX7DW002063
	for <selinux@tycho.nsa.gov>; Wed, 14 Jul 2010 12:33:07 GMT
Message-ID: <4C3DAEBD.5020402@manicmethod.com>
Date: Wed, 14 Jul 2010 08:34:05 -0400
From: Joshua Brindle <method@manicmethod.com>
MIME-Version: 1.0
To: Jason Axelson <jaxelson@referentia.com>
CC: selinux@tycho.nsa.gov
Subject: Re: Using checkmodule to build "old module versions"
References: <AANLkTilEZmTTTYxSXlFY343Le2EyvSGD_zWAr8K4ZDVI@mail.gmail.com>
In-Reply-To: <AANLkTilEZmTTTYxSXlFY343Le2EyvSGD_zWAr8K4ZDVI@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Jason Axelson wrote:
> Hi,
>
> I may be misunderstanding things but I think that a "new" version of
> checkmodule is able to create policy versions other than "latest". I
> know that checkpolicy accepts the -c option to create binary policies
> of older versions. Is there any equivalent for checkmodule?
>
> My version of checkmodule (2.0.21 I believe) when run with -V reports
> that it supports "Module versions 4-10", however I do not see any
> flags to change the compiled module policy version.
>

The writer is technically capable of writing old versions but we never 
added the option to checkmodule.

There has been little testing around building modules on a different 
toolchain than the target so while it is suppose to work I wouldn't 
really recommend it.

> When I then try to load the compiled module on CentOS 5.4 with
> "semodule -i A.pp" it responds with:
>
> libsepol.policydb_read: policydb module version 10 does not match my
> version range 4-6
> libsepol.sepol_module_package_read: invalid module in module package
> (at section 0)
> libsemanage.semanage_load_module: Error while reading from module file
> /etc/selinux/clip/modules/tmp/modules/A.pp.
> semodule:  Failed!
>
> So it looks like checkmodule should be able to build policy version 6
> which is supported by semodule on the CentOS 5.4 side.
>
> Am I misunderstanding something?
>
> My setup is using Arch Linux as the development machine so I know it
> isn't really "supported" per se.
>
> Thanks,
> Jason


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
