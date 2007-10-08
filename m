Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l98EqnA6020796
	for <selinux@tycho.nsa.gov>; Mon, 8 Oct 2007 10:52:49 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id l98EqlWT000155
	for <selinux@tycho.nsa.gov>; Mon, 8 Oct 2007 14:52:47 GMT
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: Re: [Refpolicy PATCH] (just a m4macro description miss?)
Date: Mon, 8 Oct 2007 10:48:19 -0400
Message-ID: <1191854900.13098.30.camel@gorn>
In-Reply-To: <1191761602.3169.4.camel@notepc.intrajp-yokosuka.co.jp>
References: <1191761602.3169.4.camel@notepc.intrajp-yokosuka.co.jp>
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: "shintaro_fujiwara" <shin216@xf7.so-net.ne.jp>
Cc: <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 2007-10-07 at 21:53 +0900, shintaro_fujiwara wrote:
> Index: policy/modules/services/ucspitcp.if
> ===================================================================
> --- policy/modules/services/ucspitcp.if (revision 2446)
> +++ policy/modules/services/ucspitcp.if (working copy)
> @@ -20,7 +20,7 @@
>  ##     </summary>
>  ## </param>
>  #
> -interface(`ucspitcp_service_domain', `
> +interface(`ucspitcp_service_domain',`
> 	gen_require(`
> 		type ucspitcp_t;
> 		role system_r;
> 

This change shouldn't affect anything.  What incorrect behavior does
this fix?

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
