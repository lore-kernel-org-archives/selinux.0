Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m8NNWLVh010378
	for <selinux@tycho.nsa.gov>; Tue, 23 Sep 2008 19:32:21 -0400
Received: from mail-in02.adhost.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m8NNWLNk009328
	for <selinux@tycho.nsa.gov>; Tue, 23 Sep 2008 23:32:21 GMT
Received: from ad-exh01.adhost.lan (exchange.adhost.com [216.211.143.69])
	by mail-in02.adhost.com (Postfix) with ESMTP id EBD061EE824
	for <selinux@tycho.nsa.gov>; Tue, 23 Sep 2008 16:32:17 -0700 (PDT)
	(envelope-from mikesw@adhost.com)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: How to find SELinux policy type?
Date: Tue, 23 Sep 2008 16:32:16 -0700
Message-ID: <17838240D9A5544AAA5FF95F8D52031604BE24FD@ad-exh01.adhost.lan>
In-Reply-To: <alpine.LRH.1.10.0809240910240.32319@tundra.namei.org>
References: <alpine.LRH.1.10.0809240910240.32319@tundra.namei.org>
From: "Mike Sweetser - Adhost" <mikesw@adhost.com>
To: <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

James,

The following command set should give you what you want:

grep '^SELINUXTYPE' /etc/selinux/config | awk '{split($0,a,"="); print
a[2];}'

When run against my targeted setup on RHEL 5.2, it gave me back
"targeted".

--------------------------
Mike Sweetser | Systems Administrator

Adhost Internet
140 Fourth Avenue North, Suite 360, Seattle, Washington 98109 USA
P 206.404.9000    T 888.234.6781 (ADHOST-1)    F 206.404.9050
E mikesw@adhost.com    W adhost.com

Our brand new Adhost West data center is open - contact us for a tour at
1-888-234-6781 (ADHOST-1)


-----Original Message-----
From: owner-selinux@tycho.nsa.gov [mailto:owner-selinux@tycho.nsa.gov]
On Behalf Of James Morris
Sent: Tuesday, September 23, 2008 4:13 PM
To: selinux@tycho.nsa.gov
Subject: How to find SELinux policy type?

Is there a programmatic way to determine the type of SELinux policy 
configured on a system? (e.g. "targeted")

I've looked in the SELinux userspace and SETools repositories but not 
found a library call to do this.


- James
-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov
with
the words "unsubscribe selinux" without quotes as the message.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
