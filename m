Message-ID: <45214C8C.2090306@hp.com>
Date: Mon, 02 Oct 2006 13:29:48 -0400
From: Paul Moore <paul.moore@hp.com>
MIME-Version: 1.0
To: Venkat Yekkirala <vyekkirala@TrustedCS.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, netdev@vger.kernel.org,
        selinux@tycho.nsa.gov, jmorris@namei.org, eparis@redhat.com
Subject: Re: [PATCH 7/9] secid reconciliation-v04: Enforcement for SELinux
References: <36282A1733C57546BE392885C0618592015CF4E4@chaos.tcs.tcs-sec.com>
In-Reply-To: <36282A1733C57546BE392885C0618592015CF4E4@chaos.tcs.tcs-sec.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Venkat Yekkirala wrote:
>>My immediate concern is not really what selinux_xfrm_decode_session()
>>returns, but how to handle it, or rather errors in general, in
>>selinux_skb_flow_in().  I'm in the process of creating a patch to add
>>the missing NetLabel support to the secid patches and I am 
>>wondering if
>>I should BUG_ON() for an error condition or simply jump to "out".
>>Jumping seems a bit cleaner to me, although perhaps harder to 
>>debug, so
>>I was just wondering what the reasoning was behind the use of 
>>BUG_ON().
> 
> 
> It's more a "code integrity" check that I have sought to enforce
> via BUG_ON (meaning the function isn't expected to fail under any
> circumstances). Whether this is a severe enough error (possible as
> a result of a bug in decode_session or a corrupted kernel) that we
> should panic the system at that point is probably debatable. In particular
> I would be interested to know how similar situations are currently
> treated in the kernel.
> 
> My recommendation would be to be consistent with the rest of the code
> and do a BUG_ON. 

That was how I was leaning and for the same reasons, I'll go that route
and if we need we can always change it later.

> As for other errors, you could jump out like the rest
> of the code already does (if that meets your needs that is).

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
