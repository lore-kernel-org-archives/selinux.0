Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id lBBHGLIf016209
	for <selinux@tycho.nsa.gov>; Tue, 11 Dec 2007 12:16:21 -0500
Received: from mailhub.hp.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id lBBHGKrO021730
	for <selinux@tycho.nsa.gov>; Tue, 11 Dec 2007 17:16:20 GMT
From: Paul Moore <paul.moore@hp.com>
To: David Miller <davem@davemloft.net>
Subject: Re: [PATCH v2] XFRM: assorted IPsec fixups
Date: Tue, 11 Dec 2007 12:15:00 -0500
Cc: netdev@vger.kernel.org, linux-audit@redhat.com, selinux@tycho.nsa.gov
References: <20071211163019.15059.73746.stgit@flek.lan> <20071211.090611.59888503.davem@davemloft.net>
In-Reply-To: <20071211.090611.59888503.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200712111215.00720.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tuesday 11 December 2007 12:06:11 pm David Miller wrote:
> From: Paul Moore <paul.moore@hp.com>
> Date: Tue, 11 Dec 2007 11:30:19 -0500
>
> Sorry for not pointing this out sooner:

No problem, better late than never ... despite reports to the contrary, 
breaking userspace doesn't excite me as much as it used to ;)

> >  * Convert 'sid' to 'secid'
> >    The 'sid' name is specific to SELinux, 'secid' is the common naming
> >    convention used by the kernel when refering to tokenized LSM labels
>
>  ...
>
> > diff --git a/include/linux/xfrm.h b/include/linux/xfrm.h
> > index b58adc5..f75a337 100644
> > --- a/include/linux/xfrm.h
> > +++ b/include/linux/xfrm.h
> > @@ -31,7 +31,7 @@ struct xfrm_sec_ctx {
> >  	__u8	ctx_doi;
> >  	__u8	ctx_alg;
> >  	__u16	ctx_len;
> > -	__u32	ctx_sid;
> > +	__u32	ctx_secid;
> >  	char	ctx_str[0];
> >  };
>
> This datastructure has been exported to userspace, so we really can't
> member names unless it was added only in 2.6.24 and I don't think it
> was.
>
> Correct me if I'm wrong.

Ungh, I didn't think the whole structure was exported to userspace as a single 
binary blob; I'd assumed it was passed back and forth as individual 
fields/attributes.  I guess the old adage about assuming applies here ...

Grrr, that "sid" really bothers me but I guess it's a wart we're going to have 
to live with.  Stoopid userspace :)

I still would like to see the rest of the changes make it into 2.6.25 (the SPI 
byte order thing is particularly troublesome) so if you don't mind a "v3" 
I'll respin this patch right now to remove the "sid -> secid" bits.

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
