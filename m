Subject: Re: Making new roles
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Julian Onions <Julian.Onions@nexor.com>
Cc: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
In-Reply-To: <0DF1039D1D45FA49BE6F493398D45F31119F600077@IE2RD2XVS231.red002.local>
References: 
	 <0DF1039D1D45FA49BE6F493398D45F31119F600077@IE2RD2XVS231.red002.local>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 12 Jul 2011 10:08:36 -0400
Message-ID: <1310479716.309.5.camel@moss-pluto>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2011-07-12 at 03:55 -0700, Julian Onions wrote:
> What do I need to add a new role such that I can change to it with
> newrole?

See
http://selinuxproject.org/page/RefpolicyBasicRoleCreation

> type mynewrole_t;
<snip>
> role mynewrole_r types mynewtype_t;

Which is it supposed to be?  mynewrole_t or mynewtype_t?

> This is true even with enforcing disabled.
> 
> # newrole –r mynewrole_r
> 
> root:mynewrole_r:mynewrole_t:s0 is not a valid context.

I'd guess that this is due to not specifying:
role mynewrole_r types mynewrole_t;
in your policy (you specified mynewtype_t instead above).

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
