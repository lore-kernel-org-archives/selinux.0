Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id jBCHC0MA015587
	for <selinux@tycho.nsa.gov>; Mon, 12 Dec 2005 12:12:00 -0500 (EST)
Received: from mbox-o00.iijmio.jp (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id jBCH3jGr013457
	for <selinux@tycho.nsa.gov>; Mon, 12 Dec 2005 17:03:46 GMT
Message-Id: <200512121703.jBCH3eEg017497@mms-r00.iijmio.jp>
Date: Mon, 12 Dec 2005 12:03:37 -0500
From: Yuichi Nakamura <himainu-ynakam@miomio.jp>
MIME-Version: 1.0
To: fedora-selinux-list@redhat.com, selinux@tycho.nsa.gov
Cc: himainu-ynakam@miomio.jp
Subject: Re: Interesting reading on exec* access checks.
Content-Type: text/plain; charset=US-ASCII
In-Reply-To: <4398A5AD.2010701@redhat.com>
References: <4398A5AD.2010701@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Daniel J Walsh wrote:
> http://people.redhat.com/drepper/selinux-mem.html
I have basic question about these permissions.
Fedora Core already have "Exec Shield" to prevent execution of malicious code on memory.
I can not understand relationship between exec shield and these permissions.
What is good point of these permissions?
In other words, 
I would like to know 
"Attack that can not be prevented  by exec shield, 
 but can be prevented by these permissions(exec* permissions)".

Does anyone know ?

Yuichi Nakamura



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
