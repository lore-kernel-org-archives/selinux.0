Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l27GGNcO023841
	for <selinux@tycho.nsa.gov>; Wed, 7 Mar 2007 11:16:23 -0500
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id l27GHmuo010416
	for <selinux@tycho.nsa.gov>; Wed, 7 Mar 2007 16:17:49 GMT
Subject: Re: [ANN] SE-PostgreSQL 8.2.3-1.0 alpha release
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: KaiGai Kohei <kaigai@kaigai.gr.jp>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <45EC2C10.6050603@kaigai.gr.jp>
References: <45EC0D21.2070706@kaigai.gr.jp>  <45EC2C10.6050603@kaigai.gr.jp>
Content-Type: text/plain
Date: Wed, 07 Mar 2007 11:17:47 -0500
Message-Id: <1173284267.10747.9.camel@sgc>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2007-03-05 at 23:41 +0900, KaiGai Kohei wrote:
> The attached patch adds new object classes, access vectors and
> booleans related to database.
> SE-PostgreSQL uses them to manage the various kinds of database
> objects such as tables, columns, tuples and so on.
> 
> The most of security policies are provided as a binary security
> policy within RPM package. But it requires the definition of new
> object classes, access vectors and booleans in the base policy.
> 
> Please apply it.

Is the code on a path to being merged upstream?  I'm hesitant to apply
class changes until the code is on a plan to be merged.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
