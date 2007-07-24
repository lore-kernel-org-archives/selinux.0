Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l6ODACFB002934
	for <selinux@tycho.nsa.gov>; Tue, 24 Jul 2007 09:10:12 -0400
Received: from mail8.sea5.speakeasy.net (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l6ODAAE8008919
	for <selinux@tycho.nsa.gov>; Tue, 24 Jul 2007 13:10:11 GMT
Date: Tue, 24 Jul 2007 09:10:08 -0400 (EDT)
From: James Morris <jmorris@namei.org>
To: Stephen Smalley <sds@tycho.nsa.gov>
cc: KaiGai Kohei <kaigai@ak.jp.nec.com>,
        Yuichi Nakamura <ynakam@hitachisoft.jp>, selinux@tycho.nsa.gov,
        busybox@kaigai.gr.jp, Eric Paris <eparis@parisplace.org>
Subject: Re: [patch] customizable AVTAB_HASH_BITS for embedded devices
In-Reply-To: <1185279143.16598.8.camel@moss-spartans.epoch.ncsc.mil>
Message-ID: <Line.LNX.4.64.0707240908260.4367@d.namei>
References: <20070723124502.17C7.YNAKAM@hitachisoft.jp>
 <1185220711.4177.30.camel@moss-spartans.epoch.ncsc.mil>  <46A56CBB.6020805@ak.jp.nec.com>
 <1185279143.16598.8.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 24 Jul 2007, Stephen Smalley wrote:

> > There is another background, although Nakamura-san didn't mentioned.
> > The AVC hit rate is extremely high, so getting longer the chain of
> > avtab hash list does not have maeningful difference in performance.
> 
> I have to wonder then whether we should just unconditionally shrink the
> avtab, regardless of embedded or not.  And revert from vmalloc to
> kmalloc for it.

Yes, I think we should aim at having a single value which works for the 
general case, and only make it configurable if the need for 
configurability can be demonstrated.

We'd need to see some performance figures before making the change.


-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
