Date: Fri, 18 Mar 2005 23:03:51 +0000
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Karl MacMillan <kmacmillan@tresys.com>
Cc: "'Stephen Smalley'" <sds@tycho.nsa.gov>,
   "'Kaigai Kohei'" <kaigai@ak.jp.nec.com>,
   "'KaiGai Kohei'" <kaigai@kaigai.gr.jp>,
   "'SELinux Mail List'" <selinux@tycho.nsa.gov>, selinux-dev@tresys.com
Subject: Re: [RFC & PATCH] inherited type definition.
Message-ID: <20050318230350.GM8040@lkcl.net>
References: <1111151632.17131.36.camel@moss-spartans.epoch.ncsc.mil> <200503182228.j2IMSv8R009703@gotham.columbia.tresys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200503182228.j2IMSv8R009703@gotham.columbia.tresys.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, Mar 18, 2005 at 05:28:57PM -0500, Karl MacMillan wrote:
> Also, the more I think about it the more convinced I am that the show-stopper
> limitation of the extends syntax is that it allows only one subset of access.

 there is nothing to stop you using an extends inside a macro:

	 $1_t EXTENDS $1_ftp_t

 l.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
