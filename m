Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l41DVwwG028907
	for <selinux@tycho.nsa.gov>; Tue, 1 May 2007 09:31:58 -0400
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id l41DVv1O001390
	for <selinux@tycho.nsa.gov>; Tue, 1 May 2007 13:31:57 GMT
Subject: Re: Patch to cleanup audit handling in policy.
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Karl MacMillan <kmacmillan@mentalrootkit.com>
Cc: Steve G <linux_4ever@yahoo.com>, Daniel J Walsh <dwalsh@redhat.com>,
        SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <1177980591.13269.10.camel@localhost.localdomain>
References: <20070430145914.7790.qmail@web51502.mail.re2.yahoo.com>
	 <1177951993.3570.115.camel@sgc>
	 <1177980591.13269.10.camel@localhost.localdomain>
Content-Type: text/plain
Date: Tue, 01 May 2007 13:31:36 +0000
Message-Id: <1178026296.3570.144.camel@sgc>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2007-04-30 at 20:49 -0400, Karl MacMillan wrote:
> On Mon, 2007-04-30 at 16:53 +0000, Christopher J. PeBenito wrote:
> > On Mon, 2007-04-30 at 07:59 -0700, Steve G wrote:
> 
> <snip>
> 
> > 
> > > The interfaces that Dan created allows the exact kind of permission to be applied
> > > without having to copy and paste individual permissions which is error prone.
> > > (There are only 4 use cases of the audit system.) Part of what makes it error
> > > prone is the naming convention for all the pieces. Example: "audit_write" is that
> > > for the capability, the netlink interface, or audit logs?
> > 
> > This is the reason policy patterns exist.
> > 
> 
> So far the policy patterns have been very hard to automatically generate
> using sepolgen. Note that this deficiency is not something that I can
> address - it is a problem with the patterns themselves.

I don't see how it could be any more complex than matching rules to an
interface.

>  Given that and
> my concerns over their clarity I would prefer that no more patterns be
> introduced.
> 
> Can I ask why you are so against these audit interfaces and would prefer
> patterns?

I don't agree with the assertions which means the attributes are
dropped, so that just leaves the rules, which don't refer to any types
in the logging module.  They only refer to resources in the current
module (all self rules), so its not an interface, its a pattern.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
