Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j1KFrmdW014027
	for <selinux@tycho.nsa.gov>; Sun, 20 Feb 2005 10:53:48 -0500 (EST)
Received: from postoffice9.mail.cornell.edu (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j1KFpoq7012192
	for <selinux@tycho.nsa.gov>; Sun, 20 Feb 2005 15:51:50 GMT
Subject: Re: Java Legacy problem
From: Ivan Gyurdiev <ivg2@cornell.edu>
Reply-To: ivg2@cornell.edu
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Cc: selinux@tycho.nsa.gov, dwalsh@redhat.com
In-Reply-To: <20050220154458.GH14038@lkcl.net>
References: <1108910713.3610.18.camel@cobra.ivg2.net>
	 <20050220154458.GH14038@lkcl.net>
Content-Type: text/plain
Date: Sun, 20 Feb 2005 10:53:58 -0500
Message-Id: <1108914838.5275.10.camel@cobra.ivg2.net>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 2005-02-20 at 15:44 +0000, Luke Kenneth Casson Leighton wrote:
>if i was dealing with it, i would create a macro - mozilla_java_domain
>with an argument $1 which takes the role (see usage of mozilla_domain).

Hi Luke. 
Perhaps my mail did not make it clear - I am interested in java usage
outside mozilla. The mozilla java policy already exists and works.
However that policy is not used to transition from user_t/staff_t. 
Furthermore, Dan Walsh has argued that it should not be used
for that purpose.
>
-- 
Ivan Gyurdiev <ivg2@cornell.edu>
Cornell University


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
