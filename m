Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o2AFZtsC010252
	for <selinux@tycho.nsa.gov>; Wed, 10 Mar 2010 10:35:56 -0500
Received: from imr1.ericy.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id o2AFaLI8021398
	for <selinux@tycho.nsa.gov>; Wed, 10 Mar 2010 15:36:21 GMT
From: Alan Rouse <alan.rouse@ericsson.com>
To: Justin Mattock <justinmattock@gmail.com>,
        tresys
	<refpolicy@oss1.tresys.com>, SE-Linux <selinux@tycho.nsa.gov>
Date: Wed, 10 Mar 2010 10:35:35 -0500
Subject: RE: [refpolicy] what to do: libsemanage.get_home_dirs:
Message-ID: <5A5E55DF96F73844AF7DFB0F48721F0F52E45FB4E0@EUSAACMS0703.eamcs.ericsson.se>
References: <dd18b0c31003091001n5b5ab089g3829823e256ae86e@mail.gmail.com>
In-Reply-To: <dd18b0c31003091001n5b5ab089g3829823e256ae86e@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Justin Mattock wrote:
> with the latest policy on open suse 11.2 I'm seeing this after building the policy:
> libsemanage.get_home_dirs: nobody homedir /var/lib/nobody or its parent directory conflicts with a 
> file context already specified in the policy.  This usually indicates an incorrectly defined system 
> account.  If it is a system account please make sure its uid is less than 1000 or its login shell is 
> /sbin/nologin.
>
> with using an older policy on this system, I never saw this.
>
> what to do?

usermod -s /sbin/nologin nobody


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
