Subject: Re: Appropriate number of hash slots for te_avtab(Was:Re: [RFC]
	Dynamically deciding number of hash slots for avtab
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Yuichi Nakamura <himainu-ynakam@miomio.jp>
Cc: James Morris <jmorris@namei.org>, ynakam@hitachisoft.jp,
        selinux@tycho.nsa.gov, busybox@kaigai.gr.jp, eparis@parisplace.org,
        kaigai@ak.jp.nec.com, method@manicmethod.com
In-Reply-To: <20070808235802.1b3047c6.himainu-ynakam@miomio.jp>
References: <20070807175824.4CBF.YNAKAM@hitachisoft.jp>
	 <1186490009.26457.10.camel@moss-spartans.epoch.ncsc.mil>
	 <20070808150021.C617.YNAKAM@hitachisoft.jp>
	 <Pine.LNX.4.64.0708080740400.12788@us.intercode.com.au>
	 <20070808235802.1b3047c6.himainu-ynakam@miomio.jp>
Content-Type: text/plain
Date: Wed, 08 Aug 2007 11:01:29 -0400
Message-Id: <1186585289.6916.125.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2007-08-08 at 23:58 +0900, Yuichi Nakamura wrote:
> On Wed, 8 Aug 2007 07:43:00 -0700 (PDT)
> James Morris  wrote:
> 
> > On Wed, 8 Aug 2007, Yuichi Nakamura wrote:
> > 
> > > * Number of slot = num of rules/2
> > > SELinux:4096 avtab hash slots allocated. Num of rules:8188
> > > - default
> > > rules:  8188 entries and 2809/4096 buckets used, longest chain length 21
> > > - jhash
> > > rules:  8188 entries and 3466/4096 buckets used, longest chain length 9 
> > 
> > This looks pretty good.
> > 
> > What is the performance overhead of jhash vs. the existing hash?
> I am not sure now.
> 
> > 
> > (You could probably make a kernel module which calls the avc in a loop 
> > with some repeatable sequence of paramters).
> OK, I will try it next.

If so, don't bother calling the avc - call avtab_search directly.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
