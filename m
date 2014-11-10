Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id sAAC5cC7005511
 for <selinux@tycho.nsa.gov>; Mon, 10 Nov 2014 07:05:38 -0500
Message-ID: <5460AA07.9090004@redhat.com>
Date: Mon, 10 Nov 2014 13:05:27 +0100
From: Daniel Borkmann <dborkman@redhat.com>
MIME-Version: 1.0
To: Paul Moore <paul@paul-moore.com>
Subject: Re: [PATCH] selinux: Support SCTP protocol
References: <1415368329-2670-1-git-send-email-richard_c_haines@btinternet.com>
 <2529618.NmhAYzQ15g@sifl>
In-Reply-To: <2529618.NmhAYzQ15g@sifl>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: vyasevic@redhat.com, selinux@tycho.nsa.gov
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 11/07/2014 05:35 PM, Paul Moore wrote:
> On Friday, November 07, 2014 01:52:09 PM Richard Haines wrote:
>> This is an RFC patch.
>
> Thanks for your patch, I appreciate the time and effort that went into
> developing it.

Fully agreed, thanks for working on this Richard!

> Unfortunately, I think this patch may be a bit too simplistic.  I haven't
> looked too closely at the SCTP code in recent times, but from my earlier look,
> SCTP associations stuck out as something that will need special handling and I
> don't see that in this initial patch.  From what I could see, SCTP
> associations seem close-ish to TCP connections and we may be able to handle
> them in a similar manner, but I can't say for certain.  Someone would need to
> investigate this further.
>
> There is also an issue of multi-homing which might, or might not, present an
> issue for peer labeling, but once again I can't say for certain.
>
> I'm also not entirely sure if we need any special handling for the SCTP
> handshake (see TCP's connection request sockets).  Hopefully not, but
> something to be aware of if you keep working on this.
>
> I *really* don't want to scare you off of working on SCTP support, I just want
> to caution you that it likely isn't as easy as adding basic support for a new
> object class.

My free cycles are a bit limited at the moment, but selinux support
was also on my todo, so I'm hoping we can merge our efforts here and
get something up and running. I will get back to you this or next
week with a closer review.

Thanks,
Daniel
