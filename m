Date: Wed, 8 Aug 2007 08:35:09 -0700 (PDT)
From: James Morris <jmorris@namei.org>
To: Stephen Smalley <sds@tycho.nsa.gov>
cc: Yuichi Nakamura <ynakam@hitachisoft.jp>, selinux@tycho.nsa.gov,
        busybox@kaigai.gr.jp, Eric Paris <eparis@parisplace.org>,
        kaigai@ak.jp.nec.com, method@manicmethod.com
Subject: Re: Appropriate number of hash slots for te_avtab(Was:Re: [RFC]
 Dynamically deciding number of hash slots for avtab
In-Reply-To: <1186584312.6916.111.camel@moss-spartans.epoch.ncsc.mil>
Message-ID: <Pine.LNX.4.64.0708080833570.3111@us.intercode.com.au>
References: <20070807175824.4CBF.YNAKAM@hitachisoft.jp>
 <1186490009.26457.10.camel@moss-spartans.epoch.ncsc.mil>
 <20070808150021.C617.YNAKAM@hitachisoft.jp> <1186584312.6916.111.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 8 Aug 2007, Stephen Smalley wrote:

> > Can We use jhash ?
> 
> I think so, as long as it doesn't impose a significant overhead.

It's now used extensively in the networking code, so I suspect it will be 
ok (and unlikely to be a bottleneck for SELinux), but yep, we do need to 
measure it.

-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
