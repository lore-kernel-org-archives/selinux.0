Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l3HImJRW022768
	for <selinux@tycho.nsa.gov>; Tue, 17 Apr 2007 14:48:19 -0400
Received: from e35.co.us.ibm.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l3HImGW2010916
	for <selinux@tycho.nsa.gov>; Tue, 17 Apr 2007 18:48:17 GMT
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com [9.17.195.227])
	by e35.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l3HImFb2019780
	for <selinux@tycho.nsa.gov>; Tue, 17 Apr 2007 14:48:16 -0400
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id l3HImFFN156424
	for <selinux@tycho.nsa.gov>; Tue, 17 Apr 2007 12:48:15 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l3HIlxL5028324
	for <selinux@tycho.nsa.gov>; Tue, 17 Apr 2007 12:47:59 -0600
Message-ID: <46251650.7000509@us.ibm.com>
Date: Tue, 17 Apr 2007 13:47:44 -0500
From: Michael C Thompson <thompsmc@us.ibm.com>
MIME-Version: 1.0
To: Xavier Toth <txtoth@gmail.com>
CC: selinux@tycho.nsa.gov
Subject: Re: directory polyinstantiation failure
References: <cadfc0e40704171107l770c48cak16f504b6b0a0dcc0@mail.gmail.com>
In-Reply-To: <cadfc0e40704171107l770c48cak16f504b6b0a0dcc0@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Xavier Toth wrote:
> pam_namespace complains that "Pathnames must start with '/'" when I
> try and polyinstantiate "$HOME/$USER/.mozilla". Is there a particular
> reason that I shouldn't be able to polyinstantiate a dot directory or
> is this a bug?

AFAIK, there is no reason that polyinstantiating shouldn't work for dot 
directories.

Mike

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
