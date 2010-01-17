Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o0JDAKKv032324
	for <selinux@tycho.nsa.gov>; Tue, 19 Jan 2010 08:10:20 -0500
Received: from moss-lions.epoch.ncsc.mil (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id o0JDCpGD016434
	for <selinux@tycho.nsa.gov>; Tue, 19 Jan 2010 13:12:51 GMT
Received: from moss-lions.epoch.ncsc.mil (localhost [127.0.0.1])
	by moss-lions.epoch.ncsc.mil (8.14.3/8.14.3) with ESMTP id o0JD8N7D003055
	for <selinux@tycho.nsa.gov>; Tue, 19 Jan 2010 08:08:23 -0500
Received: (from jwcart2@localhost)
	by moss-lions.epoch.ncsc.mil (8.14.3/8.14.3/Submit) id o0JD8NIW003053
	for selinux@tycho.nsa.gov; Tue, 19 Jan 2010 08:08:23 -0500
Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o0H629J3010241
	for <selinux@tycho.nsa.gov>; Sun, 17 Jan 2010 01:02:09 -0500
Received: from mail-pz0-f193.google.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id o0H64mgR021114
	for <selinux@tycho.nsa.gov>; Sun, 17 Jan 2010 06:04:48 GMT
Received: by pzk31 with SMTP id 31so107729pzk.30
        for <selinux@tycho.nsa.gov>; Sat, 16 Jan 2010 22:02:04 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20100115081028.GA14004@heat>
References: <20100114173639.GA15587@us.ibm.com> <20100115081028.GA14004@heat>
From: Kyle Moffett <kyle@moffetthome.net>
Date: Sun, 17 Jan 2010 01:01:41 -0500
Message-ID: <f73f7ab81001162201v1956351boa9241ce440e62a09@mail.gmail.com>
Subject: Re: disablenetwork (v5) patches
To: Michael Stone <michael@laptop.org>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Andi Kleen <andi@firstfloor.org>, David Lang <david@lang.hm>,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Valdis Kletnieks <Valdis.Kletnieks@vt.edu>,
        Bryan Donlan <bdonlan@gmail.com>, Evgeniy Polyakov <zbr@ioremap.net>,
        "C. Scott Ananian" <cscott@cscott.net>,
        James Morris <jmorris@namei.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Bernie Innocenti <bernie@codewiz.org>,
        Mark Seaborn <mrs@mythic-beasts.com>,
        Randy Dunlap <randy.dunlap@oracle.com>,
        =?UTF-8?Q?Am=C3=A9rico_Wang?= <xiyou.wangcong@gmail.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Samir Bellabes <sam@synack.fr>,
        Casey Schaufler <casey@schaufler-ca.com>,
        "Serge E. Hallyn" <serue@us.ibm.com>, Pavel Machek <pavel@ucw.cz>,
        Al Viro <viro@zeniv.linux.org.uk>, Andrew Morgan <morgan@kernel.org>,
        selinux@tycho.nsa.gov
Content-Type: text/plain; charset=UTF-8
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, Jan 15, 2010 at 03:10, Michael Stone <michael@laptop.org> wrote:
> As promised, here are patches implementing and documenting a CAP_SETPCAP-gated
> "enable" bit along with a couple of other tweaks discussed earlier in the
> thread. For ease of development and review, the following four patches
> extend the disablenetwork (v4) patch series rather than replacing it.

To be honest, I'm still not convinced that this is the right way to
approach your problem.  I think you would be much better off with
something analogous to the stripped-down SELinux policy I sent in an
earlier email (150 lines, give or take).  By using the appropriate
SELinux hooks you can obtain the *exact* same enforcement, but without
adding any code to the kernel.

I have some time this week to split out my SELinux policy build
machinery; I will pull out a standalone set of files to build the
policy and do some extra testing on one of my bog-standard Debian
boxes and then send it all out again.

Cheers,
Kyle Moffett


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
