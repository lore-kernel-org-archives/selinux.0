Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id k1A50FXf003524
	for <selinux@tycho.nsa.gov>; Fri, 10 Feb 2006 00:00:15 -0500 (EST)
Received: from mail5.sea5.speakeasy.net (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k1A50BTR006195
	for <selinux@tycho.nsa.gov>; Fri, 10 Feb 2006 05:00:12 GMT
Date: Thu, 9 Feb 2006 23:00:11 -0500 (EST)
From: James Morris <jmorris@namei.org>
To: "Timothy R. Chavez" <tinytim@us.ibm.com>
cc: James Morris <jmorris@redhat.com>, selinux@tycho.nsa.gov,
   Linux Audit Discussion <linux-audit@redhat.com>,
   Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: [RFC][PATCH] collect security labels on user processes generating
 audit messages
In-Reply-To: <1139530450.12638.7.camel@localhost>
Message-ID: <Pine.LNX.4.64.0602092258310.2570@excalibur.intercode>
References: <Pine.LNX.4.44.0602090950470.21925-100000@redline.boston.redhat.com>
 <1139530450.12638.7.camel@localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 9 Feb 2006, Timothy R. Chavez wrote:

> +int selinux_ctx_to_id(const char *ctx, u32 *ctxid);

You're not using this function, so don't include it for upstream.


- James
-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
