Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id k0QEWUXf023647
	for <selinux@tycho.nsa.gov>; Thu, 26 Jan 2006 09:32:30 -0500 (EST)
Received: from web51510.mail.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id k0QEVIZV018793
	for <selinux@tycho.nsa.gov>; Thu, 26 Jan 2006 14:31:18 GMT
Message-ID: <20060126143159.68774.qmail@web51510.mail.yahoo.com>
Date: Thu, 26 Jan 2006 06:31:59 -0800 (PST)
From: Steve G <linux_4ever@yahoo.com>
Subject: RE: password policy question
To: Stephen Smalley <sds@tycho.nsa.gov>, Chad Hanson <chanson@TrustedCS.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1138214951.13075.50.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


>In the case of other passwd file fields settable via chfn/chsh and some 
>forms of the passwd program (not sure about the RH one), you can leak
>arbitrary plaintext (subject only to length limitations).

Out of curiosity...is anyone doing any covert channel analysis? Even if no one
is, we should start collecting this information as a starting point for people
that will ultimately do this.

-Steve

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
