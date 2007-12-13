Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id lBDD1iWk010053
	for <selinux@tycho.nsa.gov>; Thu, 13 Dec 2007 08:01:45 -0500
Received: from rv-out-0910.google.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id lBDD1a1s024194
	for <selinux@tycho.nsa.gov>; Thu, 13 Dec 2007 13:01:36 GMT
Received: by rv-out-0910.google.com with SMTP id k15so595453rvb.54
        for <selinux@tycho.nsa.gov>; Thu, 13 Dec 2007 05:01:31 -0800 (PST)
Message-ID: <8f34198c0712130501q55577db7u2ebadad54069f4e7@mail.gmail.com>
Date: Thu, 13 Dec 2007 21:01:31 +0800
From: "Ian jonhson" <jonhson.ian@gmail.com>
To: "SE Linux" <selinux@tycho.nsa.gov>
Subject: How to set other process quota by setrlimit
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

We all know that we can set resource quota of process with pam_limits.so.
The module can enforce the resource usage (cpu, memory, maximal number of
open file, etc) by setrlimit.

It seems that the function, setrlimit(), can only set self resource
quota of process and
inherit by its child processes, right?

Because I adopted the function in one process to set another process'
resource quota,
and found nothing enforced happen. The other process can run as
before, not any limitation.

I don't know whether what I have designed is correct, using the setrlimit to
set other process resource
usage. If it is wrong, are there other ways to accomplish my target?

Thank you in advance.

Regards,
Ian

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
