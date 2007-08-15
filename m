Date: Tue, 14 Aug 2007 21:24:43 -0700 (PDT)
From: James Morris <jmorris@namei.org>
To: Darrel Goeddel <DGoeddel@TrustedCS.com>
cc: Paul Moore <paul.moore@hp.com>, Stephen Smalley <sds@tycho.nsa.gov>,
        selinux@tycho.nsa.gov, kaigai@ak.jp.nec.com, joe@nall.com,
        Eric Paris <eparis@parisplace.org>
Subject: Re: [RFC 0/5] Static/fallback external labels for NetLabel
In-Reply-To: <46C1C09D.4060909@trustedcs.com>
Message-ID: <Pine.LNX.4.64.0708142044300.14855@us.intercode.com.au>
References: <46C1C09D.4060909@trustedcs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 14 Aug 2007, Darrel Goeddel wrote:

> The recv check at the socket layer becomes socket (proxy for local 
> process)
> receiving information from the secmark (peer process).  This process vs.
> process style check didn't seem to have a natural fit with sending the
> information because the peer isn't as well known as it could be in the
> receive case.  For this reason, send is actually absent in this idea 
> right now.
> If there were a process vs. process check on send the peer process could
> only
> be identified through the SECMARK fallback labels.

Perhaps I'm missing something, but the send check is necessary for e.g. 
"can a httpd_server_t socket send an smtp_client_t packet" ?

What you're calling fallback labels will likely be the only labels a 
normal user encounters.

> There's that darn send again...  The flow_out check from SECFILTER is 
> really performing the duties of the current send operation.

I think there's a slight misunderstanding here.  I'm proposing not having 
SECFILTER at all, and instead adding netif_in and netif_out SELinux hooks.

Discussion of security gates and similar I think will really confuse 
people, as will the idea of labeling such abstract entities, which is 
heading down a similar path to earlier proposals on this topic.

> - a packet goes though "filter points", the packet is the subject and the
>  "filter point" is the object it must pass through (these filters happen
>   at input, output, and forwarding)

What they really are is the boundary of network layer of the machine, 
which is to say, the boundary of machine itself in terms of network 
functionality.  i.e. once a packet is accepted into the IP stack, it can 
be forwarded, delivered etc.

So, allowing flow_in means "the packet can flow into this machine", and 
similar for flow_forward and flow_out.

The socket recv/send checks are against the endpoint (at least, as 
delegated by an authorized endpoint via the socket).

The netif_in and netif_out allow checking of the packet flowing across 
specific physical interfaces.

I don't think we need to add any new abstractions here, and these should 
be understandable by people who can configure networking.

> - a socket reading a packet must be able to listen to the peer that 
>   created it - a slightly new meaning for current socket vs. secmark 
>   access check

I'm not sure what this means.


-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
