Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l0QKYCnT021226
	for <selinux@tycho.nsa.gov>; Fri, 26 Jan 2007 15:34:12 -0500
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id l0QKZC0N010753
	for <selinux@tycho.nsa.gov>; Fri, 26 Jan 2007 20:35:12 GMT
Message-ID: <45BA65FC.60705@tresys.com>
Date: Fri, 26 Jan 2007 15:35:08 -0500
From: Joshua Brindle <jbrindle@tresys.com>
MIME-Version: 1.0
To: Rosalie Hiebel <rosalie.hiebel@L-3Com.com>
CC: selinux@tycho.nsa.gov
Subject: Re: semodule problem
References: <p06002029c1e0096aebf1@[192.168.50.32]>
In-Reply-To: <p06002029c1e0096aebf1@[192.168.50.32]>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Rosalie Hiebel wrote:
> I was able to successfully modify, load, and test policy rules (using 
> audit2allow to add rules) until I ran into a problem with one 
> particular rule I tried to add.   After adding this rule
>
>    allow testserver_t self:process { setcurrent };
>
> then semodule gave me the following error:
>
>   libsepol.check_assertion_helper: assertion on line 0 violated by
>             allow testserver_t testserver_t:process{ setcurrent };
>   libsepol.check_assertions: 1 assertion violations occurred
>   libsermanage.semanage_expand_ssandbox:Expand module failed
>
> Any clues what caused this?
>
> Thanks
# enabling setcurrent breaks process tranquility.  If you do not
# know what this means or do not understand the implications of a
# dynamic transition, you should not be using it!!!
neverallow { domain -set_curr_context } self:process setcurrent;

This neverallow doesn't let anything use setcurrent unless it has the 
set_curr_context attribute (assigned using the domain_dyntrans_type 
interface). You typically shouldn't be using setcurrent anyway, is there 
something specific you are trying to do?


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
