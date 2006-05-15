Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k4FMFk3A001115
	for <selinux@tycho.nsa.gov>; Mon, 15 May 2006 18:15:46 -0400
Received: from web36613.mail.mud.yahoo.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id k4FMFjro007126
	for <selinux@tycho.nsa.gov>; Mon, 15 May 2006 22:15:45 GMT
Message-ID: <20060515221530.25241.qmail@web36613.mail.mud.yahoo.com>
Date: Mon, 15 May 2006 15:15:30 -0700 (PDT)
From: Casey Schaufler <casey@schaufler-ca.com>
Reply-To: casey@schaufler-ca.com
Subject: Re: Latest diffs in policy
To: Daniel J Walsh <dwalsh@redhat.com>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <4468EA7C.5050708@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--- Daniel J Walsh <dwalsh@redhat.com> wrote:

> Required for LSPP.
> auditadm is not allowed to do
> anything but manage audit subsystem.

I am touching an LSPP certificate (CCEVS-VR-02-0020)
for a system that also allowed the auditor CAP_KILL
so that a process identified as threatening could
be terminated by the auditor.

> secadmin can only manage selinux stuff.

The aforementioned LSPP system does not support
a secadm role ...

> sysadmin can only do everything 
> not done by auditadm and secadm.

... and allowed the sysadmin to perform
all security relevent functions, including
those related to user and program MAC and
capabilities.


If you want to say that this is how you've
chosen to meet the LSPP requirements, go ahead.
Your scheme is quite rational. It is not,
however, the LSPP requirement.


Casey Schaufler
casey@schaufler-ca.com

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
