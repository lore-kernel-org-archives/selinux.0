Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j1LDO4dW017346
	for <selinux@tycho.nsa.gov>; Mon, 21 Feb 2005 08:24:04 -0500 (EST)
Received: from postoffice9.mail.cornell.edu (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j1LDLq3J027197
	for <selinux@tycho.nsa.gov>; Mon, 21 Feb 2005 13:21:52 GMT
Subject: Re: Java Legacy problem
From: Ivan Gyurdiev <ivg2@cornell.edu>
Reply-To: ivg2@cornell.edu
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: Luke Kenneth Casson Leighton <lkcl@lkcl.net>, selinux@tycho.nsa.gov
In-Reply-To: <4219DB94.1090906@redhat.com>
References: <1108910713.3610.18.camel@cobra.ivg2.net>
	 <20050220154458.GH14038@lkcl.net> <1108914838.5275.10.camel@cobra.ivg2.net>
	 <20050220171743.GJ14038@lkcl.net>  <4219DB94.1090906@redhat.com>
Content-Type: text/plain
Date: Mon, 21 Feb 2005 08:24:17 -0500
Message-Id: <1108992257.26875.0.camel@cobra.ivg2.net>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


>
>This is a case where we may want to give an application more rights then 
>user_t.
>The java_user_t should be user_t + (execmem/execmod privs)

Maybe we should just ask Sun to fix it?

-- 
Ivan Gyurdiev <ivg2@cornell.edu>
Cornell University


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
