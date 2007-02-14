Subject: Re: SELinux and LFS
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: vin@netwosix.org
Cc: SELinux@tycho.nsa.gov
In-Reply-To: <1171476502.20576.35.camel@sgc.columbia.tresys.com>
References: <1171474739.27788.17.camel@desk.netwosix.org>
	 <1171476502.20576.35.camel@sgc.columbia.tresys.com>
Content-Type: text/plain
Date: Wed, 14 Feb 2007 18:17:16 +0000
Message-Id: <1171477036.20576.37.camel@sgc.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2007-02-14 at 18:08 +0000, Christopher J. PeBenito wrote:
> You need a patched init to load the policy.

To be clearer, init does the initial policy load when the system boots.
It doesn't load the policy at any other time.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
