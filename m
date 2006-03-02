Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k22GEZDQ014210
	for <selinux@tycho.nsa.gov>; Thu, 2 Mar 2006 11:14:37 -0500
Received: from e3.ny.us.ibm.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k22GD4d7018870
	for <selinux@tycho.nsa.gov>; Thu, 2 Mar 2006 16:13:05 GMT
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e3.ny.us.ibm.com (8.12.11/8.12.11) with ESMTP id k22GEWTX010000
	for <selinux@tycho.nsa.gov>; Thu, 2 Mar 2006 11:14:32 -0500
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay04.pok.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id k22GEWnF152416
	for <selinux@tycho.nsa.gov>; Thu, 2 Mar 2006 11:14:32 -0500
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11/8.13.3) with ESMTP id k22GEVI2019663
	for <selinux@tycho.nsa.gov>; Thu, 2 Mar 2006 11:14:31 -0500
Subject: Re: UDP API
From: Joy Latten <latten@austin.ibm.com>
To: Mark <elihusmails@gmail.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <9f066ee90603010640m3a979e78mf5a706176d2371c0@mail.gmail.com>
References: <9f066ee90603010640m3a979e78mf5a706176d2371c0@mail.gmail.com>
Content-Type: text/plain
Date: Thu, 02 Mar 2006 10:08:19 -0600
Message-Id: <1141315705.3075.18.camel@faith.austin.ibm.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Actually, each packet is labeled implicitly via IPSec Security
Associations. You can read more about the design from 
www.cse.psu.edu/~tjaeger/research/netmac.html

Feel free to email me any questions.

Regards,
Joy Latten

On Wed, 2006-03-01 at 09:40 -0500, Mark wrote:
> I have read that SE Linux supports the ability to label each UDP
> packet.  Is this true, and if so, where can I find API docs for doing
> so.
> 
> Thank you.
> 
> PS.  Is it possible to label TCP packets as well?
> 
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
