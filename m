Subject: Re: How about future of MLS?
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Wu Yanjun <yanjunwu@sonata.iscas.ac.cn>
Cc: SELinux@tycho.nsa.gov
In-Reply-To: <200309080810.12991.yanjunwu@sonata.iscas.ac.cn>
References: <200309080810.12991.yanjunwu@sonata.iscas.ac.cn>
Content-Type: text/plain
Message-Id: <1063023949.8041.42.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 08 Sep 2003 08:25:50 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 2003-09-07 at 20:10, Wu Yanjun wrote:
> It seems MLS has been in experimental status for a long time.
> How about its future? Is it possible that SELinux will discard MLS component?

I would expect the MLS policy component to eventually be enhanced; the
fact that it hasn't been done yet is just a reflection of a lack of
anyone driving requirements for it, as most people seem satisfied with
the RBAC/TE model.  Do you have a particular need for MLS support?  Note
that TE can express MLS, so that is an alternative approach.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
