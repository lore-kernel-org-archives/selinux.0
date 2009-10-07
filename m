Subject: Re: get request context
From: Stephen Smalley <sds@tycho.nsa.gov>
To: michel m <michel.mcgregor@gmail.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <bb74313d0910070439s6271ebe6ib481aab3f0eca7a6@mail.gmail.com>
References: <bb74313d0910070439s6271ebe6ib481aab3f0eca7a6@mail.gmail.com>
Content-Type: text/plain
Date: Wed, 07 Oct 2009 08:02:12 -0400
Message-Id: <1254916932.2251.176.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2009-10-07 at 15:09 +0330, michel m wrote:
> Hi,
> 
> Is there any way that I can get context for incoming http requests
> from selinux API. that is I want to classify requests based on some
> criteria like origin`s IP address or any thing that can help me to
> know what context the request is coming from.
> 
> is there such an API for this is libselinux? If not, how can I have
> this knowledge by using existing API?

If using labeled IPSEC to label the connections, you can use
getpeercon(3) in libselinux.

http://securityblog.org/brindle/2007/05/28/secure-networking-with-selinux/

Likewise with NetLabel, although there you are limited to only passing
the MLS label at present.  You might be able to do something via the
fallback labeling based on IP address.

http://paulmoore.livejournal.com/


-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
