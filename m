Message-ID: <44FD9631.8020604@hp.com>
Date: Tue, 05 Sep 2006 11:22:25 -0400
From: Paul Moore <paul.moore@hp.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Joshua Brindle <jbrindle@tresys.com>, Joy Latten <latten@austin.ibm.com>,
        latten@us.ibm.com, vyekkirala@TrustedCS.com, selinux@tycho.nsa.gov
Subject: Re: ipsec and getpeercon()
References: <200609011947.k81JlxUF020293@faith.austin.ibm.com>	 <44F895EF.5070706@hp.com>	 <1157373781.6716.8.camel@twoface.columbia.tresys.com>	 <200609042332.34493.paul.moore@hp.com>	 <1157457484.15886.12.camel@twoface.columbia.tresys.com> <1157463081.4014.37.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1157463081.4014.37.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> On Tue, 2006-09-05 at 07:58 -0400, Joshua Brindle wrote:
>>Either way getpeercon() currently gets the context of the socket which I
>>don't think is expected by application developers, either when it is on
>>a local machine or with network labeling.
> 
> 
> Do you mean the context of the peer socket or the context of the local
> socket?  I'd agree that getting the context of the local socket makes no
> sense for a getpeercon() call; I'm not sure what NetLabel is doing
> there.  But if your concern is with using the context of the peer socket
> vs. the peer process, that is intentional and part of the original Flask
> design, pre-SELinux.  The sockets are the endpoints and serve as proxies
> for the processes.

When NetLabel accepts an incoming connection it sets the context of the
local socket to equal the context of the connection.  Since NetLabel
currently only supports sending the MLS label this context is created by
taking the non-MLS portion of the context (user:role:type) from the
parent socket and the MLS label from the connection.  This is how the
child socket is labeled and this is the context reported to userspace
when a getpeercon() call is made when NetLabel is in use.

Once NetLabel supports full contexts there will not be any need to use
the parent socket's context.

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
