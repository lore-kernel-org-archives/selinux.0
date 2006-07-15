Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k6FEnDTG019060
	for <selinux@tycho.nsa.gov>; Sat, 15 Jul 2006 10:49:13 -0400
Received: from ccerelrim02.cce.hp.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k6FEnBX0020327
	for <selinux@tycho.nsa.gov>; Sat, 15 Jul 2006 14:49:12 GMT
From: Paul Moore <paul.moore@hp.com>
To: James Morris <jmorris@namei.org>
Subject: Re: [PATCH 2/7] NetLabel: core network changes
Date: Sat, 15 Jul 2006 10:48:02 -0400
Cc: netdev@vger.kernel.org, selinux@tycho.nsa.gov,
        "David S. Miller" <davem@davemloft.net>, sds@epoch.ncsc.mil,
        pratt@argus-systems.com
References: <20060714185739.780700000@flek.zko.hp.com> <20060714185914.416432000@flek.zko.hp.com> <Pine.LNX.4.64.0607141933170.18747@d.namei>
In-Reply-To: <Pine.LNX.4.64.0607141933170.18747@d.namei>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200607151048.02921.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Friday 14 July 2006 7:34 pm, James Morris wrote:
> On Fri, 14 Jul 2006, paul.moore@hp.com wrote:
> > +static inline void netlbl_put_hdr(unsigned char *buffer,
> > +				  const u32 msg_type,
> > +				  const u16 msg_len,
> > +				  const u16 msg_flags,
> > +				  const u32 msg_pid,
> > +				  const u32 msg_seq)
>
> Why are these parameters marked const?  Seems to be common throughout the
> code.
>

I saw similar things in the kernel, but it looks like I was looking at 
older, "less desirable"  sections of code.  Since it looks like you are still 
churning through the patchset I'll hold off on submitting a new version based 
on your comments until Monday.

Once again, thanks for your comments and patience.

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
