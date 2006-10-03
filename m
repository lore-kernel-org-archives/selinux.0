Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k93LY1Lf027260
	for <selinux@tycho.nsa.gov>; Tue, 3 Oct 2006 17:34:01 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k93LXQGw017313
	for <selinux@tycho.nsa.gov>; Tue, 3 Oct 2006 21:33:27 GMT
Message-ID: <4522D619.2020001@mentalrootkit.com>
Date: Tue, 03 Oct 2006 17:28:57 -0400
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
MIME-Version: 1.0
To: Joshua Brindle <method@gentoo.org>
CC: Linda Knippers <linda.knippers@hp.com>, Joy Latten <latten@austin.ibm.com>,
        eparis@parisplace.org, redhat-lspp@redhat.com, selinux@tycho.nsa.gov,
        jmorris@namei.org, paul.moore@hp.com, vyekkirala@TrustedCS.com
Subject: Re: RHEL5 Kernel with labeled networking
References: <200610031837.k93Ib7cQ003247@faith.austin.ibm.com>	 <4522B79C.2060405@gentoo.org> <1159902988.29928.2.camel@faith.austin.ibm.com> <4522CAB7.6090109@hp.com> <4522D554.7080708@gentoo.org>
In-Reply-To: <4522D554.7080708@gentoo.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Joshua Brindle wrote:
>
> Linda Knippers wrote:
<snip>
>>
>> If we go the auditallow route then we lose some audit record management
>> features, like the ability to enable/disble/search for these records,
>> don't we?  Do we care?
>>
>>   
> enable and disable with a boolean
>
> searching? surely you can search avc records..
>

Of course - the avc records are just audit records so the searching / 
reduction / etc. should be fine with the existing audit tools.

Karl


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
