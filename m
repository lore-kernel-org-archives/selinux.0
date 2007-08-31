From: Paul Moore <paul.moore@hp.com>
To: Venkat Yekkirala <vyekkirala@TrustedCS.com>
Subject: Re: Networking Patch (outline)
Date: Fri, 31 Aug 2007 19:04:59 -0400
Cc: selinux@tycho.nsa.gov, jmorris@namei.org, sds@tycho.nsa.gov
References: <46D898D3.7020400@trustedcs.com>
In-Reply-To: <46D898D3.7020400@trustedcs.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200708311904.59710.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Friday, August 31 2007 6:40:19 pm Venkat Yekkirala wrote:
> The following is a slightly modified version of the patch
> (backed here against 2.6.23-rc4) that we have been using here at
> TCS. It is intended to help provide an idea as to the points in
> code that need to be dealt with for the enhancements that have
> been talked about.

Thanks for getting a patch out so quickly, even if it is just a RFC patch.  
I'm still fumbling around figuring out how to manage a git tree :/.  I've 
only quickly glanced at the patch, I'll look closer next week, but it might 
be easier to discuss things if you were to split up the functionality into 
different patches, e.g. it looks like the patch provides both loopback 
labeling and flow control.

I've also been thinking about the order in which we need to do things so we 
minimize breakage and make the patches sane - I'll send something out a bit 
later (probably next week too, sigh).

> Specifically, the following are the primary areas that
> have not been addressed here:
>
> 1. Replace setting of secid with IP Option or Split secmark.

>From what I can tell this is only for loopback labeling in your patch.  
Assuming that is the case let's drop it out of this patch and focus on the 
flow control for right now.

> 2. Integrate NetLabel fallbacks.

Yes, NetLabel/IPsec integration is a biggie and perhaps the first on the list 
of things to do.

> 3. Replace igmp_classify_skb with a generic classification
>    mechanism based on protocol and such.

Agreed, the more generic the hook (assuming it makes sense) the better.

> 4. Currently this patch modifies xfrm_policy_check()
>    to also perform the flow_in checks. This is awkward and
>    a separate call into LSM right after the xfrm_policy_check
>    invocations would be cleaner.
>
> 5. Consolidate label-type-secific checks into a single
>    peer.recv check.

Probably a separate patch.

> 6. Also, following in the tradition of MLS, icmp replies
>    and such are returned with the same label as the incoming
>    packet that resulted in the generation of the reply. This
>    needs to be examined from the TE POV.

If we get it right for a generic label it should be right for both MLS and 
TE :)

Enjoy your weekend.

-- 
paul moore
linux security @ hp


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
