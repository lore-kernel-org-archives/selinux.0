Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p5GCcefr012243
	for <selinux@tycho.nsa.gov>; Thu, 16 Jun 2011 08:38:44 -0400
Received: from exchange10.columbia.tresys.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id p5GCchm0005947
	for <selinux@tycho.nsa.gov>; Thu, 16 Jun 2011 12:38:43 GMT
Message-ID: <4DF9F952.9040702@tresys.com>
Date: Thu, 16 Jun 2011 08:38:42 -0400
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
MIME-Version: 1.0
To: Sam Gandhi <samgandhi9@gmail.com>
CC: <selinux@tycho.nsa.gov>
Subject: Re: /etc/selinux/$P/users/local.users and system.users are they deprecated?
References: <BANLkTikdwRevmnuj7Lw6Vtv=d-iFHd45Yg@mail.gmail.com>	<4DF8B832.9060307@tresys.com> <BANLkTikQc7DTnOSkxMk4i7uzPTW3XbBZxA@mail.gmail.com>
In-Reply-To: <BANLkTikQc7DTnOSkxMk4i7uzPTW3XbBZxA@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 06/15/11 16:36, Sam Gandhi wrote:
>>> In my policy definitions I am defining a new user diags_u, type
>>> diags_t and role diags_r, essentially following statements in
>>> policy.conf (through macros etc)
>>>
>>> type diags_t, domain, userdomain, unpriv_userdomain, nscd_client_domain, privfd;
>>> role diags_r types diags_t;
>>> user diags_u roles { diags_r };
>>>
>>> Is that sufficient?  fwiw, I have been able to transition to
>>> diags_u:diags_r:diags_t context using the newrole command, when using
>>> policy that contains above statements.
>>
>> And it works in enforcing?  I would expect it to fail if you don't have
>> a role allow:
>>
>> allow system_r diags_r;
>>
> 
> I had that statement in my policy sorry I didn't include it original email.
> 
> I can transition to diags_u:diags_r:diags_t context via newrole,
> although when using pam_selinux to login as user diags initial context
> that is set is diags_u:system_r:initrc_t
> 
> Looks like my $P/contexts/default_context or $P/contexts/users/diag_u
> file is wrong (?)

Odd.  Can you confirm that your getty is getty_t and the login program
runs in local_login_t?

If those are correct, then you should make sure you include
diags_r:diags_t on the system_r:local_login_t lines of the above two files.

-- 
Chris PeBenito
Tresys Technology, LLC
www.tresys.com | oss.tresys.com

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
