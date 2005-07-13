Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j6DAQJgA023481
	for <selinux@tycho.nsa.gov>; Wed, 13 Jul 2005 06:26:21 -0400 (EDT)
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j6DAN7vl011175
	for <selinux@tycho.nsa.gov>; Wed, 13 Jul 2005 10:23:07 GMT
Message-ID: <42D4EB9B.2050701@redhat.com>
Date: Wed, 13 Jul 2005 06:23:23 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Junji Kanemaru <linux@linuon.com>
CC: selinux@tycho.nsa.gov
Subject: Re: cvs and mta
References: <42D4D4AC.9010403@linuon.com>
In-Reply-To: <42D4D4AC.9010403@linuon.com>
Content-Type: text/plain; charset=ISO-2022-JP
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Junji Kanemaru wrote:

>Hi,
>
>I recently upgraded to fc4 and having problem with my pserver(cvs)
>that it no longer sends out checkin mail.
>I was missing around with SELinux policy and realized that there's no
>TE and FC defined for such use.
>I guess /var/cvs should be cvs_data_t and cvs.te should have entries
>to allow cvs to invoke MTA.
>I fixed my policy using audit2allow but it is dirty fix and not safe,
>I have whole bunch of "allow" lines in it now.
>Is there patch already there?
>
>-- Junji
>
>--
>This message was distributed to subscribers of the selinux mailing list.
>If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
>the words "unsubscribe selinux" without quotes as the message.
>  
>
Does adding the line

typeattribute cvs_t privmail;

help?



-- 



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
