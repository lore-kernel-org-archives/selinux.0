Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j0AGPtIi000473
	for <selinux@tycho.nsa.gov>; Mon, 10 Jan 2005 11:25:55 -0500 (EST)
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j0AGNnXM007142
	for <selinux@tycho.nsa.gov>; Mon, 10 Jan 2005 16:24:00 GMT
Message-ID: <41E2AC85.8030105@redhat.com>
Date: Mon, 10 Jan 2005 11:25:41 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: jayendren@hivsa.com
CC: "'Stephen Smalley'" <sds@epoch.ncsc.mil>, selinux@tycho.nsa.gov
Subject: Re: SElinux - FC3
References: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAAqur+5IHVuUGKlxy5XOOGrsKAAAAQAAAANeiELNGJPUGSzuI3UPaffwEAAAAA@hivsa.com>
In-Reply-To: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAAqur+5IHVuUGKlxy5XOOGrsKAAAAQAAAANeiELNGJPUGSzuI3UPaffwEAAAAA@hivsa.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Jayendren Anand Maduray wrote:

>Hi!
>
>after enabling SElinux in FC3 - the following failed to startup:
>
>syslog
>portmapper
>
>My methods are enforcing, and at the moment i can excluding these daemons
>from selinux.
>I would like to get them working, n e thoughts, suggestions?
>
>God bless.
>
>
>  
>
They should be working.  I have a feeling you have a mislabled machine. 

touch /.autorelabel
reboot

>--
>This message was distributed to subscribers of the selinux mailing list.
>If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
>the words "unsubscribe selinux" without quotes as the message.
>  
>


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
