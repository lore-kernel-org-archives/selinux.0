Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iBAIDNIi022173
	for <selinux@tycho.nsa.gov>; Fri, 10 Dec 2004 13:13:23 -0500 (EST)
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id iBAIDORA007021
	for <selinux@tycho.nsa.gov>; Fri, 10 Dec 2004 18:13:26 GMT
Message-ID: <41B9E730.4090602@redhat.com>
Date: Fri, 10 Dec 2004 13:13:04 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@epoch.ncsc.mil>
CC: Jim Carter <jwcart2@epoch.ncsc.mil>, Russell Coker <russell@coker.com.au>,
   Thomas Bleher <bleher@informatik.uni-muenchen.de>,
   SELinux <selinux@tycho.nsa.gov>
Subject: Re: can_network patch.
References: <41741A2C.8040408@redhat.com>	 <200410260138.19426.russell@coker.com.au>	 <20041025213122.GA2535@jmh.mhn.de>	 <200410270036.14935.russell@coker.com.au>	 <1099690788.16488.52.camel@moss-lions.epoch.ncsc.mil>	 <4192A029.5050909@redhat.com>	 <1100722524.22035.18.camel@moss-lions.epoch.ncsc.mil>	 <419CB2A8.7020504@redhat.com>	 <1101235934.7273.24.camel@moss-lions.epoch.ncsc.mil>	 <41A4B54F.3070709@redhat.com>	 <1101314370.22014.198.camel@moss-spartans.epoch.ncsc.mil>	 <41A4BCC9.10604@redhat.com>	 <1102693385.1628.102.camel@moss-spartans.epoch.ncsc.mil>	 <41B9D79F.9060801@redhat.com>	 <1102698638.1628.148.camel@moss-spartans.epoch.ncsc.mil>	 <41B9E48A.8010204@redhat.com> <1102701732.1628.167.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1102701732.1628.167.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:

>On Fri, 2004-12-10 at 13:01, Daniel J Walsh wrote:
>  
>
>>You can trigger it by executing
>> firefox selinux-policy-strict-1.19.12-1.src.rpm
>>    
>>
>
>Ok, but why would I want to do that?  Does firefox do that automatically
>for downloads?
>
>  
>
No,  It seems to happen if someone emails you a rpm, it actually is 
probably bad behavior.
I am going to talk to the desktop team and see what their ideas are.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
