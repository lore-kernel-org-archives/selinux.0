Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i5IEDmrT017148
	for <selinux@tycho.nsa.gov>; Fri, 18 Jun 2004 10:13:48 -0400 (EDT)
Received: from epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i5IEDcpw025911
	for <selinux@tycho.nsa.gov>; Fri, 18 Jun 2004 14:13:38 GMT
Subject: Re: Fedora Core 2 setools RPM
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: "John D. Ramsdell" <ramsdell@mitre.org>
Cc: Karl MacMillan <kmacmillan@tresys.com>, selinux@tycho.nsa.gov
In-Reply-To: <ogtpt7x10ni.fsf@mitre.org>
References: <200406171847.i5HIlPSf000906@gotham.columbia.tresys.com>
	 <ogtpt7x10ni.fsf@mitre.org>
Content-Type: text/plain
Message-Id: <1087567982.27697.47.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Fri, 18 Jun 2004 10:13:03 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2004-06-18 at 09:00, John D. Ramsdell wrote:
> Great news.  I would greatly appreciate it if the libapol API includes
> access to CONSTRAIN statements in a policy file.  I strongly suspect
> the API could then be used to provide slat all the information it
> needs to analyze a policy.

I would think that this would be something you (John) could contribute
to libapol, as slat would be the first user of such information.

> I also noticed that it appears that none of the setools documentation
> tells users that your flow analysis ignores CONSTRAIN statements in a
> policy.  I think users should know this fact.

The apol information flow analysis is for flow among types; hence, it is
only natural for it to only consider the TE configuration.  As a flow
can only exist if allowed by the TE configuration, analysis of the TE
configuration is sufficient to identify all flows.  We've discussed that
issue previously.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
