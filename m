Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p7OGjwYI016174
	for <selinux@tycho.nsa.gov>; Wed, 24 Aug 2011 12:45:58 -0400
Received: from exchange10.columbia.tresys.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id p7OGjv0e019934
	for <selinux@tycho.nsa.gov>; Wed, 24 Aug 2011 16:45:58 GMT
Message-ID: <4E552AC1.6030809@tresys.com>
Date: Wed, 24 Aug 2011 12:45:53 -0400
From: Steve Lawrence <slawrence@tresys.com>
MIME-Version: 1.0
To: SELinux <selinux@tycho.nsa.gov>
Subject: SELinux Common Intermediate Language Update
Content-Type: text/plain; charset="ISO-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

As many of you know, we've been working on the SELinux Common
Intermediate Language (CIL) compiler, called secilc, for many months now.

As a refresher, CIL is an intermediate language designed as a policy
representation that sits between high level policy languages and the
kernel policy representation. We're happy to answer any questions about
the language, but for more information, please take a look at the CIL
Design wiki at http://userspace.selinuxproject.org/trac/wiki/CilDesign

A few months ago, we released a version of secilc that could handle most
of the features supported by reference policy and output a policy.conf
file. We just recently reached a big milestone in that we can now
generate binary policy files from only CIL source files. Because of
this, we're dubbing this secilc v0.1.

Now that the compiler has reached this milestone, we would love for the
community to play around with it a bit and give us any feedback as we
continue on to integration with the existing SELinux tools and
implementing more advanced features, such has inheritance and transforms.

The secilc v0.1 tarball can be downloaded here:

http://userspace.selinuxproject.org/cil/secilc-0.1.tar.gz

The secilc repository can be downloaded via git here:

$ git clone http://oss.tresys.com/git/cil.git

Thanks,
Steve Lawrence

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
