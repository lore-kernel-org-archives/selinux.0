Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l28DW2O4001847
	for <selinux@tycho.nsa.gov>; Thu, 8 Mar 2007 08:32:02 -0500
Received: from py-out-1112.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l28DXUko023148
	for <selinux@tycho.nsa.gov>; Thu, 8 Mar 2007 13:33:30 GMT
Received: by py-out-1112.google.com with SMTP id a78so193486pyh
        for <selinux@tycho.nsa.gov>; Thu, 08 Mar 2007 05:33:30 -0800 (PST)
Message-ID: <45F010A4.4020201@kaigai.gr.jp>
Date: Thu, 08 Mar 2007 22:33:24 +0900
From: KaiGai Kohei <kaigai@kaigai.gr.jp>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
CC: selinux@tycho.nsa.gov
Subject: Re: [ANN] SE-PostgreSQL 8.2.3-1.0 alpha release
References: <45EC0D21.2070706@kaigai.gr.jp>  <45EC2C10.6050603@kaigai.gr.jp> <1173284267.10747.9.camel@sgc>
In-Reply-To: <1173284267.10747.9.camel@sgc>
Content-Type: text/plain; charset=ISO-2022-JP
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Christopher J. PeBenito wrote:
> On Mon, 2007-03-05 at 23:41 +0900, KaiGai Kohei wrote:
>> The attached patch adds new object classes, access vectors and
>> booleans related to database.
>> SE-PostgreSQL uses them to manage the various kinds of database
>> objects such as tables, columns, tuples and so on.
>>
>> The most of security policies are provided as a binary security
>> policy within RPM package. But it requires the definition of new
>> object classes, access vectors and booleans in the base policy.
>>
>> Please apply it.
> 
> Is the code on a path to being merged upstream?  I'm hesitant to apply
> class changes until the code is on a plan to be merged.

Pushing to the upstreamed PostgreSQL is one of the next activities.
No need to say, I'm targeting it to be merged as a part of PostgreSQL.

I'll submit a patch to add new object classes again after discussion
in the pgsql-hackers list. But I'm desiring the object class numbers
are fixed earlier. (currently, I uses 60 - 65 to represent them)

Thanks,
-- 
KaiGai Kohei <kaigai@kaigai.gr.jp>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
