Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l3HKJGSm027727
	for <selinux@tycho.nsa.gov>; Tue, 17 Apr 2007 16:19:16 -0400
Received: from e32.co.us.ibm.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l3HKJFW2000675
	for <selinux@tycho.nsa.gov>; Tue, 17 Apr 2007 20:19:15 GMT
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com [9.17.195.227])
	by e32.co.us.ibm.com (8.12.11.20060308/8.13.8) with ESMTP id l3HKGZJK014422
	for <selinux@tycho.nsa.gov>; Tue, 17 Apr 2007 16:16:35 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id l3HKJEgJ163882
	for <selinux@tycho.nsa.gov>; Tue, 17 Apr 2007 14:19:14 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l3HKJ86m009034
	for <selinux@tycho.nsa.gov>; Tue, 17 Apr 2007 14:19:08 -0600
Message-ID: <46252BB5.1070407@us.ibm.com>
Date: Tue, 17 Apr 2007 15:19:01 -0500
From: Michael C Thompson <thompsmc@us.ibm.com>
MIME-Version: 1.0
To: Xavier Toth <txtoth@gmail.com>
CC: selinux@tycho.nsa.gov
Subject: Re: directory polyinstantiation failure
References: <cadfc0e40704171107l770c48cak16f504b6b0a0dcc0@mail.gmail.com> <46251650.7000509@us.ibm.com> <cadfc0e40704171223r5b566441p276426561ec21290@mail.gmail.com>
In-Reply-To: <cadfc0e40704171223r5b566441p276426561ec21290@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Xavier Toth wrote:
> If you try and use $HOME in the directory name for instance
> $HOME/.mozilla the $HOME is not expanded. I'll submit a patch.

Nice find, thank you for the patch. :)

Mike

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
