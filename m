Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k6ENYOAl008432
	for <selinux@tycho.nsa.gov>; Fri, 14 Jul 2006 19:34:24 -0400
Received: from mail8.sea5.speakeasy.net (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k6ENYN48022945
	for <selinux@tycho.nsa.gov>; Fri, 14 Jul 2006 23:34:24 GMT
Date: Fri, 14 Jul 2006 19:34:20 -0400 (EDT)
From: James Morris <jmorris@namei.org>
To: Paul Moore <paul.moore@hp.com>
cc: netdev@vger.kernel.org, selinux@tycho.nsa.gov,
        "David S. Miller" <davem@davemloft.net>, sds@epoch.ncsc.mil,
        pratt@argus-systems.com
Subject: Re: [PATCH 2/7] NetLabel: core network changes
In-Reply-To: <20060714185914.416432000@flek.zko.hp.com>
Message-ID: <Pine.LNX.4.64.0607141933170.18747@d.namei>
References: <20060714185739.780700000@flek.zko.hp.com>
 <20060714185914.416432000@flek.zko.hp.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 14 Jul 2006, paul.moore@hp.com wrote:


> +static inline void netlbl_put_hdr(unsigned char *buffer,
> +				  const u32 msg_type,
> +				  const u16 msg_len,
> +				  const u16 msg_flags,
> +				  const u32 msg_pid,
> +				  const u32 msg_seq)

Why are these parameters marked const?  Seems to be common throughout the 
code.


- James
-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
