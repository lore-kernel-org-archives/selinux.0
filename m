Subject: RE: [RFC & PATCH] inherited type definition.
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Karl MacMillan <kmacmillan@tresys.com>
Cc: "'Kaigai Kohei'" <kaigai@ak.jp.nec.com>,
   "'KaiGai Kohei'" <kaigai@kaigai.gr.jp>,
   "'SELinux Mail List'" <selinux@tycho.nsa.gov>, selinux-dev@tresys.com
In-Reply-To: <1111151632.17131.36.camel@moss-spartans.epoch.ncsc.mil>
References: <200503172142.j2HLfm8R001729@gotham.columbia.tresys.com>
	 <1111151632.17131.36.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Fri, 18 Mar 2005 08:56:28 -0500
Message-Id: <1111154188.17131.39.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2005-03-18 at 08:13 -0500, Stephen Smalley wrote:
> On Thu, 2005-03-17 at 16:41 -0500, Karl MacMillan wrote:
> > Yes - and I have already complained about those in another email. I'll be happy
> > to send a patch disallowing complement in allow rules if you would accept it :)
> 
> I'd be willing to consider it; I'm not sure it is being used in any
> allow rules presently, just in assertions, and the type set exclusion
> (-) notation seems better suited for allow rules.

I'd also be happy to prohibit use of asterisk (*) in the type fields.

-- 
Stephen Smalley <sds@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
