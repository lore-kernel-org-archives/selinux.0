Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p5FKa9LR001659
	for <selinux@tycho.nsa.gov>; Wed, 15 Jun 2011 16:36:09 -0400
Received: from mail-iy0-f181.google.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id p5FKa8H5019482
	for <selinux@tycho.nsa.gov>; Wed, 15 Jun 2011 20:36:08 GMT
Received: by iyb26 with SMTP id 26so731186iyb.12
        for <selinux@tycho.nsa.gov>; Wed, 15 Jun 2011 13:36:08 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4DF8B832.9060307@tresys.com>
References: <BANLkTikdwRevmnuj7Lw6Vtv=d-iFHd45Yg@mail.gmail.com>
	<4DF8B832.9060307@tresys.com>
Date: Wed, 15 Jun 2011 13:36:08 -0700
Message-ID: <BANLkTikQc7DTnOSkxMk4i7uzPTW3XbBZxA@mail.gmail.com>
Subject: Re: /etc/selinux/$P/users/local.users and system.users are they deprecated?
From: Sam Gandhi <samgandhi9@gmail.com>
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
Cc: selinux@tycho.nsa.gov
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

>
>> In my policy definitions I am defining a new user diags_u, type
>> diags_t and role diags_r, essentially following statements in
>> policy.conf (through macros etc)
>>
>> type diags_t, domain, userdomain, unpriv_userdomain, nscd_client_domain, privfd;
>> role diags_r types diags_t;
>> user diags_u roles { diags_r };
>>
>> Is that sufficient?  fwiw, I have been able to transition to
>> diags_u:diags_r:diags_t context using the newrole command, when using
>> policy that contains above statements.
>
> And it works in enforcing?  I would expect it to fail if you don't have
> a role allow:
>
> allow system_r diags_r;
>

I had that statement in my policy sorry I didn't include it original email.

I can transition to diags_u:diags_r:diags_t context via newrole,
although when using pam_selinux to login as user diags initial context
that is set is diags_u:system_r:initrc_t

Looks like my $P/contexts/default_context or $P/contexts/users/diag_u
file is wrong (?)

Thanks.
/Sam


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
