Date: Mon, 5 Mar 2007 18:02:50 +0900
From: Yuichi Nakamura <ynakam@hitachisoft.jp>
To: "Ryan Bradetich" <rbradetich@gmail.com>
Cc: ynakam@hitachisoft.jp, "Stephen Smalley" <sds@tycho.nsa.gov>,
        selinux@tycho.nsa.gov,
        "Christopher J. PeBenito" <cpebenito@tresys.com>, busybox@kaigai.gr.jp
Subject: Re: Assgin domain to busybox applet(Re: Failed write to
 /selinux/context in selinux_trans_to_raw_contex()
Message-Id: <20070305180250.dd51b87b.ynakam@hitachisoft.jp>
In-Reply-To: <e739902b0703042232n7eccb84esbed5c7c386d59f2b@mail.gmail.com>
References: <e739902b0702282357i2f5645bbmab4c04a0bdb1d3f3@mail.gmail.com>
	<1172751150.19041.536.camel@moss-spartans.epoch.ncsc.mil>
	<e739902b0703010810g64146e59h184dfe13365e16ce@mail.gmail.com>
	<1172765760.19041.578.camel@moss-spartans.epoch.ncsc.mil>
	<e739902b0703011324y561503a0v49ded6db4b700b8c@mail.gmail.com>
	<e739902b0703012254j5b078fckd364da8b8ccfb4ab@mail.gmail.com>
	<1172836471.19041.611.camel@moss-spartans.epoch.ncsc.mil>
	<e739902b0703020821y5d880932re07b74cca44e0b9c@mail.gmail.com>
	<20070305092421.c5121997.ynakam@hitachisoft.jp>
	<e739902b0703042232n7eccb84esbed5c7c386d59f2b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello.

"Ryan Bradetich"  wrote:
> Excellent!  I will grab a copy of this code later this week so I can
> look at it in more detail.   Thanks for the link!
Thank you, but you have to be careful about risk.
Our code uses dynamic domain transition, 
but you have to be careful, because attacker can change domain by setcon call.
It may be better to combine wrapper with our code.

Regards,
Yuichi Nakamura

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
