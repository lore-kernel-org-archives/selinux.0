Subject: Re: Question about integration of IPsec with SELinux?
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Cc: Valdis.Kletnieks@vt.edu, Park Lee <parklee_sel@yahoo.com>,
   Casey Schaufler <casey@schaufler-ca.com>, SELinux <SELinux@tycho.nsa.gov>
In-Reply-To: <20050612202539.GE31033@lkcl.net>
References: <20050611194952.24393.qmail@web31609.mail.mud.yahoo.com>
	 <20050612021611.94597.qmail@web51501.mail.yahoo.com>
	 <20050612114421.GA31033@lkcl.net>
	 <200506121239.j5CCdksZ009355@turing-police.cc.vt.edu>
	 <20050612152038.GC31033@lkcl.net>
	 <200506121918.j5CJIhlt021805@turing-police.cc.vt.edu>
	 <20050612202539.GE31033@lkcl.net>
Content-Type: text/plain
Date: Mon, 13 Jun 2005 09:00:37 -0400
Message-Id: <1118667637.24565.17.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 2005-06-12 at 21:25 +0100, Luke Kenneth Casson Leighton wrote:
>  well, if you're going to follow the convention of passing around the
>  context [as a string] then you might as well continue with that
>  tradition...
> 
>  i dunno... say, by adding @hostname or @dns.domain.name
> 
>  e.g. foo_u:bar_r:baz_t@toplevelmlsgroup.mycompany.co.uk or
>  foo_u:bar_r:baz_t@myworkstation.mycompany.co.uk

No; you want a separate notion of policy domain of interpretation (DOI),
which is a separate component of the security association (not the
security context).

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
