Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m7DEPuDo021020
	for <selinux@tycho.nsa.gov>; Wed, 13 Aug 2008 10:25:59 -0400
Received: from goalkeeper.city-fan.org (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id m7DEPbZR014492
	for <selinux@tycho.nsa.gov>; Wed, 13 Aug 2008 14:25:39 GMT
Message-ID: <48A2EEE3.1020909@city-fan.org>
Date: Wed, 13 Aug 2008 15:25:39 +0100
From: Paul Howarth <paul@city-fan.org>
MIME-Version: 1.0
To: Chris PeBenito <pebenito@gentoo.org>
CC: Dominick Grift <domg472@gmail.com>, selinux@tycho.nsa.gov
Subject: Re: [REFPOLICY PATCH] Added policy module for the oident daemon.
References: <1217077669.8496.2.camel@sulphur.notebook.internal> <1218632939.5144.10.camel@defiant.pebenito.net>
In-Reply-To: <1218632939.5144.10.camel@defiant.pebenito.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Chris PeBenito wrote:
> On Sat, 2008-07-26 at 15:07 +0200, Dominick Grift wrote:
>> Signed-off-by: Dominick Grift <domg472@gmail.com>
> 
> The patch looks line-wrapped.  Also a couple comments inline.

...

>> +tunable_policy(`oidentd_read_unprivileged_user_home_content_files', `
>> +	# ~/.oidentd.conf
>> +	userdom_read_unpriv_users_home_content_files(oidentd_t)
>> +')
> 
> Why is this last bit needed?  Why would a system service be reading a
> conf file from a user's home dir?

It's reading ~/.oidentd.conf, which allows a user great control over the 
responses the daemon returns when queried about connections related to 
that user.

http://linux.die.net/man/5/oidentd.conf

Paul.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
