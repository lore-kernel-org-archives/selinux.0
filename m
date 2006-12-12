Reply-To: <vyekkirala@TrustedCS.com>
From: "Venkat Yekkirala" <vyekkirala@TrustedCS.com>
To: "Venkat Yekkirala" <vyekkirala@tcsfw4.tcs-sec.com>,
        <selinux@tycho.nsa.gov>
Cc: <jmorris@namei.org>, <sds@tycho.nsa.gov>
Subject: RE: Labeling traffic over loopback
Date: Tue, 12 Dec 2006 10:03:17 -0600
Message-ID: <000b01c71e07$0a1c9c40$cc0a010a@tcssec.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: 
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

In thinking more about this, we shouldn't actually need to use
the single bit in skbuff. We should just be able to use the
variable that denotes if xfrm over loopback is in use. Any time
xfrm over loopback isn't in use (the default), we could use sp
to hold the secid.

> -----Original Message-----
> From: Venkat Yekkirala [mailto:vyekkirala@trustedcs.com]
> Sent: Tuesday, December 12, 2006 10:01 AM
> To: 'selinux@tycho.nsa.gov'
> Cc: 'jmorris@namei.org'; 'sds@tycho.nsa.gov'
> Subject: Labeling traffic over loopback
> 
> 
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
> 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
