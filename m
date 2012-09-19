Message-ID: <1348057534.4107.2.camel@moss-pluto.epoch.ncsc.mil>
Subject: Re: level
From: Stephen Smalley <sds@tycho.nsa.gov>
To: William Roberts <bill.c.roberts@gmail.com>
Cc: selinux@tycho.nsa.gov
Date: Wed, 19 Sep 2012 08:25:34 -0400
In-Reply-To: <CAFftDdoGiXnOk9qYMvbvzFH=L4muVsNYi1OBGDNmL2x1-D6tDg@mail.gmail.com>
References: 
	<CAFftDdoGiXnOk9qYMvbvzFH=L4muVsNYi1OBGDNmL2x1-D6tDg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2012-09-18 at 16:09 -0700, William Roberts wrote:
> In seapp_contexts when I try to set the level to s0:c56 it works, but
> if I do s0:c1, it does not, any ideas?

No, sounds like a bug.  More information, e.g. the exact entry from
seapp_contexts?

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
