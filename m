Received: from msux-gh1-uea02.nsa.gov (msux-gh1-uea02.nsa.gov [63.239.67.2])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n8E8eGOs023877
	for <selinux@tycho.nsa.gov>; Mon, 14 Sep 2009 04:40:16 -0400
Received: from mail-bw0-f220.google.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id n8E8fcWx027078
	for <selinux@tycho.nsa.gov>; Mon, 14 Sep 2009 08:41:38 GMT
Received: by bwz20 with SMTP id 20so2074504bwz.18
        for <selinux@tycho.nsa.gov>; Mon, 14 Sep 2009 01:40:14 -0700 (PDT)
MIME-Version: 1.0
Date: Mon, 14 Sep 2009 10:40:14 +0200
Message-ID: <61bf8f4f0909140140x7eca781xd4df3a114fe5c430@mail.gmail.com>
Subject: how to always add rules to a policy
From: briaeros007 <briaeros007@gmail.com>
To: selinux@tycho.nsa.gov
Content-Type: text/plain; charset=UTF-8
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello,

First of all, i'm sorry if my questions is something "dumb".

Here the context of my trouble :
I have create a server with an php website.
This php website use a postgresql db on the same server.
I use a RHEL 5.3 and selinux with the policy "targeted".

For the website to works properly, i must add the rules :
"allow httpd_t postgresql_port_t:tcp_socket name_connect;"

So now my problem is :
If i update my server and the policy is updated : Is there a way to
automatically add this (local) rule ?

What i want to do is to use the rhel policy as a base, and to add my
own local rules without the need to recompile them/add them manually
at each update.

I don't know if i'm very clear /o\


Cordially

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
