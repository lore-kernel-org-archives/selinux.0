Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l615X13a019605
	for <selinux@tycho.nsa.gov>; Sun, 1 Jul 2007 01:33:01 -0400
Received: from [66.135.97.2] (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l615Wxoo029557
	for <selinux@tycho.nsa.gov>; Sun, 1 Jul 2007 05:33:00 GMT
Message-ID: <46873C42.3020805@manicmethod.com>
Date: Sun, 01 Jul 2007 01:31:46 -0400
From: Joshua Brindle <method@manicmethod.com>
MIME-Version: 1.0
To: David Cottle <webmaster@aus-city.com>
CC: selinux@tycho.nsa.gov
Subject: Re: selinux AVC errors despite making a rule :(
References: <46872F11.8030906@aus-city.com>
In-Reply-To: <46872F11.8030906@aus-city.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

David Cottle wrote:
> Okay I got a server running FC6 and Plesk 8.1.1 running websites.
>
> I do a :
> grep avc /var/log/messages
> to see any policies need tweaking.
>
> I get:
> Jun 28 23:29:18 server kernel: audit(1183073358.302:2368: avc: denied {
> link } for pid=8544 comm="in.proftpd"
> scontext=system_u:system_r:ftpd_t:s0
> tcontext=system_u:system_r:crond_t:s0-s0:c0.c1023 tclass=key
>
> every single minute. Now I started a webcam that FTPs into the server
> every minute. So I thought no biggy, its in.proftpd, lets make a policy:
>
> grep proftpd /var/log/messages | audit2allow -M proftpd
> selinux -i proftpd.pp
>
> okay but i STILL get these errors every minute...
>
> Can someone please help me?
>   

Run audit2why on the denial and see where the denial is coming from, I 
suspect it is because of the MLS constraints in which case you need to 
figure out why they are in different levels or make ftpd_t a trusted mls 
subject.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
