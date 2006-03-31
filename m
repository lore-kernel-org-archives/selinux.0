Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k2VH3oi3019866
	for <selinux@tycho.nsa.gov>; Fri, 31 Mar 2006 12:03:50 -0500
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k2VH25eG024261
	for <selinux@tycho.nsa.gov>; Fri, 31 Mar 2006 17:02:05 GMT
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.12.11.20060308/8.12.11) with ESMTP id k2VH3nJP020188
	for <selinux@tycho.nsa.gov>; Fri, 31 Mar 2006 12:03:49 -0500
Message-ID: <442D60EF.1030303@redhat.com>
Date: Fri, 31 Mar 2006 12:03:43 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: tscherf@redhat.com
CC: SE Linux <selinux@tycho.nsa.gov>,
        "Fedora SELinux support list for users & developers." <fedora-selinux-list@redhat.com>
Subject: Re: AVC Decision Tree.
References: <442C36AF.4090001@redhat.com> <1143798266.3145.12.camel@tiffy.tuxgeek.de>
In-Reply-To: <1143798266.3145.12.camel@tiffy.tuxgeek.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Thorsten Scherf wrote:
> On Thu, 2006-03-30 at 14:51 -0500, Daniel J Walsh wrote:
>   
>> http://fedoraproject.org/wiki/SELinux/Troubleshooting/AVCDecisions#preview
>>
>> Trying to build a analysys tool to be able to translate avc messages 
>> into possible boolean/file_context solutions.
>>
>> The idea is that we can look at the AVC messages that are generated and 
>> figure out what the servers were trying to do.  Then we can give some 
>> advise to the administrator on the corrective measures.  So what we are 
>> looking for are expected code paths where there is a file context of 
>> boolean available.
>>     
>
> Usually if a AVC denied is fixed with a corresponding rule, the next AVC
> comes up in the log (allow getattr, after that ACV:denied read, and so
> on). Probably we don't want to annoy the administrator with several
> pop-ups coming up on his screen.
>
> What do you think about that?
>
>   
Yes the idea would be to continue gathering all of the AVC's while the 
app is running.  I do not believe they will be able
close the window faster than the AVC MEssages.  The app should have a 
disable button built in so that if their is a real labeling problem, it 
will not keep popping up.  So we will have to watch our usability. :^)  
But hopefully there will not be a lot of AVC messages :^)

Dan

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
