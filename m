Subject: Re: Labeling traffic over loopback
From: Joy Latten <latten@austin.ibm.com>
To: vyekkirala@TrustedCS.com
Cc: redhat-lspp@redhat.com, selinux@tycho.nsa.gov, jmorris@namei.org,
        sds@tycho.nsa.gov
In-Reply-To: <000a01c71e06$b6d11020$cc0a010a@tcssec.com>
References: <000a01c71e06$b6d11020$cc0a010a@tcssec.com>
Content-Type: text/plain
Date: Tue, 12 Dec 2006 11:07:16 -0600
Message-Id: <1165943236.12468.87.camel@faith.austin.ibm.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2006-12-12 at 10:00 -0600, Venkat Yekkirala wrote:
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

I just took a quick look at racoon code... in the samples directory
where sample configs live, I saw a config with,

sainfo address ::1 icmp6 address ::1 icmp6
{
        pfs_group 3;
        lifetime time 60 sec;
        encryption_algorithm 3des, blowfish, aes;
        authentication_algorithm hmac_sha1, hmac_md5;
        compression_algorithm deflate;
}

My thinking (and I could be wrong as I am not an ipv6 nor racoon expert)
is this specifies SA info over loopback for icmp6. 
If we can specify it for ipv6 then we should be able to specify
it for ipv4.

I think we should play around with racoon and its config... I'll also
ask on the ipsec-tools mailing list about racoon working with loopback. 
 

Regards,
Joy

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
