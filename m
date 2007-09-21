From: Paul Moore <paul.moore@hp.com>
To: Venkat Yekkirala <vyekkirala@TrustedCS.com>
Subject: Re: [RFC] [PATCH 2/4] Define new LSM hooks
Date: Fri, 21 Sep 2007 15:26:09 -0400
Cc: selinux@tycho.nsa.gov, sds@tycho.nsa.gov, jmorris@namei.org
References: <46F00B82.3030901@trustedcs.com>
In-Reply-To: <46F00B82.3030901@trustedcs.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200709211526.10068.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tuesday, September 18 2007 1:31:46 pm Venkat Yekkirala wrote:
> diff --git a/include/linux/security.h b/include/linux/security.h
> index 1a15526..f0b5ee5 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -831,6 +831,8 @@ struct request_sock;
>   *     Sets the connection's peersid to the secmark on skb.
>   * @req_classify_flow:
>   *	Sets the flow's sid to the openreq sid.
> + * @skb_flow_out:
> + *	Determines if an skb can flow out per LSM policy.
>   *
>   * Security hooks for XFRM operations.
>   *

A bit of a nit: let's change the hook to security_skb_output() so it's name 
better matches the stack's calling functions.  This seems to fit a bit 
better ...

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
