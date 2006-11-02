Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id kA2IvQ8n006256
	for <selinux@tycho.nsa.gov>; Thu, 2 Nov 2006 13:57:26 -0500
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id kA2ItiFI021775
	for <selinux@tycho.nsa.gov>; Thu, 2 Nov 2006 18:55:46 GMT
Subject: Re: MLS + MCS?
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Michael C Thompson <thompsmc@us.ibm.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <454A21B3.7040005@us.ibm.com>
References: <454A134D.5060902@us.ibm.com> <1162485313.18181.9.camel@sgc>
	 <454A21B3.7040005@us.ibm.com>
Content-Type: text/plain
Date: Thu, 02 Nov 2006 13:58:15 -0500
Message-Id: <1162493895.18181.31.camel@sgc>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2006-11-02 at 10:49 -0600, Michael C Thompson wrote:
> Christopher J. PeBenito wrote:
> > On Thu, 2006-11-02 at 09:48 -0600, Michael C Thompson wrote:
> >> While writing some policy, I came across a situation that was causing 
> >> the policy I was writing to be constructed in an invalid fashion. What 
> >> was happening was this:
> >>
> >> Using an old Makefile, my $(TYPE) was being generated as 
> >> 'strict-mls-mcs', which was causing the support template 'gen_context' 
> >> to get completely confused.
> >>
> >> The macro is defined thusly:
> > [cut]
> >> I'm wondering, how does this make sense? I'm unclear as to how having 
> >> both mls_sensitivity and [mcs_catergories] defined in this way has meaning.
> >>
> >> Because of having both '-mls' and '-mcs' in my $(TYPE), the invalid 
> >> policy I was compiling ended up looking like this:
> >> user:role:type:$2:s0:$3
> >>
> >> It would seem to me that MLS and MCS are mutually exclusive, at least in 
> >> this macro.
> > 
> > Yes, they are mutually exclusive.  Sounds like the Makefile that redhat
> > has is making a mistake on setting TYPE; it has to figure out more than
> > the upstream refpolicy Makefiles need to because of the
> > redhat /usr/share/selinux/*/devel setup.
> 
> I have since switched to the last Makefile redhat provides and that 
> resolves the problem I was having.
> 
> is there a better way to express the gen_context macro, or is this 
> another case of m4 limitations? (I am not familiar with m4 at all btw)

M4 doesn't really have any error handling since it is just a macro
language.  Since MLS and MCS are mutually exclusive, it hasn't been a
problem.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
