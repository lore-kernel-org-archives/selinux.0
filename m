Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id NAA00081
	for <selinux@tycho.nsa.gov>; Thu, 12 Sep 2002 13:44:48 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id RAA25793
	for <selinux@tycho.nsa.gov>; Thu, 12 Sep 2002 17:43:27 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id RAA25789
	for <selinux@tycho.nsa.gov>; Thu, 12 Sep 2002 17:43:26 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: <rwashington@crucialsecurity.com>, <selinux@tycho.nsa.gov>
Subject: Re: http domain
Date: Thu, 12 Sep 2002 19:44:34 +0200
References: <DPEPJAJGOCGHICPODIHPGEFFCBAA.rwashington@crucialsecurity.com>
In-Reply-To: <DPEPJAJGOCGHICPODIHPGEFFCBAA.rwashington@crucialsecurity.com>
MIME-Version: 1.0
Message-Id: <200209121944.34020.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 12 Sep 2002 19:02, Ryan Washington wrote:
> Does the standard install of SELinux already have the domain set for http?
> If so, to get it started, all I need to do is to enforce the default
> policy? thanks,

The default policy includes support for Apache.

But of course if you do anything serious you'll need to make changes anyway.


Russell Coker


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
