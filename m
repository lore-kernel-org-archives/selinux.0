Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j6FCh6gA010852
	for <selinux@tycho.nsa.gov>; Fri, 15 Jul 2005 08:43:08 -0400 (EDT)
Received: from gw.linuon.co.jp (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j6FCdVrE008712
	for <selinux@tycho.nsa.gov>; Fri, 15 Jul 2005 12:39:32 GMT
Message-ID: <42D7AE69.30100@linuon.com>
Date: Fri, 15 Jul 2005 21:39:05 +0900
From: Junji Kanemaru <linux@linuon.com>
MIME-Version: 1.0
To: Daniel J Walsh <dwalsh@redhat.com>
CC: selinux@tycho.nsa.gov
Subject: Re: cvs and mta
References: <42D4D4AC.9010403@linuon.com> <42D4EB9B.2050701@redhat.com> <42D5D42B.9090705@linuon.com> <42D6456F.6040001@redhat.com>
In-Reply-To: <42D6456F.6040001@redhat.com>
Content-Type: text/plain; charset=ISO-2022-JP
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> How about the following?

Thanks. I'll try it next week since I'm out of office now.

> What is it looking at that is marked default_t? I don't like those rules.

I used to have cvs user on server which was shared by
developers to access cvs repo.
I moved them to /var/cvs now so it shouldn't be needed anymore.

Thank you for your help.

-- Junji


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
