Subject: Re: [RFC & PATCH] inherited type definition.
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Cc: KaiGai Kohei <kaigai@kaigai.gr.jp>,
   SELinux Mail List <selinux@tycho.nsa.gov>, kaigai@ak.jp.nec.com
In-Reply-To: <20050314160158.GD1246@lkcl.net>
References: <42346C17.3090301@kaigai.gr.jp>
	 <1110808202.21378.51.camel@moss-spartans.epoch.ncsc.mil>
	 <20050314151351.GC1246@lkcl.net>
	 <1110813732.21378.91.camel@moss-spartans.epoch.ncsc.mil>
	 <20050314160158.GD1246@lkcl.net>
Content-Type: text/plain
Date: Mon, 14 Mar 2005 15:10:50 -0500
Message-Id: <1110831050.21378.232.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2005-03-14 at 16:01 +0000, Luke Kenneth Casson Leighton wrote:
> what is the one significant distinct advantage that the proposed
> inheritance thing gives you that macro refactoring cannot?

Direct expression of certain type relationships in the language would
allow tools to manipulate such relationships without having to deal with
the much less constrained world of m4 macros.  I can understand that
desire; I just want to make sure that it is done in a way that will be
practically useful.  The not-yet-merged binary policy modules support
has no way today to deal with e.g. instantiation of program domains for
each user role/domain.

-- 
Stephen Smalley <sds@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
