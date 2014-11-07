Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id sA7GZweO003046
 for <selinux@tycho.nsa.gov>; Fri, 7 Nov 2014 11:35:59 -0500
Received: by mail-qg0-f41.google.com with SMTP id q107so2630818qgd.28
 for <selinux@tycho.nsa.gov>; Fri, 07 Nov 2014 08:35:55 -0800 (PST)
From: Paul Moore <paul@paul-moore.com>
To: Richard Haines <richard_c_haines@btinternet.com>
Subject: Re: [PATCH] selinux: Support SCTP protocol
Date: Fri, 07 Nov 2014 11:35:53 -0500
Message-ID: <2529618.NmhAYzQ15g@sifl>
In-Reply-To: <1415368329-2670-1-git-send-email-richard_c_haines@btinternet.com>
References: <1415368329-2670-1-git-send-email-richard_c_haines@btinternet.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: vyasevic@redhat.com, dborkman@redhat.com, selinux@tycho.nsa.gov
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Friday, November 07, 2014 01:52:09 PM Richard Haines wrote:
> This is an RFC patch.

Thanks for your patch, I appreciate the time and effort that went into 
developing it.

Unfortunately, I think this patch may be a bit too simplistic.  I haven't 
looked too closely at the SCTP code in recent times, but from my earlier look, 
SCTP associations stuck out as something that will need special handling and I 
don't see that in this initial patch.  From what I could see, SCTP 
associations seem close-ish to TCP connections and we may be able to handle 
them in a similar manner, but I can't say for certain.  Someone would need to 
investigate this further.

There is also an issue of multi-homing which might, or might not, present an 
issue for peer labeling, but once again I can't say for certain.

I'm also not entirely sure if we need any special handling for the SCTP 
handshake (see TCP's connection request sockets).  Hopefully not, but 
something to be aware of if you keep working on this.

I *really* don't want to scare you off of working on SCTP support, I just want 
to caution you that it likely isn't as easy as adding basic support for a new 
object class.

-- 
paul moore
www.paul-moore.com
