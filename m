Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k8AIRakk024650
	for <selinux@tycho.nsa.gov>; Sun, 10 Sep 2006 14:27:36 -0400
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id k8AIRDSZ019202
	for <selinux@tycho.nsa.gov>; Sun, 10 Sep 2006 18:27:13 GMT
Message-ID: <45045913.5080500@gentoo.org>
Date: Sun, 10 Sep 2006 14:27:31 -0400
From: Joshua Brindle <method@gentoo.org>
MIME-Version: 1.0
To: Richard Hally <rhally@mindspring.com>
CC: KaiGai Kohei <kaigai@kaigai.gr.jp>, selinux@tycho.nsa.gov
Subject: Re: [RFC] SELinux and PostgreSQL (draft v2)
References: <44FFEB42.90203@kaigai.gr.jp> <45039AC2.3040309@kaigai.gr.jp> <45045046.40905@mindspring.com>
In-Reply-To: <45045046.40905@mindspring.com>
Content-Type: text/plain; charset=ISO-2022-JP
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Richard Hally wrote:
> KaiGai Kohei wrote:
>   
>> In recent days, I'm making a plan to enhance PostgreSQL with SELinux.
>> I posted the first draft of this plan a few days ago, and I got many
>> response. Thanks for your comments so much.
>> (Especially, Joshua and Russell)
>>
>> The followings are the revised and summarized plan (draft v2).
>> I'm welcoming any comments to improve the project.
>>
>>     
>
> Please help me understand why this addition is needed.
> Would it be more appropriate to extend the existing roles and privileges
> mechanism that already exists in PostgreSQL rather than adding all this
> additional burden to the kernel object classes and access vector cache?
> I can understand the need to extend access control the columns and rows
> but most of the higher level controls already exist.
>
> Thank you for your help,
> Richard Hally
>
>   
It extends a proven MAC system to the database and allows us to have
centralized policies and use the already existing process labels. It
also allows the flexibility of SELinux (both mechanism and policy) to be
applied to the database without modifying the database server down the
line.

You can do privilege separation in the database system via process
labels instead of only by dbms role. This is analogous to using fine
grained types to break up root privileges.

Also, at some point (hopefully soon) we should be moving userspace
object class decision making to a userspace security server that can
provide answers to userspace object managers without the policy being in
unswappable kernel memory.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
