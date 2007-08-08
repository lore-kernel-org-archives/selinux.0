Date: Thu, 9 Aug 2007 00:02:37 +0900
From: Yuichi Nakamura <himainu-ynakam@miomio.jp>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov, busybox@kaigai.gr.jp
Subject: Re: Appropriate number of hash slots for te_avtab(Was:Re: [RFC]
 Dynamically deciding number of hash slots for avtab
Message-Id: <20070809000237.ec97dbcb.himainu-ynakam@miomio.jp>
In-Reply-To: <1186584312.6916.111.camel@moss-spartans.epoch.ncsc.mil>
References: <20070807175824.4CBF.YNAKAM@hitachisoft.jp>
	<1186490009.26457.10.camel@moss-spartans.epoch.ncsc.mil>
	<20070808150021.C617.YNAKAM@hitachisoft.jp>
	<1186584312.6916.111.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 08 Aug 2007 10:45:12 -0400
Stephen Smalley  wrote:
<snip>
> > jhash is also better.
> > 
> > Can We use jhash ?
> 
> I think so, as long as it doesn't impose a significant overhead.
> Running some benchmarks would be useful, although the AVC will hide much
> of it.  Might want to set /selinux/avc/cache_threshold to a low value
> for measurement so that you see the actual cost of the avtab lookups.
I will try  it. 
Please wait for next result.

> 
> -- 
> Stephen Smalley
> National Security Agency
> 
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.

Regards,
Yuichi Nakamura

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
