Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j4VNxpgA010727
	for <selinux@tycho.nsa.gov>; Tue, 31 May 2005 19:59:51 -0400 (EDT)
Received: from open.hands.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j4VNrpC0019176
	for <selinux@tycho.nsa.gov>; Tue, 31 May 2005 23:53:52 GMT
Date: Wed, 1 Jun 2005 01:02:31 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Chad Sellers <chad@thesellers.net>
Cc: selinux@tycho.nsa.gov
Subject: Re: file_type_auto_trans is not sufficient
Message-ID: <20050601000231.GA8278@lkcl.net>
References: <200505311412.j4VECK5F030983@gotham.columbia.tresys.com> <1117551440.15167.25.camel@dhcp83-8.boston.redhat.com> <20050531212112.GF11815@lkcl.net> <79483BF9-8FE1-46B8-BD6C-20C98BD6F7A8@thesellers.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <79483BF9-8FE1-46B8-BD6C-20C98BD6F7A8@thesellers.net>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, May 31, 2005 at 07:09:43PM -0400, Chad Sellers wrote:
> That said, this doesn't solve Ivan's problem.  You still have a  
> single application (gconfd in his example) creating /tmp/gconfd and / 
> tmp/orbit, with only one type transition rule allowed.  You can't  
> mount /tmp/gconfd over /tmp for portions of execution, and then /tmp/ 
> orbit over /tmp for other parts of execution.

 drat - duh, course you can't.

 "transitional" library it is, then.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
