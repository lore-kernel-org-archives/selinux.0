Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k8EKlP9Y017663
	for <selinux@tycho.nsa.gov>; Thu, 14 Sep 2006 16:47:25 -0400
Received: from legolas.drinsama.de (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k8EKkWJg016106
	for <selinux@tycho.nsa.gov>; Thu, 14 Sep 2006 20:46:32 GMT
Subject: Re: Moving xconsole from xserver to logging policy
From: Erich Schubert <erich@debian.org>
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
Cc: SELinux List <selinux@tycho.nsa.gov>
In-Reply-To: <1158240772.26420.102.camel@sgc.columbia.tresys.com>
References: <1158162208.1594.37.camel@wintermute.xmldesign.de>
	 <1158164561.26420.72.camel@sgc.columbia.tresys.com>
	 <1158166443.1594.51.camel@wintermute.xmldesign.de>
	 <1158167487.26420.75.camel@sgc.columbia.tresys.com>
	 <1158174972.1594.61.camel@wintermute.xmldesign.de>
	 <1158240772.26420.102.camel@sgc.columbia.tresys.com>
Content-Type: text/plain; charset=ISO-8859-15
Date: Thu, 14 Sep 2006 22:46:29 +0200
Message-Id: <1158266789.32661.9.camel@wintermute.xmldesign.de>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,
Another reason why that usage you mentioned is broken - it's not
multi-user compatible. They definitely should use a fifo in their home
directory.

> Regardless if this is a good use or not, having a xconsole without an
> xserver makes no sense.

How about displaying the information remotely?
There are so many uses for fifos...

best regards,
Erich Schubert
-- 
   erich@(vitavonni.de|debian.org)    --    GPG Key ID: 4B3A135C    (o_
     The future is here. It's just not evenly distributed yet.      //\
            Ohne Tränen hat die Seele keinen Regenbogen.            V_/_



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
