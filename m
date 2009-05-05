Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n45JwcRx022583
	for <selinux@tycho.nsa.gov>; Tue, 5 May 2009 15:58:38 -0400
Received: from mx2.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id n45Jwbi8006393
	for <selinux@tycho.nsa.gov>; Tue, 5 May 2009 19:58:37 GMT
Message-ID: <4A009A68.9000101@redhat.com>
Date: Tue, 05 May 2009 15:58:32 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Bandan Das <bandan.das@stratus.com>
CC: selinux <selinux@tycho.nsa.gov>,
        "Johnson, Richard" <Richard.Johnson@stratus.com>
Subject: Re: Using interfaces defined elsewhere
References: <1241551556.23813.80.camel@BSD.mno.stratus.com>
In-Reply-To: <1241551556.23813.80.camel@BSD.mno.stratus.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 05/05/2009 03:25 PM, Bandan Das wrote:
> Hello,
>
> Here's what I am trying to do :
>
> I have a mySNMP policy with sources: mysnmp.te mysnmp.fc mysnmp.if and a
> dummyapp policy with sources: dummyapp.te dummyapp.fc and dummyapp.if.
> The SNMP policy interface file has an interface called
> mysnmp_config_read_access() and I would like to use it in my dummyapp
> policy sources : mysnmp_config_read_access(dummyapp_t)
>
> What's the best way to do this ? Not just for the above example for a
> case where I have multiple custom interface files.
>
> I tried copying the SNMP interface file
> to /usr/share/selinux/include/mysnmp. But the problem with this approach
> is that I have to be root to be able to do this. Can I ask make to use
> multiple interface files (dummyapp.if and mysnmp.if) when compiling the
> dummyapp policy module ?
>
> Thanks,
> Bandan
>
>
The make file will also look in the current directory for .if files.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
