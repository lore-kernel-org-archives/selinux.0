Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k8SFLiYq020092
	for <selinux@tycho.nsa.gov>; Thu, 28 Sep 2006 11:21:44 -0400
Received: from bay0-omc2-s16.bay0.hotmail.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k8SFLBLE013073
	for <selinux@tycho.nsa.gov>; Thu, 28 Sep 2006 15:21:11 GMT
Message-ID: <BAY114-F6D03603069FF329A71681AF1B0@phx.gbl>
From: "Salvo Giuffrida" <giuffsalvo@hotmail.it>
To: selinux@tycho.nsa.gov
Subject: run_init, and benchmarking
Date: Thu, 28 Sep 2006 17:21:37 +0200
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Why is there such a command like run_init? I mean, even if I directly start 
a service through /etc/init.d/nameservice start, shouldn't there be a domain 
transition (automatic, through type_transition statements) that places the 
process in the right security context?
Another thing: what is the impact on performance of the Security Server-AVC 
control? What is the percentage in comparison on a "normal" Linux? Is there 
such a site with benchmarks on this?
Thanks a lot

_________________________________________________________________
Cerchi un campeggio per le tue vacanze? 
http://search.msn.it/results.aspx?q=campeggio&FORM=MSNH&CP=1252&srch_type=0


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
