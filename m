Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m8H41rxk029072
	for <selinux@tycho.nsa.gov>; Wed, 17 Sep 2008 00:01:53 -0400
Received: from smtp102.prem.mail.sp1.yahoo.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with SMTP id m8H4138V024887
	for <selinux@tycho.nsa.gov>; Wed, 17 Sep 2008 04:01:03 GMT
Message-ID: <48D08119.9050009@schaufler-ca.com>
Date: Tue, 16 Sep 2008 21:01:29 -0700
From: Casey Schaufler <casey@schaufler-ca.com>
MIME-Version: 1.0
To: Paul Moore <paul.moore@hp.com>
CC: selinux@tycho.nsa.gov, linux-security-module@vger.kernel.org,
        netdev@vger.kernel.org
Subject: Re: [RFC PATCH v6 00/16] Labeled networking patches for 2.6.28
References: <20080916124722.17132.38741.stgit@flek.lan> <200809160915.19843.paul.moore@hp.com>
In-Reply-To: <200809160915.19843.paul.moore@hp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Paul Moore wrote:
> On Tuesday 16 September 2008 8:55:48 am Paul Moore wrote:
>   
>> Another revision to the patchset to fix two issues, one trivial, the
>> other not so much.  The trivial fix was to add some locking around
>> the connection labeling operations, we're messing with the socket so
>> we should make sure we lock it like we do everywhere else.  The
>> second fix was to ensure that we sync up a stream socket's MSS value
>> when we add IP options to the socket. We were doing everything
>> correctly on the client side, but the server side was a bit of a
>> mess; I'm pretty happy with this fix as I think it actually makes the
>> code a bit cleaner in some respects and I believe actually shrinks
>> the size of the diff slightly (a good sign).
>>
>> A special thanks to Joe Nall and John Wiseman for helping debug the
>> MSS problem.
>>
>> I've updated both the git trees earlier today so hopefully the next
>> cut of the linux-next tree should have the latest bits.
>>
>>  * git://git.infradead.org/users/pcmoore/lblnet-2.6_testing
>>     
>
> I forgot to add, there is also a small fix to the 
> cipso_v4_sock_delattr() function so that it correctly removes the CIPSO 
> option and either adjust the option padding correctly or removes the 
> options struct entirely from the socket if it is no longer needed.
>
> Thanks to Casey Schaufler for finding this bug

Testing in progress. Thank you.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
