Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id mABFWVM2021896
	for <selinux@tycho.nsa.gov>; Tue, 11 Nov 2008 10:32:31 -0500
Received: from nf-out-0910.google.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id mABFUkBj022113
	for <selinux@tycho.nsa.gov>; Tue, 11 Nov 2008 15:30:46 GMT
Received: by nf-out-0910.google.com with SMTP id b21so1478701nfd.4
        for <selinux@tycho.nsa.gov>; Tue, 11 Nov 2008 07:32:30 -0800 (PST)
Message-ID: <dd18b0c30811110732y79e609fct783e393a7b5f2e5c@mail.gmail.com>
Date: Tue, 11 Nov 2008 07:32:30 -0800
From: "Justin Mattock" <justinmattock@gmail.com>
To: SE-Linux <selinux@tycho.nsa.gov>, tresys <refpolicy@oss.tresys.com>
Subject: latest svn refpolicy confusion
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

when making the latest refpolicy
from svn I keep receiving a checkpolicy error
with anything having to do with dbus:
allow sysadm_dbusd_t gconf_etc_t:dir { read search getattr };
allow sysadm_dbusd_t gconf_etc_t:file { read getattr };
changing these roles to staff_r still produces
and error, when commenting these out in my .te file
the error will continue to the next *_dbusd_t *
rule for some reason. is there a new setting with dbus
that I'm missing?
the system is ubuntu intrepid(unstable, or my own hacked version);

regards;
-- 
Justin P. Mattock

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
