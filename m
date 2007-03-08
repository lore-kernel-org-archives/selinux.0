Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l28EoHVj005005
	for <selinux@tycho.nsa.gov>; Thu, 8 Mar 2007 09:50:17 -0500
Received: from nz-out-0506.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l28EoGko005898
	for <selinux@tycho.nsa.gov>; Thu, 8 Mar 2007 14:50:16 GMT
Received: by nz-out-0506.google.com with SMTP id z3so329516nzf
        for <selinux@tycho.nsa.gov>; Thu, 08 Mar 2007 06:50:15 -0800 (PST)
Message-ID: <45F022A0.3020105@kaigai.gr.jp>
Date: Thu, 08 Mar 2007 23:50:08 +0900
From: KaiGai Kohei <kaigai@kaigai.gr.jp>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: "Christopher J. PeBenito" <cpebenito@tresys.com>, selinux@tycho.nsa.gov,
        Chad Sellers <csellers@tresys.com>
Subject: Re: [ANN] SE-PostgreSQL 8.2.3-1.0 alpha release
References: <45EC0D21.2070706@kaigai.gr.jp>  <45EC2C10.6050603@kaigai.gr.jp>	 <1173284267.10747.9.camel@sgc>  <45F010A4.4020201@kaigai.gr.jp> <1173360830.10467.29.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1173360830.10467.29.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-2022-JP
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> On Thu, 2007-03-08 at 22:33 +0900, KaiGai Kohei wrote:
>> Christopher J. PeBenito wrote:
>>> On Mon, 2007-03-05 at 23:41 +0900, KaiGai Kohei wrote:
>>>> The attached patch adds new object classes, access vectors and
>>>> booleans related to database.
>>>> SE-PostgreSQL uses them to manage the various kinds of database
>>>> objects such as tables, columns, tuples and so on.
>>>>
>>>> The most of security policies are provided as a binary security
>>>> policy within RPM package. But it requires the definition of new
>>>> object classes, access vectors and booleans in the base policy.
>>>>
>>>> Please apply it.
>>> Is the code on a path to being merged upstream?  I'm hesitant to apply
>>> class changes until the code is on a plan to be merged.
>> Pushing to the upstreamed PostgreSQL is one of the next activities.
>> No need to say, I'm targeting it to be merged as a part of PostgreSQL.
>>
>> I'll submit a patch to add new object classes again after discussion
>> in the pgsql-hackers list. But I'm desiring the object class numbers
>> are fixed earlier. (currently, I uses 60 - 65 to represent them)
> 
> Where do things stand wrt dynamic userspace object class and permission
> discovery?  It would be nice to avoid further spread of hardcoded
> classes and permissions in applications if we can avoid it.

See, http://sepgsql.googlecode.com/svn/trunk/src/include/security/sepgsql_internal.h
When I started to develop, 'context' class has the maximum number of object
class, so I defined 'SECCLASS_DATABASE' next to it.
# But it will conflict with 'dccp_socket' class now... :-(

Thanks,
-- 
KaiGai Kohei <kaigai@kaigai.gr.jp>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
