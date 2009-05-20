Content-Type: text/plain; charset="iso-8859-1"
Date: Wed, 20 May 2009 09:21:18 +0200
From: "Dennis Wronka" <linuxweb@gmx.net>
In-Reply-To: <4A1374D5.6080504@tycho.nsa.gov>
Message-ID: <20090520072118.226550@gmx.net>
MIME-Version: 1.0
References: <1242641994.470.5.camel@notebook2.grift.internal>	
 <1242651013.29973.197.camel@localhost.localdomain>
 <1242651553.1057.0.camel@notebook2.grift.internal>
 <4A1374D5.6080504@tycho.nsa.gov>
Subject: Policy loading problem
To: SELinux@tycho.nsa.gov
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello folks,

currently I am experiencing quite a strange problem during system-boot.
The problem is that the policy only gets loaded when I boot into enforcing-mode. Booting into permissive mode (doesn't matter if via kernel-parameter or config-file) does not load the policy at all.

I am using Kernel 2.6.29.3 and Reference Policy 2.20081210.
Did anything change in the latest kernel or policy that triggers this? Is it possible to create a policy that cannot be loaded in permissive mode?

Any help or suggestion would be great.

Thanks,
Dennis
-- 
Neu: GMX FreeDSL Komplettanschluss mit DSL 6.000 Flatrate + Telefonanschluss für nur 17,95 Euro/mtl.!* http://dslspecial.gmx.de/freedsl-surfflat/?ac=OM.AD.PD003K11308T4569a

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
