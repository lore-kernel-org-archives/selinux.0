From: Paul Moore <paul.moore@hp.com>
To: vyekkirala@TrustedCS.com
Subject: Re: generic fallbacks of getpeercon (Re: [redhat-lspp] Labeling an interface)
Date: Wed, 6 Jun 2007 15:37:49 -0400
Cc: "KaiGai Kohei" <kaigai@kaigai.gr.jp>,
        "KaiGai Kohei" <kaigai@ak.jp.nec.com>,
        "Stephen Smalley" <sds@tycho.nsa.gov>, "Joe Nall" <joe@nall.com>,
        "SELinux Mail List" <selinux@tycho.nsa.gov>, ewalsh@tycho.nsa.gov
References: <000701c7a868$fbdc6a60$cc0a010a@tcssec.com>
In-Reply-To: <000701c7a868$fbdc6a60$cc0a010a@tcssec.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200706061537.49417.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wednesday, June 6 2007 2:32:04 pm Venkat Yekkirala wrote:
> > > It's preferable, if we can configure the fallbacked client context
> > > directly, as follows:
> > >     192.168.1.0/24 --> system_u:system_r:sepgsql_client_t
> > >     192.168.2.0/24 -->
> > > system_u:system_r:sepgsql_trusted_client_t:SystemLow-SystemHigh
> >
> > That is exactly what I am intending to implement; the system
> > administrator
> > would specify a interface/address/netmask that would match to
> > a _full_
> > SELinux context as you have described above.
>
> I see 2 drawbacks with this approach:
>
> 1. We aren't leveraging secmark (and the fine-grained policy that it
>    can offer) which was supposed to move us away from
> individual/stand-alone netif/node labels here.

We decided long ago to keep the two types of labels, internal and external, 
separate because merging the two made the policy to difficult to understand, 
write, and analyze.  I still believe this to be the correct decision.  This 
approach deliberately avoids making use of the SECMARK labels for this 
reason.

I view SECMARK, or any other internal labeling mechanism, as a way to 
introduce SELinux access controls into the Linux netfilter mechanism which 
provides a much more flexible and cleaner alternative to the 
compat_net/netif/node labels we used to have.  NetLabel/CIPSO, labeled IPsec, 
or any other external labeling mechanism is a way for domains to communicate 
their labels across the network.  The two labeling mechanisms, internal and 
external, both provide packet level access controls but for two completely 
different purposes.

The proposal here is to introduce a static external label for single label 
networks where the remote domain is not explicitly labeling it's network 
traffic.  This is a common request from people with existing trusted OS 
installations and would be a nice compliment to the existing labeling 
mechanisms, both internal and external.

> 2. Redundant labeling (atleast MLS-wise) and the potential for
> inconsistency.

You have the possibility for the same "redundancy" between the existing 
external and internal labels.  Simply providing another method of determining 
external labels does not cause any new redundancy that did not exist before.

If there is a disparity between the internal and external labels it is either 
because the policy is incorrect or the connection should not be allowed.

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
