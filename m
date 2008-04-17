Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m3HKKLii027776
	for <selinux@tycho.nsa.gov>; Thu, 17 Apr 2008 16:20:21 -0400
Received: from over.ny.us.ibm.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m3HKKHgv011894
	for <selinux@tycho.nsa.gov>; Thu, 17 Apr 2008 20:20:17 GMT
Received: from e2.ny.us.ibm.com ([192.168.1.102])
	by pokfb.esmtp.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id m3HI1o8L030396
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <selinux@tycho.nsa.gov>; Thu, 17 Apr 2008 14:01:50 -0400
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e2.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m3HHtU6b028370
	for <selinux@tycho.nsa.gov>; Thu, 17 Apr 2008 13:55:30 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id m3HHtUUS255130
	for <selinux@tycho.nsa.gov>; Thu, 17 Apr 2008 13:55:30 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id m3HHtTaO007137
	for <selinux@tycho.nsa.gov>; Thu, 17 Apr 2008 13:55:30 -0400
Date: Thu, 17 Apr 2008 12:55:30 -0500
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: fmac-discuss@opensolaris.org, fedora-selinux-list@redhat.com
Cc: SELinux <selinux@tycho.nsa.gov>,
        Linux Containers <containers@lists.osdl.org>
Subject: selinux mini-summit sub-policy topic
Message-ID: <20080417175530.GA21302@sergelap.austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

It appears many of us have a related policy issue.

The Fedora folks want to be able to create distro images under a chroot
or namespace with selinux enforcing, but with the distro images having
different policy from the host.  I don't know whether they want to be
able to run tests under that image, or only be able to write down
potentially unknown labels so as to be able to lay the image down on
disk.

The fmac (opensolaris) folks may want to be able to load different
policies in different zones.

The linux containers folks (and I) want basically the same thing as
zones folks, that, is to support container administrators loading their
own policy.  My plan had been to pull together what I can to propose a
LISA paper, so I was hoping to really get geared up this week after
finishing other papers.  (This is free time stuff, and has been on
the back burner for a year now.)  In the containers case, I am
starting to use the type namespace (container1.subtype1) to confine
a container policy, where subtype1 in container1 is known to the
host as container1.subtype1.  This leaves MLS and MCS unsupported ATM.

Dan Walsh is working policy for xen/qemu images, however that is
not really related as the vm has its own OS.  I'm mentioning it here
in case I'm wrong.

Are there other projects needing similar support?  There used to be
a problem with rpms being able to create files with not-yet-defined
types, which may be more similar to the fedora problem above, and I
have no idea whether/how that ended up being resolved.

Is it worth proposing a joint topic for discussion at the selinux
mini-summit?  It could take several formats, from a meeting amongst
ourselves followd by a panel discussion, to a set of lightning talks, to
a 30 minute joint presentation where we present what we talk about in
emails before OLS.

thanks,
-serge

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
