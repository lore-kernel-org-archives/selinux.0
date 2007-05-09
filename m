Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l49EERnC025099
	for <selinux@tycho.nsa.gov>; Wed, 9 May 2007 10:14:27 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l49EDnNF014523
	for <selinux@tycho.nsa.gov>; Wed, 9 May 2007 14:13:49 GMT
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.1/8.13.1) with ESMTP id l49EDPPM004778
	for <selinux@tycho.nsa.gov>; Wed, 9 May 2007 10:13:25 -0400
Received: from pobox-2.corp.redhat.com (pobox-2.corp.redhat.com [10.11.255.15])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l49EDPbw016618
	for <selinux@tycho.nsa.gov>; Wed, 9 May 2007 10:13:25 -0400
Received: from [10.11.14.127] (vpn-14-127.rdu.redhat.com [10.11.14.127])
	by pobox-2.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l49EDPrM005794
	for <selinux@tycho.nsa.gov>; Wed, 9 May 2007 10:13:25 -0400
Subject: Re: policyrep questions
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
To: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <1178663380.2379.11.camel@localhost.localdomain>
References: <1178663380.2379.11.camel@localhost.localdomain>
Content-Type: text/plain
Date: Wed, 09 May 2007 10:13:25 -0400
Message-Id: <1178720005.2379.37.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2007-05-08 at 18:29 -0400, Karl MacMillan wrote:
> 
> 3) The existing objects copy the passed in strings where I was hoping to
> avoid the copy. Any opinions either way? I'm currently leaning towards
> copying because that kind of change will create hard to track down bugs
> for no good reason.
> 

To make things more confusing - some of the existing code copies strings
while others do not. For example sepol_bool_set_name copies the string
while sepol_bool_key_create does not. I assume that the thought was that
the keys were temporary and likely to be populated from other sources
(existing bools, user input, etc.).

However - I think that this inconsistency is just confusing. I'm going
to change all of the functions to copy the strings. Changing in this
direction means the worst case is that a few strings will be leaked.

Karl


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
