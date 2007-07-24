Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l6OI52Xe026833
	for <selinux@tycho.nsa.gov>; Tue, 24 Jul 2007 14:05:02 -0400
Received: from smtp-bedford.mitre.org (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l6OI50XQ009059
	for <selinux@tycho.nsa.gov>; Tue, 24 Jul 2007 18:05:01 GMT
Received: from smtp-bedford.mitre.org (localhost.localdomain [127.0.0.1])
	by smtp-bedford.mitre.org (8.12.11.20060308/8.12.11) with SMTP id l6OI50TS024540
	for <selinux@tycho.nsa.gov>; Tue, 24 Jul 2007 14:05:00 -0400
Received: from smtp-bedford.mitre.org (localhost.localdomain [127.0.0.1])
	by smtp-bedford.mitre.org (Postfix) with ESMTP id 87110BF7D
	for <selinux@tycho.nsa.gov>; Tue, 24 Jul 2007 14:05:00 -0400 (EDT)
Received: from linus.mitre.org (linus.mitre.org [129.83.10.1])
	by smtp-bedford.mitre.org (8.12.11.20060308/8.12.11) with ESMTP id l6OI50Z3024531
	for <selinux@tycho.nsa.gov>; Tue, 24 Jul 2007 14:05:00 -0400
Received: from oolong.mitre.org (oolong.mitre.org [129.83.162.84])
	by linus.mitre.org (8.12.11/8.12.10) with ESMTP id l6OI50Qv026945
	for <selinux@tycho.nsa.gov>; Tue, 24 Jul 2007 14:05:00 -0400 (EDT)
To: selinux@tycho.nsa.gov
Subject: Re: [patch] libselinux:  fix type mismatch in string_to_security_class
References: <1185200517.1998.14.camel@moss-spartans.epoch.ncsc.mil>
From: ramsdell@mitre.org (John D. Ramsdell)
Date: 24 Jul 2007 14:05:00 -0400
In-Reply-To: <1185200517.1998.14.camel@moss-spartans.epoch.ncsc.mil>
Message-ID: <ogtodi14r03.fsf@oolong.mitre.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley <sds@tycho.nsa.gov> writes:

> Fix type mismatch in string_to_security_class, produces seg fault on x86_64.
> For https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=249038

...
> -		size_t value;
> +		unsigned int value;
...
>  
> -		if (sscanf(buf, "%u", (unsigned int *)&value) != 1)
> +		if (sscanf(buf, "%u", &value) != 1)

There is another way to fix this bug.  You can leave the type as
size_t, but use the C99 z modifier.  GCC supports the z modifier.

> -		if (sscanf(buf, "%u", (unsigned int *)&value) != 1)
> +		if (sscanf(buf, "%zu", &value) != 1)

John

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
