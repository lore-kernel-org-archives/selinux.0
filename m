Subject: Re: [RFC & PATCH] inherited type definition.
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Kaigai Kohei <kaigai@ak.jp.nec.com>
Cc: KaiGai Kohei <kaigai@kaigai.gr.jp>,
   SELinux Mail List <selinux@tycho.nsa.gov>
In-Reply-To: <42394ECA.7010204@ak.jp.nec.com>
References: <42346C17.3090301@kaigai.gr.jp>
	 <1110808202.21378.51.camel@moss-spartans.epoch.ncsc.mil>
	 <4235C937.3030404@kaigai.gr.jp>
	 <1110824712.21378.196.camel@moss-spartans.epoch.ncsc.mil>
	 <4236CC03.5010104@kaigai.gr.jp>
	 <1110897751.25947.52.camel@moss-spartans.epoch.ncsc.mil>
	 <4237B950.2090604@ak.jp.nec.com>
	 <1110981928.4802.81.camel@moss-spartans.epoch.ncsc.mil>
	 <42394ECA.7010204@ak.jp.nec.com>
Content-Type: text/plain
Date: Thu, 17 Mar 2005 08:55:42 -0500
Message-Id: <1111067742.8664.31.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2005-03-17 at 18:32 +0900, Kaigai Kohei wrote:
> I intend that '@'<type/attribute name> is interpreted as if those
> type/attribute is interpreted on current version checkpolicy(1.22).
> In other word, '@'<typename> is merely recognized as <typename>,
> any descendants are not included. '@'<attribute> is rolled out
> some child types attached this attribute directly, not include
> any indirect descendants.

Yes, that is what I would expect.

> e.g.
> attribute attr;
> type X;
> type Y extends attr;
> type Z extends Y;
> 
> "allow @attr foo:XXX XXX;" means "allow Y foo:XXX XXX;", Z is not included.

Ah, the fact that Y is included is interesting; this is due to the fact
that your implementation handles 'type Y extends attr;' in the same
manner as a 'type Y, attr;' declaration, right?   

> Effective use of existing software assets is reason.
> For example, samba_httpd_content_t is a type extends samba_share_t
> and httpd_sys_content_t.  When we try to use the union filetype
> "samba_httpd_content_t", we must fix the allow statements of "samba_share_t"
> and "httpd_sys_content_t" if an allow statement without '@' means
> no-expandable permission grant.

True, and you also have to track down all indirect references, e.g. uses
of "file_type" or "sysadmfile" in the policy.

> > Note that we have to
> > consider not only rules that directly specify the type but rules that
> > may indirectly include the type via attribute or set complement (~).
> > Requiring explicit marking of types to allow expansion of descendants
> > would presumably require more work by someone who wants to extend a
> > type, but would avoid unintentional expansion.
> 
> OK, I'll fix up the latest patch with your notion.
> Please wait for a while.

Sorry, does this mean that you are going to change your implementation
to require explicit marking of types to allow expansion of descendants
(i.e. no expansion by default, and "@type" means expand descendants), or
not?

-- 
Stephen Smalley <sds@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
