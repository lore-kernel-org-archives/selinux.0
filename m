Message-ID: <44FD9694.2050609@hp.com>
Date: Tue, 05 Sep 2006 11:24:04 -0400
From: Paul Moore <paul.moore@hp.com>
MIME-Version: 1.0
To: Joshua Brindle <jbrindle@tresys.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, Joy Latten <latten@austin.ibm.com>,
        latten@us.ibm.com, vyekkirala@TrustedCS.com, selinux@tycho.nsa.gov
Subject: Re: ipsec and getpeercon()
References: <200609011947.k81JlxUF020293@faith.austin.ibm.com>	 <44F895EF.5070706@hp.com>	 <1157373781.6716.8.camel@twoface.columbia.tresys.com>	 <200609042332.34493.paul.moore@hp.com>	 <1157457484.15886.12.camel@twoface.columbia.tresys.com>	 <1157463081.4014.37.camel@moss-spartans.epoch.ncsc.mil> <1157463290.15886.27.camel@twoface.columbia.tresys.com>
In-Reply-To: <1157463290.15886.27.camel@twoface.columbia.tresys.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Joshua Brindle wrote:
> On Tue, 2006-09-05 at 09:31 -0400, Stephen Smalley wrote:
> 
>>On Tue, 2006-09-05 at 07:58 -0400, Joshua Brindle wrote:
>>
>>>I don't know, how are you really going to be able to reconcile multiple
>>>labels on the underlying network connection? You don't think application
>>>developers should be able to get the one they really want?
>>
>>See the secid reconciliation threads, along with Venkat's earlier
>>Labeled Networking Requirements and Design postings.
>>
>>Application developers want a uniform way to get the peer security
>>information, without needing to know what mechanism was used to convey
>>it.
>>
>>
>>>Either way getpeercon() currently gets the context of the socket which I
>>>don't think is expected by application developers, either when it is on
>>>a local machine or with network labeling.
>>
>>Do you mean the context of the peer socket or the context of the local
>>socket?  I'd agree that getting the context of the local socket makes no
>>sense for a getpeercon() call; I'm not sure what NetLabel is doing
>>there.  But if your concern is with using the context of the peer socket
>>vs. the peer process, that is intentional and part of the original Flask
>>design, pre-SELinux.  The sockets are the endpoints and serve as proxies
>>for the processes.
>>
> 
> Yes, I'm getting the local socket context. I don't know whether its
> netlabel or ipsec, it only happens when i have an spd policy specifying
> the context for ipsec, without an sa set up i get 

Assuming you are running a version of the patch I posted last Friday and
you have not configured NetLabel at all (other than the default config
you get from booting with NetLabel built into the kernel) this context
is coming from the IPsec code and not the NetLabel code.

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
