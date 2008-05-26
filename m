Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m4QFapKG006432
	for <selinux@tycho.nsa.gov>; Mon, 26 May 2008 11:36:51 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with SMTP id m4QFapLs013551
	for <selinux@tycho.nsa.gov>; Mon, 26 May 2008 15:36:51 GMT
Subject: Re: New domain for podsleuth
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Daniel J Walsh <Dan-Walsh@comcast.net>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <4831B4AE.4010604@comcast.net>
References: <4831B4AE.4010604@comcast.net>
Content-Type: text/plain
Date: Mon, 26 May 2008 11:36:04 -0400
Message-Id: <1211816164.11188.178.camel@gorn.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2008-05-19 at 13:11 -0400, Daniel J Walsh wrote:
> +hal_dbus_chat(podsleuth_t)
> +
> +optional_policy(`
> +	dbus_system_bus_client_template(podsleuth,podsleuth_t)
> +')

Seems that either the hal dbus should go in the optional or dbus should
become unconditional.  My guess is unconditional(?)

> +gen_require(`
> +	type hald_t;
> +')
> +
> +podsleuth_domtrans(hald_t)

:(

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
