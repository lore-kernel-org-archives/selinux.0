Message-ID: <457EDAA1.60003@hp.com>
Date: Tue, 12 Dec 2006 11:36:49 -0500
From: Paul Moore <paul.moore@hp.com>
MIME-Version: 1.0
To: vyekkirala@TrustedCS.com
Cc: selinux@tycho.nsa.gov, jmorris@namei.org, sds@tycho.nsa.gov
Subject: Re: Labeling traffic over loopback
References: <000a01c71e06$b6d11020$cc0a010a@tcssec.com>
In-Reply-To: <000a01c71e06$b6d11020$cc0a010a@tcssec.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Venkat Yekkirala wrote:
> The following describes a proposal to label traffic over loopback
> by using a bit in the sk_buff structure. We have:
> 
> struct sk_buff {
> ...
>         struct  sec_path        *sp;
> ...
>         __u8                    pkt_type:3,
>                                 fclone:2,
>                                 ipvs_property:1;
> ...
> }
> 
> We could use an additional bit (local_label) to denote that
> "sp" holds the source label sid (no blob, so no lifecycle mgmt).
> 
> What do people think?

Can you give an example of what the *sp value would look like?  Are you thinking
of adding a new field to 'sec_path' or would you create a sort of dummy
'xfrm_state' entry?  Or is it something else entirely that I am missing?

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
