Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j05GeoIi003094
	for <selinux@tycho.nsa.gov>; Wed, 5 Jan 2005 11:40:50 -0500 (EST)
Received: from moss-lions.epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j05GeqBa010458
	for <selinux@tycho.nsa.gov>; Wed, 5 Jan 2005 16:40:52 GMT
Subject: Re: iptables and assertions
From: James Carter <jwcart2@epoch.ncsc.mil>
Reply-To: jwcart2@epoch.ncsc.mil
To: Russell Coker <russell@coker.com.au>
Cc: SE-Linux <selinux@tycho.nsa.gov>
In-Reply-To: <200412250435.28809.russell@coker.com.au>
References: <200412250435.28809.russell@coker.com.au>
Content-Type: text/plain
Message-Id: <1104943357.1511.2.camel@moss-lions.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Wed, 05 Jan 2005 11:42:37 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2004-12-24 at 12:35, Russell Coker wrote:
> allow iptables_t bin_t:file { execute execute_no_trans };
> 

I've removed this rule for now.

> The above line has been in the iptables policy for ages (I think since it was 
> ipchains_t).  Is it still needed?  My tests seem to indicate that it is not 
> needed any more.
> 
> If we remove the above line we can add the following to assert.te:
> ifdef(`iptables.te', `assert_execute(iptables)')
> 
> Also the following seems appropriate for assert.te:
> ifdef(`ifconfig.te', `assert_execute(ifconfig)')
-- 
James Carter <jwcart2@epoch.ncsc.mil>
National Security Agency

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
