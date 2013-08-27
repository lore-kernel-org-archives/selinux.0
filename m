Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r7RHeVUw021736
	for <selinux@tycho.nsa.gov>; Tue, 27 Aug 2013 13:40:31 -0400
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 94FF521E18
	for <selinux@tycho.nsa.gov>; Tue, 27 Aug 2013 13:40:13 -0400 (EDT)
Received: from [10.16.197.114] (unknown [66.187.233.206])
	by mail.messagingengine.com (Postfix) with ESMTPA id 7F3426800E5
	for <selinux@tycho.nsa.gov>; Tue, 27 Aug 2013 13:40:13 -0400 (EDT)
Subject: libselinux's __attribute__((constructor)) versus nVidia libGL.so
From: Colin Walters <walters@verbum.org>
To: SELinux List <selinux@tycho.nsa.gov>
Content-Type: text/plain
Date: Tue, 27 Aug 2013 13:40:12 -0400
Message-ID: <1377625212.20072.4.camel@localhost>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

Can someone from the libselinux side comment on this bug?



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
