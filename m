Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h9KDNdWt019686
	for <selinux@tycho.nsa.gov>; Mon, 20 Oct 2003 09:23:39 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h9KDNR0p026020
	for <selinux@tycho.nsa.gov>; Mon, 20 Oct 2003 13:23:27 GMT
Received: from tooheys.dsl.net (tooheys.dsl.net [65.84.81.1])
	by jazzswing.ncsc.mil  with ESMTP id h9KDNQr7026017
	for <selinux@tycho.nsa.gov>; Mon, 20 Oct 2003 13:23:26 GMT
Message-ID: <3F93E21C.4020405@tresys.com>
Date: Mon, 20 Oct 2003 09:24:44 -0400
From: David Caplan <dac@tresys.com>
MIME-Version: 1.0
To: faye@lurking-grue.org
Cc: selinux@tycho.nsa.gov
Subject: Re: Number of roles reported by checkpolicy
References: <200310201900.27621.faye@lurking-grue.org>
In-Reply-To: <200310201900.27621.faye@lurking-grue.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov



Faye Coker wrote:
> Running checkpolicy shows I have 4 users and 5 roles:
> 
> faye@kaos:/etc/selinux$ checkpolicy
> checkpolicy:  loading policy configuration from policy.conf
> security:  4 users, 5 roles, 683 types
> security:  29 classes, 71806 rules
> 
> however, I can only see four roles:
> 
> faye@kaos:/etc/selinux$ grep ^role policy.conf|cut -f2 "-d "|sort -u
> staff_r
> sysadm_r
> system_r
> user_r
> 
> Any ideas as to why checkpolicy is reporting five roles, when I can only see 
> four?
> 

object_r is inserted as the first role into the role table (see 
roles_init() in .../checkpolicy/policydb.c) when the policy database is 
initialized.

David

__________________________________

David Caplan     410 290 1411 x105
dac@tresys.com
Tresys Technology, LLC
8840 Stanford Blvd., Suite 2100
Columbia, MD 21045


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
