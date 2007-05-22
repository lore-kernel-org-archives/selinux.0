Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l4MFH76W018230
	for <selinux@tycho.nsa.gov>; Tue, 22 May 2007 11:17:07 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id l4MFH5RP020048
	for <selinux@tycho.nsa.gov>; Tue, 22 May 2007 15:17:05 GMT
Message-ID: <465308DD.2090600@manicmethod.com>
Date: Tue, 22 May 2007 11:14:37 -0400
From: Joshua Brindle <method@manicmethod.com>
MIME-Version: 1.0
To: Todd Miller <Tmiller@tresys.com>
CC: Klaus Weidner <klaus@atsec.com>, James Antill <jantill@redhat.com>,
        Paul Moore <paul.moore@hp.com>, SE Linux <selinux@tycho.nsa.gov>,
        Daniel J Walsh <dwalsh@redhat.com>
Subject: Re: Fedora Core 7 has frozen and Fedora 8 Development has started
References: <464E13CB.1070609@redhat.com> <20070521190811.GA11544@w-m-p.com> <4651EFCC.1040500@redhat.com> <200705211543.10171.paul.moore@hp.com> <1179779222.23650.24.camel@code.and.org> <20070521221304.GB11544@w-m-p.com> <4652F0B7.60506@manicmethod.com> <6FE441CD9F0C0C479F2D88F959B01588BEFCC2@exchange.columbia.tresys.com>
In-Reply-To: <6FE441CD9F0C0C479F2D88F959B01588BEFCC2@exchange.columbia.tresys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Todd Miller wrote:
> Joshua Brindle wrote:
>   
>> How would the client get that kind of information? apol is the only
>> app I know if that does any kind of relabel analysis to see what who
>> can relabel what-to-what and that would be a pretty high level
>> dependency for nautilus (and it also uses the policy on disk instead
>> of the one loaded into the kernel). Also the list would be completely
>> unusable when run from unconfined_t, which is the normal use case.   
>>     
>
> There was a proof of concept file label utility in SEDarwin that used a
> sysctl to get the list of allowable file contexts for a user.  Like you
> say, it was basically useless from unconfined_t (it was initially
> written for the old example policy).
>   

What does allowable file context mean?

You need to be able to do an analysis on the policy to see what user can 
relabelfrom and what they can relabelto. If they can't relabelfrom the 
file being modified in nautilus then nothing should appear, otherwise 
the types they can relabelto would appear.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
