Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j0IE9QIi019860
	for <selinux@tycho.nsa.gov>; Tue, 18 Jan 2005 09:09:26 -0500 (EST)
Received: from epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j0IE7S9K021440
	for <selinux@tycho.nsa.gov>; Tue, 18 Jan 2005 14:07:28 GMT
Subject: Re: Role transition error
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Steve Brueckner <steve@atc-nycorp.com>
Cc: "'selinux@tycho.nsa.gov'" <selinux@tycho.nsa.gov>
In-Reply-To: <60D45469A1AAD311A04C009027B6BF6804FCF003@server20.inside.oracorp.com>
References: 
	 <60D45469A1AAD311A04C009027B6BF6804FCF003@server20.inside.oracorp.com>
Content-Type: text/plain
Message-Id: <1106056997.18274.86.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Tue, 18 Jan 2005 09:03:17 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2005-01-17 at 18:01, Steve Brueckner wrote:
> Added the following to .../strict/src/policy/users
> user engineer roles { user_r developer_r };
> 
> Added the following to .../strict/src/policy/domains/user.te
> full_user_role(developer)
> allow system_r developer_r
> allow sysadm_r developer_r
> allow user_r developer_r
> allow staff_r developer_r

No semicolon terminators?  Also, this is typically handled using the
role_tty_type_change() macro, which also includes type_change rules you
need to define proper type changes for the tty upon a newrole or su
between the roles.

> Added the following into in_user_role macro in
> .../strict/src/policy/macros/user_macros.te
> role developer_r types $1;

Hmmm...normally, the role authorization for the base user domain is
defined by the base_user_domain() macro in base_user_macros.te.  The
in_user_role() macro in user_macros.te is used to allow access for
various program domains.  If you just want to allow developer_r to enter
user_t, then just add an explicit role developer_r types user_t; to
domains/user.te.  Only put it in a macro if you want it applied to
everything that uses that macro.  

However, I'm not sure about your goal here; if you truly want to
separate developer_r from user_r, you need a separate user domain for
it, i.e. developer_t, which is indeed defined if you used
full_user_role().  Why aren't you using developer_t as the default type
for the role?

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
