Subject: Re: [RFC & PATCH] inherited type definition.
From: Stephen Smalley <sds@tycho.nsa.gov>
To: KaiGai Kohei <kaigai@kaigai.gr.jp>
Cc: Kaigai Kohei <kaigai@ak.jp.nec.com>,
   SELinux Mail List <selinux@tycho.nsa.gov>
In-Reply-To: <423E9CFF.3080808@kaigai.gr.jp>
References: <42346C17.3090301@kaigai.gr.jp>
	 <1110808202.21378.51.camel@moss-spartans.epoch.ncsc.mil>
	 <4235C937.3030404@kaigai.gr.jp>
	 <1110824712.21378.196.camel@moss-spartans.epoch.ncsc.mil>
	 <4236CC03.5010104@kaigai.gr.jp>
	 <1110897751.25947.52.camel@moss-spartans.epoch.ncsc.mil>
	 <4237B950.2090604@ak.jp.nec.com>
	 <1110981928.4802.81.camel@moss-spartans.epoch.ncsc.mil>
	 <42394ECA.7010204@ak.jp.nec.com>
	 <1111067742.8664.31.camel@moss-spartans.epoch.ncsc.mil>
	 <42399AE4.5040508@kaigai.gr.jp>  <423E9CFF.3080808@kaigai.gr.jp>
Content-Type: text/plain
Date: Mon, 21 Mar 2005 10:59:42 -0500
Message-Id: <1111420782.13101.16.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2005-03-21 at 19:07 +0900, KaiGai Kohei wrote:
> This attached patch implements (1) EXTENDS syntax with TYPE statement and
> (2) '@' prefix to distinguish whether an assigned type/attribute includes
> own child types or not.

Thanks for this revised patch.  I think at this point we need some
concrete examples of how this new language extension can be applied to
solve real problems in a manner that is superior to the use of macros
(or alternatively, if the language supported them, templates of some
kind).  That will help us determine whether this language extension is
justified.

-- 
Stephen Smalley <sds@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
