Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j12Gfb53023848
	for <selinux@tycho.nsa.gov>; Wed, 2 Feb 2005 11:41:37 -0500 (EST)
Received: from postoffice9.mail.cornell.edu (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j12GdMVb018601
	for <selinux@tycho.nsa.gov>; Wed, 2 Feb 2005 16:39:29 GMT
Subject: Re: File Browsing apps and getattr
From: Ivan Gyurdiev <ivg2@cornell.edu>
Reply-To: ivg2@cornell.edu
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: Stephen Smalley <sds@epoch.ncsc.mil>, selinux@tycho.nsa.gov
In-Reply-To: <4200FE30.7040405@redhat.com>
References: <1107210369.1928.5.camel@cobra.ivg2.net>
	 <1107259894.26936.27.camel@moss-spartans.epoch.ncsc.mil>
	 <1107263308.6722.5.camel@cobra.ivg2.net>
	 <1107263499.26936.50.camel@moss-spartans.epoch.ncsc.mil>
	 <1107264384.6956.2.camel@cobra.ivg2.net>
	 <1107264676.26936.63.camel@moss-spartans.epoch.ncsc.mil>
	 <1107283354.7117.13.camel@cobra.ivg2.net>
	 <1107287529.26936.231.camel@moss-spartans.epoch.ncsc.mil>
	 <1107301148.3429.10.camel@cobra.ivg2.net>
	 <1107345834.890.9.camel@moss-spartans.epoch.ncsc.mil>
	 <1107350380.7449.2.camel@cobra.ivg2.net>  <4200DEA2.1080008@redhat.com>
	 <1107354157.890.133.camel@moss-spartans.epoch.ncsc.mil>
	 <4200E589.8000207@redhat.com> <1107360093.14674.8.camel@cobra.ivg2.net>
	 <4200FE30.7040405@redhat.com>
Content-Type: text/plain
Date: Wed, 02 Feb 2005 09:41:31 -0700
Message-Id: <1107362491.4031.6.camel@cobra.ivg2.net>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> Doing ls of Kerberos keyfiles, certs and shadow or any other security 
> file should probably be audited in
> a strict policy, because the next thing would be an attempt at a read. 

Doing ls -l /etc does not imply attempted read of shadow.
Furthermore the read would be audited so I don't see the problem. 
The getattr would be denied, so Stephen Smalley's concern about 
information flow is addressed.

> It might be usefull to know that the
> latest mozilla plugin is poking around some more secure files.  
> Dontaudit would just cover this up.

You're still auditing { read write } on files.

-- 
Ivan Gyurdiev <ivg2@cornell.edu>
Cornell University


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
