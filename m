Message-ID: <4B8ECC26.3080806@gmail.com>
Date: Wed, 03 Mar 2010 12:52:54 -0800
From: "Justin P. mattock" <justinmattock@gmail.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: AlannY <m@alanny.ru>, SELinux@tycho.nsa.gov,
        Joshua Brindle <method@manicmethod.com>,
        Chad Sellers <csellers@tresys.com>
Subject: Re: Problem with compiling refpolicy base.pp
References: <4B8E72D2.8030802@alanny.ru>	 <1267629710.6048.63.camel@moss-pluto.epoch.ncsc.mil> <1267633395.6048.116.camel@moss-pluto.epoch.ncsc.mil>
In-Reply-To: <1267633395.6048.116.camel@moss-pluto.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

ahh.. with the git interface for flex
I reset to the last commit, which makes
checkmodule/checkpolicy work. I'll have a go
at the bisect and see if I comeup
with anything of use.

Justin P. Mattock

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
