Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m1PH7ITq009041
	for <selinux@tycho.nsa.gov>; Mon, 25 Feb 2008 12:07:18 -0500
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with SMTP id m1PH7HbX022584
	for <selinux@tycho.nsa.gov>; Mon, 25 Feb 2008 17:07:18 GMT
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: Re: [PATCH] SE-PostgreSQL Security Policy
Date: Mon, 25 Feb 2008 11:30:28 -0500
Message-ID: <1203957028.32061.69.camel@gorn>
In-Reply-To: <47B2B885.4070300@ak.jp.nec.com>
References: <47B2B885.4070300@ak.jp.nec.com>
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: "Kohei KaiGai" <kaigai@ak.jp.nec.com>
Cc: <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2008-02-13 at 18:29 +0900, Kohei KaiGai wrote:
> The attached patch adds support for SE-PostgreSQL.
> Most part of them are same as currently we are distributing via RPM package.
> 
> This patch adds some booleans, attributes and types.
> You can find out the detailed description about works of them in the chapter 5
> of "The Security-Enhanced PostgreSQL Security Guide".
> See, http://sepgsql.googlecode.com/files/sepgsql_security_guide.20070903.en.pdf
> 
> Any comment please,

Just like with the X server, I don't believe that sepostgres should have
its own module.  At first glance, there appears to be too many
attributes.  I'm guessing that you're doing the same thing that is done
with the *_unconfined() interfaces.  We mainly do that to optimize size
since unconfined brings in so many rules.  I also see references to
types and attributes that belong do the module.  Also the auditing
tunables seem unneeded; they seem to be more for debugging use.  I think
I can get a better handle on the policy with these revisions.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
