Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id kATISXoU026736
	for <selinux@tycho.nsa.gov>; Wed, 29 Nov 2006 13:28:34 -0500
Received: from atlrel6.hp.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id kATIQo46002545
	for <selinux@tycho.nsa.gov>; Wed, 29 Nov 2006 18:26:51 GMT
Message-Id: <20061129181817.505281000@hp.com>
Date: Wed, 29 Nov 2006 13:18:17 -0500
From: paul.moore@hp.com
To: netdev@vger.kernel.org, selinux@tycho.nsa.gov
Subject: [PATCH 0/3] NetLabel: add the remaining CIPSO tag types from the IETF draft
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This patchset consists of three patches that add support for the remaining two
tag types from the CIPSO draft specification, the enumerated and range tags.
The most significant part about adding these two tags is that NetLabel now has
the ability to represent more than 240 categories (limitation imposed by the
current restricted bitmap tag).

In addition, the first patch in the set converts NetLabel's contiguous char
string category bitmap stored in network friendly bit/byte order into a sparse
bitmap stored in host friendly bit/byte order.  While this change was not
required to support the new CIPSO tags, it should make life much easier as the
old category bitmap would have proven problematic as the number of usable
categories increases with the new tag types.  It also has a side effect of
making the LSM specific code much less ugly.

During testing I have not seen any regressions with this patchset; please
consider this for net-2.6.20.  Thanks.

--
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
