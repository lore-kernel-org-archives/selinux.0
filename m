Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id kBCHNh1x030173
	for <selinux@tycho.nsa.gov>; Tue, 12 Dec 2006 12:23:43 -0500
Received: from web36608.mail.mud.yahoo.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id kBCHODdl008460
	for <selinux@tycho.nsa.gov>; Tue, 12 Dec 2006 17:24:14 GMT
Message-ID: <20061212172357.93781.qmail@web36608.mail.mud.yahoo.com>
Date: Tue, 12 Dec 2006 09:23:57 -0800 (PST)
From: Casey Schaufler <casey@schaufler-ca.com>
Reply-To: casey@schaufler-ca.com
Subject: Re: Labeling traffic over loopback
To: vyekkirala@TrustedCS.com, selinux@tycho.nsa.gov
Cc: jmorris@namei.org, sds@tycho.nsa.gov
In-Reply-To: <000a01c71e06$b6d11020$cc0a010a@tcssec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--- Venkat Yekkirala <vyekkirala@TrustedCS.com> wrote:

> The following describes a proposal to label traffic
> over loopback
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
> We could use an additional bit (local_label) to
> denote that
> "sp" holds the source label sid (no blob, so no
> lifecycle mgmt).
> 
> What do people think?

I can't speak for other people, but every time
I've seen the space in a pointer stolen as
storage for data it's lead to tears.
It may be expediant for the problem at hand,
but you'll never be able to share the
interface* if you break it in this way.
If you must do this sort of thing use a union
so that there's some hope of maintaining the
interface moving forward.

----
* I know that it seems unlikely that you'll
  ever need to, but the network labeling scheme
  is reasonably attractive.


Casey Schaufler
casey@schaufler-ca.com

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
