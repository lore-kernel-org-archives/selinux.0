From: Paul Moore <paul.moore@hp.com>
To: michel m <michel.mcgregor@gmail.com>
Subject: Re: get request context
Date: Wed, 7 Oct 2009 16:43:17 -0400
Cc: Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov
References: <bb74313d0910070439s6271ebe6ib481aab3f0eca7a6@mail.gmail.com> <1254916932.2251.176.camel@moss-pluto.epoch.ncsc.mil>
In-Reply-To: <1254916932.2251.176.camel@moss-pluto.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Message-Id: <200910072043.17541.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wednesday 07 October 2009 12:02:12 pm Stephen Smalley wrote:
> On Wed, 2009-10-07 at 15:09 +0330, michel m wrote:
> > Hi,
> >
> > Is there any way that I can get context for incoming http requests
> > from selinux API. that is I want to classify requests based on some
> > criteria like origin`s IP address or any thing that can help me to
> > know what context the request is coming from.
> >
> > is there such an API for this is libselinux? If not, how can I have
> > this knowledge by using existing API?
> 
> If using labeled IPSEC to label the connections, you can use
> getpeercon(3) in libselinux.
> 
> http://securityblog.org/brindle/2007/05/28/secure-networking-with-selinux/
> 
> Likewise with NetLabel, although there you are limited to only passing
> the MLS label at present.  You might be able to do something via the
> fallback labeling based on IP address.
> 
> http://paulmoore.livejournal.com/

To clarify things a bit, NetLabel only conveys MLS attributes when using CIPSO 
(the netlabel_peer_t type is used for type enforcement) but NetLabel does 
convey a full SELinux context when the fallback labels are configured.

-- 
paul moore
linux @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
