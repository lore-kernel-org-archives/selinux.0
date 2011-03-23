Subject: Re: [libselinux] add db_language support on label_db.c
From: Stephen Smalley <sds@tycho.nsa.gov>
To: KaiGai Kohei <kaigai@ak.jp.nec.com>
Cc: SE-Linux <selinux@tycho.nsa.gov>
In-Reply-To: <4D256BE8.2010704@ak.jp.nec.com>
References: <4D256BE8.2010704@ak.jp.nec.com>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 23 Mar 2011 08:57:00 -0400
Message-ID: <1300885020.26747.0.camel@moss-pluto>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2011-01-06 at 16:14 +0900, KaiGai Kohei wrote:
> The attached patch add support db_language object class
> to the selabel_lookup(_raw) interfaces.
> It is needed to inform object manager initial label of
> procedural language object.

Thanks, merged as of libselinux 2.0.101.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
