Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k4THDlUo006727
	for <selinux@tycho.nsa.gov>; Mon, 29 May 2006 13:13:47 -0400
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k4THDkOn016510
	for <selinux@tycho.nsa.gov>; Mon, 29 May 2006 17:13:46 GMT
Subject: Re: Use of role dominance declaration
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Mario Fanelli <mario.fanelli@gmail.com>
Cc: SeLinux Mailing List <selinux@tycho.nsa.gov>
In-Reply-To: <447b1d3f.79f11cdc.6031.00a2@mx.gmail.com>
References: <447b1d3f.79f11cdc.6031.00a2@mx.gmail.com>
Content-Type: text/plain; charset=iso-8859-13
Date: Mon, 29 May 2006 13:14:26 -0400
Message-Id: <1148922867.14262.86.camel@sgc.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2006-05-29 at 18:11 +0200, Mario Fanelli wrote:
> I donÿt understand what means role dominance declaration.. Anyone can
> give me an explanation?

This means that a role will be allowed all the types of all roles that
it dominates in addition to those it is explicitly allowed.  For
example, say you have two roles foo_r and bar_r declared thusly:

role foo_r types a_t;
role bar_r types b_t;

if you make foo_r dominate bar_r:

dominance { role foo_r { role bar_r; } }

then the result is that foo_r is allowed a_t and b_t, and bar_r is
allowed b_t.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
