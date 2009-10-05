Received: from msux-gh1-uea01.nsa.gov (msux-gh1-uea01.nsa.gov [63.239.67.1])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n957EFGu008343
	for <selinux@tycho.nsa.gov>; Mon, 5 Oct 2009 03:14:16 -0400
Received: from atoll.udmvt.ru (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id n957DQSF025403
	for <selinux@tycho.nsa.gov>; Mon, 5 Oct 2009 07:13:27 GMT
Received: from ruber.office.udmvt.ru (ruber.office.udmvt.ru [192.168.21.33])
	by atoll.udmvt.ru (8.13.6/8.13.6/Izhcom-V1.1e) with SMTP id n957EAGB010409
	for <selinux@tycho.nsa.gov>; Mon, 5 Oct 2009 12:14:13 +0500 (SAMST)
	(envelope-from spg@udmvt.ru)
Date: Mon, 5 Oct 2009 12:14:10 +0500
From: selinux@udmvt.ru
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@udmvt.ru, selinux@tycho.nsa.gov
Subject: Re: How to trace why MCS permissions granted?
Message-ID: <20091005071410.GV4221@ruber.office.udmvt.ru>
References: <20091002154012.GT4221@ruber.office.udmvt.ru> <1254499643.30591.346.camel@moss-pluto.epoch.ncsc.mil> <1254503251.30591.357.camel@moss-pluto.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1254503251.30591.357.camel@moss-pluto.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, Oct 02, 2009 at 01:07:31PM -0400, Stephen Smalley wrote:
> On Fri, 2009-10-02 at 12:07 -0400, Stephen Smalley wrote:
> > On Fri, 2009-10-02 at 20:40 +0500, selinux@udmvt.ru wrote:
> > > Hello, everyone.
> > > I'm just playing with MCS and trying to understand the system's behavior.
> > > 
...
> > policy/mcs says:
> > mlsconstrain file { read }
> >         (( h1 dom h2 ) or ( t2 == domain ) or ( t1 == mlsfileread ));
> 
> So it is operating in accordance with the policy configuration.  As to
> whether the policy configuration makes sense is another question, I
> think.
Oh, thanks, I see now.

But is there any place, where I can read human definition
of reference policy? I suppose, there should be one, that describes
every requirement, that the policy should meet (or guarantee) to be "correct"
or "have sense".
So I (and everyone else) could know out whether there is a bug or a feature
of a policy.

> 
> I don't think MCS and MLS should be reusing each other's attributes in
> constraints, as not everything that requires an exception under the one
> will need an exception under the other.
> 
> -- 
> Stephen Smalley
> National Security Agency
BTW, someone abuses yor email to distribute win32 PEs.

> 
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
