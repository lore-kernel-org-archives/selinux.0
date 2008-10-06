Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m96JJiYm029520
	for <selinux@tycho.nsa.gov>; Mon, 6 Oct 2008 15:19:44 -0400
Received: from g5t0007.atlanta.hp.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m96JJiHA021744
	for <selinux@tycho.nsa.gov>; Mon, 6 Oct 2008 19:19:45 GMT
From: Paul Moore <paul.moore@hp.com>
Subject: [PATCH v7 00/17] Labeled networking patches for 2.6.28
To: selinux@tycho.nsa.gov, netdev@vger.kernel.org,
        linux-security-module@vger.kernel.org
Date: Mon, 06 Oct 2008 15:19:41 -0400
Message-ID: <20081006191516.15686.80823.stgit@flek.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

You will notice the lack of a "RFC" prefix to this patchset, that is because
this should be the last revision prior to the 2.6.28 merge window opening.
The changes between v6 and v7 are very minor and mostly involve sparse
fixes and the conversion of some "magic" numbers in net/ipv4/cipso_ipv4.c
to constants defined in the CIPSO header file.  I just updated both the
lblnet-2.6_{testing,next} git trees so anyone interested should feel free
to grab the latest bits from here:

 * git://git.infradead.org/users/pcmoore/lblnet-2.6_testing

Thanks to everyone who has helped review and test these patches.

--
paul moore
linux @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
