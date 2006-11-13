Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id kADDtqA2016283
	for <selinux@tycho.nsa.gov>; Mon, 13 Nov 2006 08:55:52 -0500
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id kADDt9K7027507
	for <selinux@tycho.nsa.gov>; Mon, 13 Nov 2006 13:55:09 GMT
Subject: Re: broken interface: userdom_common_user_template
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Michael C Thompson <thompsmc@us.ibm.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <4554F6C5.2090308@us.ibm.com>
References: <4554F6C5.2090308@us.ibm.com>
Content-Type: text/plain
Date: Mon, 13 Nov 2006 08:57:51 -0500
Message-Id: <1163426272.18181.98.camel@sgc.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2006-11-10 at 16:01 -0600, Michael C Thompson wrote:
> So I am seeing a broken interface problem in policy package version 
> selinux-policy-2.4.3-8.
> 
> The problem is as follows:
> 
> # make
> Compiling strict abat module
> /usr/bin/checkmodule:  loading policy configuration from tmp/abat.tmp
> abat.te:49:ERROR 'unknown class context used in rule' at token ';' on 
> line 82511:
> #line 49
>          allow abat_t self:context contains;
> /usr/bin/checkmodule:  error(s) encountered while parsing configuration
> make: *** [tmp/abat.mod] Error 1
> 
> Line 49: userdom_admin_user_template(abat)

You need to add this to it's gen_require():

class context contains;

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
