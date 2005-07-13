Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j6D8mlgA022957
	for <selinux@tycho.nsa.gov>; Wed, 13 Jul 2005 04:48:48 -0400 (EDT)
Received: from gw.linuon.co.jp (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j6D8jYvl006968
	for <selinux@tycho.nsa.gov>; Wed, 13 Jul 2005 08:45:36 GMT
Received: from [192.168.3.128] (ppp-client-on-ssh-3.linuon.co.jp [192.168.3.128])
	by gw.linuon.co.jp (8.13.1/8.13.1) with ESMTP id j6D8j6Hs000899
	for <selinux@tycho.nsa.gov>; Wed, 13 Jul 2005 17:45:08 +0900
Message-ID: <42D4D4AC.9010403@linuon.com>
Date: Wed, 13 Jul 2005 17:45:32 +0900
From: Junji Kanemaru <linux@linuon.com>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: cvs and mta
Content-Type: text/plain; charset=ISO-2022-JP
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

I recently upgraded to fc4 and having problem with my pserver(cvs)
that it no longer sends out checkin mail.
I was missing around with SELinux policy and realized that there's no
TE and FC defined for such use.
I guess /var/cvs should be cvs_data_t and cvs.te should have entries
to allow cvs to invoke MTA.
I fixed my policy using audit2allow but it is dirty fix and not safe,
I have whole bunch of "allow" lines in it now.
Is there patch already there?

-- Junji

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
