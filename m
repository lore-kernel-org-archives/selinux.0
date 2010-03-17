Subject: Re: working linux and busybox versions
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Manvendra Pratap Singh <manav.emb@gmail.com>
Cc: selinux@tycho.nsa.gov, Kaigai Kohei <kaigai@ak.jp.nec.com>
In-Reply-To: <482a0d8c1003162122y50c4f6adq3d1e4ab7a9d481ed@mail.gmail.com>
References: <482a0d8c1003100413w4b2d060fy493a72f6a76b976e@mail.gmail.com>
	 <1268235831.3678.31.camel@moss-pluto.epoch.ncsc.mil>
	 <482a0d8c1003100914j2709ab7epad0956ca4aa75081@mail.gmail.com>
	 <1268243344.3678.38.camel@moss-pluto.epoch.ncsc.mil>
	 <482a0d8c1003110208g9843309s83e41c6319ff8271@mail.gmail.com>
	 <482a0d8c1003162122y50c4f6adq3d1e4ab7a9d481ed@mail.gmail.com>
Content-Type: text/plain
Date: Wed, 17 Mar 2010 09:58:50 -0400
Message-Id: <1268834330.3899.6.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2010-03-17 at 09:52 +0530, Manvendra Pratap Singh wrote:
> Can anyone suggest me good guide for SELinux on omap3 (beagleboard). I
> tried it myself but I am not able to login after booting. On loging in
> root I get a msg "Cann't get SID for root". Please help me on this
> issue.  Here take a look at boot-log.
> 
> 
> [    0.000000] Security Framework initialized
> [    0.000000] SELinux:  Initializing.
> 
> 
> beagleboard login: root
> login: can't get SID for root

I suspect you haven't loaded a policy into the kernel.  

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
