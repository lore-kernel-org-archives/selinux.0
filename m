Message-ID: <44F5F35A.7000904@hp.com>
Date: Wed, 30 Aug 2006 16:21:46 -0400
From: Paul Moore <paul.moore@hp.com>
MIME-Version: 1.0
To: Venkat Yekkirala <vyekkirala@TrustedCS.com>
Cc: James Morris <jmorris@namei.org>, netdev@vger.kernel.org,
        selinux@tycho.nsa.gov, Stephen Smalley <sds@tycho.nsa.gov>,
        Chad Hanson <chanson@TrustedCS.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH 0/3] secid reconciliation-v01: Repost patchset with up
 dates
References: <36282A1733C57546BE392885C0618592014C066C@chaos.tcs.tcs-sec.com> <Pine.LNX.4.64.0608251025120.23473@d.namei>
In-Reply-To: <Pine.LNX.4.64.0608251025120.23473@d.namei>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

James Morris wrote:
> On Fri, 25 Aug 2006, Venkat Yekkirala wrote:
>>>I like these changes, but wondering why you haven't supplied 
>>>code for the 
>>>outbound case ?
>>
>>The code for the outbound is still in the works. I hope to have it
>>out in a week or so.
> 
> Ok, I guess we should wait until then before incorporating the patches 
> (also, for Paul Moore to return and comment re. CIPSO).

My main concern with these patches is that moving the NetLabel check out
of selinux_socket_sock_rcv_skb() and into selinux_skb_policy_check() (as
it is currently written) would force us to compare a packet's NetLabel
with either the IPsec label or the secmark label and not the socket's
label.  The ability to make access decisions based on the process
consuming the data and the data itself it one of the nicer qualities of
NetLabel in my opinion.

Like James, I'd also like to see the outbound side too.

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
