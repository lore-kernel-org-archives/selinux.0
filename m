Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j35MWRDo013079
	for <selinux@tycho.nsa.gov>; Tue, 5 Apr 2005 18:32:27 -0400 (EDT)
Received: from postoffice9.mail.cornell.edu (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j35MUAGn008680
	for <selinux@tycho.nsa.gov>; Tue, 5 Apr 2005 22:30:13 GMT
Subject: Re: New Policy Patch
From: Ivan Gyurdiev <ivg2@cornell.edu>
Reply-To: ivg2@cornell.edu
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: jwcart2@epoch.ncsc.mil, SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <42519848.7080203@redhat.com>
References: <41E57081.4090500@redhat.com>
	 <1106339767.25125.31.camel@moss-lions.epoch.ncsc.mil>
	 <42518C8A.7040200@redhat.com> <1112643515.31122.3.camel@cobra.ivg2.net>
	 <42519848.7080203@redhat.com>
Content-Type: text/plain
Date: Tue, 05 Apr 2005 18:36:24 -0400
Message-Id: <1112740584.23438.1.camel@cobra.ivg2.net>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> Since we do not have that policy yet, we need this for strict to work, 
> correct?

Well, I did get a denial, and that fixes the denial, but I'm not
sure if it should be merged, given that the memory_device_t read
isn't allowed yet... 

-- 
Ivan Gyurdiev <ivg2@cornell.edu>
Cornell University


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
