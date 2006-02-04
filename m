Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id k140FOXf009525
	for <selinux@tycho.nsa.gov>; Fri, 3 Feb 2006 19:15:24 -0500 (EST)
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k140FLt5028741
	for <selinux@tycho.nsa.gov>; Sat, 4 Feb 2006 00:15:21 GMT
Message-ID: <43E3F227.1010006@redhat.com>
Date: Fri, 03 Feb 2006 19:15:35 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: russell@coker.com.au
CC: SELinux List <selinux@tycho.nsa.gov>, James Morris <jmorris@redhat.com>
Subject: Re: MCS policy patch
References: <200602040118.10784.russell@coker.com.au>
In-Reply-To: <200602040118.10784.russell@coker.com.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

+
+mlsconstrain process { transition dyntransition } (( h1 dom h2 ) or
+		( t1 == getty_t ) or ( t1 == init_t ) or ( t1 == initrc_t ) or
+		( t1 == kernel_t ));
+

This does not work currently because it will not allow unconfined_t to run /bin/su if unconfined_t is not set to SystemLow->SystemHigh.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
