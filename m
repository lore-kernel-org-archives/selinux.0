Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id k04GXKXf004983
	for <selinux@tycho.nsa.gov>; Wed, 4 Jan 2006 11:33:21 -0500 (EST)
Received: from web51514.mail.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id k04GOmKt008767
	for <selinux@tycho.nsa.gov>; Wed, 4 Jan 2006 16:24:48 GMT
Message-ID: <20060104162257.8468.qmail@web51514.mail.yahoo.com>
Date: Wed, 4 Jan 2006 08:22:57 -0800 (PST)
From: Steve G <linux_4ever@yahoo.com>
Subject: Re: SELinux & SuSE
To: Clif Flynt <clif@cflynt.com>, selinux@tycho.nsa.gov
In-Reply-To: <20060103142622.GA29438@clif.cflynt.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


>I need to configure a SuSE workstation to meet NISPOM security standards.

You can meet NISPOM without SE Linux. NISPOM has a lot of auditing requirements
mostly centered around logging in and out of machines, automated audit reporting,
and automated blacklisting (pam_tally). FWIW, you can meet it with FC4.

-Steve


		
__________________________________________ 
Yahoo! DSL – Something to write home about. 
Just $16.99/mo. or less. 
dsl.yahoo.com 


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
