Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h8TKRUsJ014606
	for <selinux@tycho.nsa.gov>; Mon, 29 Sep 2003 16:27:30 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h8TKRTCG020350
	for <selinux@tycho.nsa.gov>; Mon, 29 Sep 2003 20:27:29 GMT
Received: from mx1.utulsa.edu (mx1.utulsa.edu [129.244.3.226])
        by jazzband.ncsc.mil  with SMTP id h8TKRSqJ020344 for <selinux@tycho.nsa.gov>; Mon, 29 Sep 2003 20:27:28 GMT
Message-ID: <3F7895A0.2030207@utulsa.edu>
Date: Mon, 29 Sep 2003 15:27:12 -0500
From: Nick Davis <nicholas-davis@utulsa.edu>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: SELinux & UML FAQ
References: <F5441DDE18FFD9418974338018C522B718BDB0@na1fcm61.dearborn.ford.com> <200309260247.39337.russell@coker.com.au> <3F73854B.1080408@diyab.net> <200309261242.07521.russell@coker.com.au>
In-Reply-To: <200309261242.07521.russell@coker.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Is there anything special required for getting UML working with 2.6
SELinux?  I've downloaded the patch and
applied it to 2.6.0-test3, which seemed to work fine.  But I get errors
when doing a 'make linux ARCH=um' as
suggested on the UML website documentation.  I was wondering if anything
has changed since the 2.4.x days; the docs are at least a couple years old.

Thanks,

Nick Davis
Center for Information Security
University of Tulsa



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
