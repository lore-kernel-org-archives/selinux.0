Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o9K1hXL7000436
	for <selinux@tycho.nsa.gov>; Tue, 19 Oct 2010 21:43:34 -0400
Received: from hrndva-omtalb.mail.rr.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id o9K1hSgC016691
	for <selinux@tycho.nsa.gov>; Wed, 20 Oct 2010 01:43:33 GMT
Date: Tue, 19 Oct 2010 20:54:09 -0500
From: "Serge E. Hallyn" <serge@hallyn.com>
To: "Justin P. Mattock" <justinmattock@gmail.com>
Cc: selinux@tycho.nsa.gov, refpolicy@oss1.tresys.com
Subject: Re: load_policy() with upstart on mint 9 fluxbox
Message-ID: <20101020015409.GA19663@hallyn.com>
References: <4CBE21ED.4050706@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4CBE21ED.4050706@gmail.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Quoting Justin P. Mattock (justinmattock@gmail.com):
> I admit it, I'm a total newb at this upstart thing, anyways
> I installed all the packages for mint 9 fluxbox, but the policy
> is not loading during boot
> what/where might I look to read up on this, so I can get the policy
> loaded at boot...

iiuc that should happen in initrd, before upstart is running.

man initramfs-tools for some info on how to tweak your initrd.

-serge

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
