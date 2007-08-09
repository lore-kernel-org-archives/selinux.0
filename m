Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l79JKvZE001364
	for <selinux@tycho.nsa.gov>; Thu, 9 Aug 2007 15:20:57 -0400
Received: from smtp112.sbc.mail.re2.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id l79JKtVe029170
	for <selinux@tycho.nsa.gov>; Thu, 9 Aug 2007 19:20:55 GMT
In-Reply-To: <46BB43F9.7010905@trustedcs.com>
References: <46BB43F9.7010905@trustedcs.com>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <CC6496B2-938D-4432-B43E-3A7D887BE938@nall.com>
Cc: James Morris <jmorris@namei.org>, Stephen Smalley <sds@tycho.nsa.gov>,
        Paul Moore <paul.moore@hp.com>, SE Linux <selinux@tycho.nsa.gov>,
        kaigai@ak.jp.nec.com, Eric Paris <eparis@parisplace.org>
From: Joe Nall <joe@nall.com>
Subject: Re: [RFC 0/5] Static/fallback external labels for NetLabel
Date: Thu, 9 Aug 2007 14:20:09 -0500
To: Darrel Goeddel <DGoeddel@TrustedCS.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Aug 9, 2007, at 11:42 AM, Darrel Goeddel wrote:

>  (why couldn't this have all waited a bit...)

Paul is addressing a real need. Like many things that really need  
doing and take time, multiple people are simultaneously working on it.

I installed the netlabel patches and have tested them with good  
results in MLS/permissive at a few levels (s0, s2:c0.c253,  
s2:c0.c253). More testing to follow.

netlabelctl unlbl add interface:eth0 address:10.211.55.8/32  
label:user_u:object_r:user_t:s2:c0.c253

/netlabelctl unlbl list
accept:on
interface:eth0,address: 
192.168.20.253/32,label:"user_u:object_r:user_t:s0"
interface:eth0,address: 
10.211.55.8/32,label:"user_u:object_r:user_t:s2:c0.c253"

getpeercon() returned 'user_u:object_r:user_t:C O N F I D E N T I A L'

for a connection from 10.211.55.8.

This is a big improvement in linux labeled networking functionality.

joe

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
