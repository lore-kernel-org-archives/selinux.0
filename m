Received: from msux-gh1-uea01.nsa.gov (msux-gh1-uea01.nsa.gov [63.239.67.1])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n6THcqmt019188
	for <selinux@tycho.nsa.gov>; Wed, 29 Jul 2009 13:38:52 -0400
Received: from mx1.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id n6THcRJp026199
	for <selinux@tycho.nsa.gov>; Wed, 29 Jul 2009 17:38:28 GMT
Date: Wed, 29 Jul 2009 13:38:50 -0400 (EDT)
From: Doug Sikora <dsikora@redhat.com>
To: "Justin P. Mattock" <justinmattock@gmail.com>
Cc: SE-Linux <selinux@tycho.nsa.gov>
Message-ID: <313343284.1195721248889130071.JavaMail.root@zmail05.collab.prod.int.phx2.redhat.com>
In-Reply-To: <4A7083DB.4000003@gmail.com>
Subject: Re: is it safe to use ext4 for SELinux
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I have X86_64
I'm using ext4 without any issues .. plus my /home filesystem is encrypted as well.
not sure about on an imac -- I'd say to do it and monitor the logs


I do have this awful issue with firefox 3.5.1 where it locks up the entire OS, it happens all too often, but this does not appear selinux related as there are not any odd messages in the logs. google showed many other with same issue but no resolution.



----- Original Message -----
From: "Justin P. Mattock" <justinmattock@gmail.com>
To: "SE-Linux" <selinux@tycho.nsa.gov>
Sent: Wednesday, July 29, 2009 1:16:11 PM GMT -05:00 US/Canada Eastern
Subject: is it safe to use ext4 for SELinux

I've just downloaded the fedora 11 livecd and am installing it on an
imac. during the partition scheme should I use ext4,
or stick with ext3 for SELinux to function properly?

Justin P. Mattock

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
