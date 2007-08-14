Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l7E6Ein4016416
	for <selinux@tycho.nsa.gov>; Tue, 14 Aug 2007 02:14:44 -0400
Received: from moutng.kundenserver.de (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l7E6EgFQ025262
	for <selinux@tycho.nsa.gov>; Tue, 14 Aug 2007 06:14:43 GMT
Mime-Version: 1.0 (Apple Message framework v752.2)
Message-Id: <D7B1D472-6E9E-407F-B9DE-E7D6B100F0CC@sf-net.com>
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
To: SELinux List <selinux@tycho.nsa.gov>
From: Stefan Schulze Frielinghaus <stefan@sf-net.com>
Subject: [refpolicy] apt and rpm
Date: Tue, 14 Aug 2007 08:14:34 +0200
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello,

I'm trying to fix the rules for apt and I have some questions  
regarding how "rpm allow-rules" work.

For example the last update was about the loadkeys package. In  
permissive mode I get the following failures while updating:

allow loadkeys_t apt_t:fd use;
allow loadkeys_t apt_t:fifo_file write;
allow loadkeys_t devpts_t:dir search;
allow loadkeys_t dpkg_t:fd use;
allow loadkeys_t dpkg_t:fifo_file { read write };
allow loadkeys_t newrole_t:fd use;
allow loadkeys_t sysadm_devpts_t:chr_file { read write };

With other updates I get nearly the same errors. I beliefe that these  
problems had rpm too. Because every package apt/rpm tries to exchange/ 
restart a file descriptor etc. will be needed. I could add for every  
domain a apt_read_pipes(*) but I think this is _not_ the SELinux way ;-)

How could I solve these ones? Is there an interface which regards  
other programs more power while speaking with apt/rpm?

cheers,
Stefan

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
