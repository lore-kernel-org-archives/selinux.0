Message-ID: <1345809730.18849.11.camel@moss-pluto.epoch.ncsc.mil>
Subject: audit patches
From: Stephen Smalley <sds@tycho.nsa.gov>
To: William Roberts <bill.c.roberts@gmail.com>
Cc: Haiqing Jiang <hqjiang1988@gmail.com>, selinux@tycho.nsa.gov
Date: Fri, 24 Aug 2012 08:02:10 -0400
In-Reply-To: <CAFftDdqs9=nt9m4kCd0wva4FtE=wvC2hyUFbcb4gj02GrCo=vQ@mail.gmail.com>
References: <1343414055-3831-1-git-send-email-hqjiang1988@gmail.com>
	 <1343414258.17570.72.camel@moss-pluto.epoch.ncsc.mil>
	 <CAFftDdqs9=nt9m4kCd0wva4FtE=wvC2hyUFbcb4gj02GrCo=vQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2012-08-23 at 19:28 -0700, William Roberts wrote:
> I am trying to locate those patches for auditing, can someone please
> point us in the right direction?
> 
> Are these them?
> https://www.redhat.com/archives/linux-audit/2011-October/msg00030.html

That was one version of them.  They were mainlined in Linux 3.3, commit
29ef73b7a82.  Then you have to enable CONFIG_AUDITSYSCALL in your kernel
configuration.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
