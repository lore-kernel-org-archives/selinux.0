Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h9EHQlWt020010
	for <selinux@tycho.nsa.gov>; Tue, 14 Oct 2003 13:26:48 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h9EHQimR018313
	for <selinux@tycho.nsa.gov>; Tue, 14 Oct 2003 17:26:44 GMT
Received: from ms-smtp-02-eri0.southeast.rr.com (ms-smtp-02.southeast.rr.com [24.93.67.83])
        by jazzband.ncsc.mil  with ESMTP id h9EHQejp018305 for <selinux@tycho.nsa.gov>; Tue, 14 Oct 2003 17:26:41 GMT
Received: from nc.rr.com (rdu26-59-021.nc.rr.com [66.26.59.21])
	by ms-smtp-02-eri0.southeast.rr.com (8.12.10/8.12.7) with ESMTP id h9EHQe9j026963
	for <selinux@tycho.nsa.gov>; Tue, 14 Oct 2003 13:26:40 -0400 (EDT)
Message-ID: <3F8C31D0.2080209@nc.rr.com>
Date: Tue, 14 Oct 2003 13:26:40 -0400
From: Jeff Johnson <n3npq@nc.rr.com>
MIME-Version: 1.0
To: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: trusted vs untrusted packages
References: <Xine.LNX.4.44.0310140805090.1093-100000@thoron.boston.redhat.com>
In-Reply-To: <Xine.LNX.4.44.0310140805090.1093-100000@thoron.boston.redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

James Morris wrote:

>On Tue, 14 Oct 2003, Russell Coker wrote:
>
>  
>
>>Now this raises some interesting issues.  If a signed package has a program 
>>which relies on some other program (and has a dependency), what happens if 
>>the dependency is satisfied by an unsigned package?  Installing the unsigned 
>>package may not result in the system being fully functional (execution of the 
>>file in question may be denied).
>>    
>>
>
>This should be like enforcing vs. non-enforcing -- you either want all of
>your packages signed (and the above would fail) or not (just generate a
>warning).
>  
>

Not true. The signature mechanism is different than the trust model. 
Existence of
signature, or constraint of all all packages must be signed, is not an 
adequate definition
of "trust".

73 de Jeff



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
