Subject: Re: ipsec and getpeercon()
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Joshua Brindle <jbrindle@tresys.com>
Cc: Paul Moore <paul.moore@hp.com>, Joy Latten <latten@austin.ibm.com>,
        latten@us.ibm.com, vyekkirala@TrustedCS.com, selinux@tycho.nsa.gov
In-Reply-To: <1157457484.15886.12.camel@twoface.columbia.tresys.com>
References: <200609011947.k81JlxUF020293@faith.austin.ibm.com>
	 <44F895EF.5070706@hp.com>
	 <1157373781.6716.8.camel@twoface.columbia.tresys.com>
	 <200609042332.34493.paul.moore@hp.com>
	 <1157457484.15886.12.camel@twoface.columbia.tresys.com>
Content-Type: text/plain
Date: Tue, 05 Sep 2006 09:31:21 -0400
Message-Id: <1157463081.4014.37.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2006-09-05 at 07:58 -0400, Joshua Brindle wrote:
> I don't know, how are you really going to be able to reconcile multiple
> labels on the underlying network connection? You don't think application
> developers should be able to get the one they really want?

See the secid reconciliation threads, along with Venkat's earlier
Labeled Networking Requirements and Design postings.

Application developers want a uniform way to get the peer security
information, without needing to know what mechanism was used to convey
it.

> Either way getpeercon() currently gets the context of the socket which I
> don't think is expected by application developers, either when it is on
> a local machine or with network labeling.

Do you mean the context of the peer socket or the context of the local
socket?  I'd agree that getting the context of the local socket makes no
sense for a getpeercon() call; I'm not sure what NetLabel is doing
there.  But if your concern is with using the context of the peer socket
vs. the peer process, that is intentional and part of the original Flask
design, pre-SELinux.  The sockets are the endpoints and serve as proxies
for the processes.

> On the other hand using the socket label locally at least implements a
> kind of IPC impersonation that flask specifies and can be very useful to
> object managers, which is why I think the application developer should
> be able to get the context that is actually interesting to them. Perhaps
> a version that takes a class value that way one could get the
> association context, the tcp socket (netlbl), process (actual remote
> domain) and so on.

No, that exposes the mechanism, and the application shouldn't have to
care.  It just wants security data for the peer, regardless of how it is
determined.  Whether that security data is determined based on the IPSEC
SA corresponding to the packet's SPI or from an IP option in the packet
or based on iptables secmark configuration (e.g. all packets received on
netif eth0 get a given context) is immaterial.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
