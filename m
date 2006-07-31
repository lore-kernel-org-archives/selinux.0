Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k6VEH3wp019818
	for <selinux@tycho.nsa.gov>; Mon, 31 Jul 2006 10:17:03 -0400
Received: from mailhub.hp.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k6VEGxI8019899
	for <selinux@tycho.nsa.gov>; Mon, 31 Jul 2006 14:16:59 GMT
From: Paul Moore <paul.moore@hp.com>
To: Venkat Yekkirala <vyekkirala@TrustedCS.com>
Subject: Re: [PATCH 2/7] NetLabel: core network changes
Date: Mon, 31 Jul 2006 10:16:51 -0400
Cc: David Miller <davem@davemloft.net>, netdev@vger.kernel.org,
        selinux@tycho.nsa.gov, sds@epoch.ncsc.mil, jmorris@redhat.com,
        pratt@argus-systems.com
References: <36282A1733C57546BE392885C0618592013E80CA@chaos.tcs.tcs-sec.com>
In-Reply-To: <36282A1733C57546BE392885C0618592013E80CA@chaos.tcs.tcs-sec.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200607311016.52064.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Monday 31 July 2006 8:43 am, Venkat Yekkirala wrote:
> > The NetLabel patch allows administrators to assign specific a CIPSO
> > DOI/configuration to each LSM "domain".  Blindly using the
> > CIPSO tag that the
> > remote host sends could violate the administrator's NetLabel
> > configuration.
> >
> > The current patch reads the CIPSO tag off the child socket,
> > translating the
> > tag according to the CIPSO DOI configuration to arrive at the
> > correct/desired
> > LSM  security attributes.  These LSM security attributes and
> > the "domain" are
> > then used to set the NetLabel on the socket.  In the case
> > where everyone is
> > well behaved this should have no effect on the socket IP
> > options and the
> > packets sent across the wire.  However, in the case of a
> > not-nice remote host
> > the outgoing CIPSO tag may change to match the administrators desired
> > settings.
>
> I wonder if waiting till accept isn't too late though. Perhaps this
> should be done when the openreq is created so the syn-ack and such
> will go out with the right tag?

Stephen Smalley and I had several long discussions about this and my opinion, 
which seemed to be at least acceptable to Stephen, was that it was okay since 
there was no actual data being sent only TCP control messages.  However, like 
I said earlier, the exact details of this are going to change as I am going 
to port the code to use the new accept() LSM hooks so this is really a not 
much of a concern anymore ...

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
