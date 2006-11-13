Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id kADH7M1V022962
	for <selinux@tycho.nsa.gov>; Mon, 13 Nov 2006 12:07:22 -0500
Received: from e4.ny.us.ibm.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id kADH6bOD029936
	for <selinux@tycho.nsa.gov>; Mon, 13 Nov 2006 17:06:38 GMT
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e4.ny.us.ibm.com (8.13.8/8.12.11) with ESMTP id kADH7Xnj021018
	for <selinux@tycho.nsa.gov>; Mon, 13 Nov 2006 12:07:33 -0500
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay02.pok.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id kADH7Xhm269088
	for <selinux@tycho.nsa.gov>; Mon, 13 Nov 2006 12:07:33 -0500
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id kADH7Xxi016346
	for <selinux@tycho.nsa.gov>; Mon, 13 Nov 2006 12:07:33 -0500
Received: from [127.0.0.1] (pendarric.austin.ibm.com [9.41.46.130])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id kADH7WH8016236
	for <selinux@tycho.nsa.gov>; Mon, 13 Nov 2006 12:07:33 -0500
Message-ID: <4558A648.2070509@us.ibm.com>
Date: Mon, 13 Nov 2006 11:07:20 -0600
From: Michael C Thompson <thompsmc@us.ibm.com>
MIME-Version: 1.0
To: SE Linux <selinux@tycho.nsa.gov>
Subject: Specify default type for a role
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hey all,

So I did some looking and asking around, and I was informed that there 
is no way to specify the default type for a role in the policy (so that 
you don't have to manually change the default_type file).

If this is indeed the case, this seems like a prime area for SELinux 
policy tool enhancement (and probably the policy language itself needs 
an update?).

What do people think of this idea, to specify the default type 
associated with a role via the policy?

Thanks,
Mike


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
