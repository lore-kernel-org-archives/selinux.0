Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q1MFdqZU023622
	for <selinux@tycho.nsa.gov>; Wed, 22 Feb 2012 10:39:52 -0500
Received: by vcbfl10 with SMTP id fl10so137263vcb.12
        for <selinux@tycho.nsa.gov>; Wed, 22 Feb 2012 07:39:51 -0800 (PST)
MIME-Version: 1.0
Date: Wed, 22 Feb 2012 10:39:51 -0500
Message-ID: <CAD8iFzyz8pJjDxGY1Tg27bbhS4HgUemfyabY3VCkDBfxE1yqug@mail.gmail.com>
Subject: selinux policy and alloc_security function
From: Subramani Venkatesh <selinuxv31@gmail.com>
To: selinux@tycho.nsa.gov
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi
I am a newbie for selinux concepts and LSM changes in kernel. I
defined a new class in kernel(security/selinux/include/classmap.h)
similar to IPC calls,  I defined  allocate security function similar
to selinux_shm_alloc_security, I would like to invoke this function
from kernel driver, is this valid, if not how do I do that from
userspace application, could some guide me through how user space
policy and kernel hooks interface?

I appreciate your support.

Regards,
Subbu

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
