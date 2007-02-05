Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l15KYXFl031386
	for <selinux@tycho.nsa.gov>; Mon, 5 Feb 2007 15:34:33 -0500
Received: from macii.ads-oh.atg.titan.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l15KZeBc014172
	for <selinux@tycho.nsa.gov>; Mon, 5 Feb 2007 20:35:40 GMT
Received: from [192.168.50.32] (macii.ads-oh.atg.titan.com [66.218.141.147])
	by macii.ads-oh.atg.titan.com (Postfix) with ESMTP id 52F501474C6
	for <selinux@tycho.nsa.gov>; Mon,  5 Feb 2007 19:54:09 +0000 (GMT)
Mime-Version: 1.0
Message-Id: <p06002042c1ed38b34ce4@[192.168.50.32]>
In-Reply-To: <1170690538.12293.281.camel@moss-spartans.epoch.ncsc.mil>
References: <p0600202dc1e90d941990@[192.168.50.32]>
 <1170690538.12293.281.camel@moss-spartans.epoch.ncsc.mil>
Date: Mon, 5 Feb 2007 14:44:11 -0500
To: selinux@tycho.nsa.gov
From: Rosalie Hiebel <rosalie.hiebel@L-3Com.com>
Subject: Re: audit2allow and mls
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

>On Fri, 2007-02-02 at 11:25 -0500, Rosalie Hiebel wrote:
>>  Is there version of audit2allow which is capable of generating 
>>rules specific
>>  to the mls policy?  I see that audit2allow's tests for mls  (calling
>>  get_mls_flag),
>>  but this is after the rules in the .te file have been generated.
>
>Not presently.  Ideally, audit2allow could check whether the denial was
>caused by a constraint (as done by audit2why via libsepol) and then try
>to determine a type attribute that could be used as an override, and
>then call the appropriate refpolicy interface to add that attribute to
>the domain.

Do you mean that audit2why does check the constrain rules in mls policy ?

>--
>Stephen Smalley
>National Security Agency
>
>
>--
>This message was distributed to subscribers of the selinux mailing list.
>If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
>the words "unsubscribe selinux" without quotes as the message.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
