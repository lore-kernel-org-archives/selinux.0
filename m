Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p58LE3gg018204
	for <selinux@tycho.nsa.gov>; Wed, 8 Jun 2011 17:14:03 -0400
Received: from exchange10.columbia.tresys.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id p58LE2bX002621
	for <selinux@tycho.nsa.gov>; Wed, 8 Jun 2011 21:14:02 GMT
Message-ID: <4DEFE619.9080606@tresys.com>
Date: Wed, 8 Jun 2011 17:14:01 -0400
From: Steve Lawrence <slawrence@tresys.com>
MIME-Version: 1.0
To: SELinux <selinux@tycho.nsa.gov>
Subject: SELinux Common Intermediate Language Update
Content-Type: text/plain; charset="ISO-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

As many of you know, we've been working on the SELinux Common
Intermediate Language (CIL) compiler for many months now, most recently
discussed in November of last year [1].

As a refresher, CIL is an intermediate language designed as a policy
representation that sits between high level policy languages and the
kernel policy representation. We're happy to answer any questions about
the language, but for more information, please take a look at the CIL
Design wiki at http://userspace.selinuxproject.org/trac/wiki/CilDesign

As to the purpose of this email, we've recently reached a pretty
significant milestone with the compiler, in that it now supports most of
the features that are currently supported by reference policy (e.g.
macros, optionals, tunables, etc) as well as the standard SELinux policy
rules (e.g. allow, type, role, etc). Now that the compiler has reached
this milestone, we would love for the community to play around with it a
bit and give us any feedback as we continue on to integration and
implementing the more advanced features, such has inheritance and
transforms.

The CIL compiler repository can be downloaded via git:

$ git clone http://oss.tresys.com/git/cil.git

Thanks,
Steve Lawrence

[1] http://marc.info/?l=selinux&m=128881480827958&w=2

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
