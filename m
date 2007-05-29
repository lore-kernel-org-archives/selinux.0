Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l4TItFXl015629
	for <selinux@tycho.nsa.gov>; Tue, 29 May 2007 14:55:15 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id l4TIt8gZ020825
	for <selinux@tycho.nsa.gov>; Tue, 29 May 2007 18:55:08 GMT
Subject: Re: FW: redefining the numer of sensitivities and reconfiguring
	usersand login
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: "Clarkson, Mike R (US SSA)" <mike.clarkson@baesystems.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <FB39F4E77226B448BC1388D3BE4E00CD01DBEE8F@blums0008.bluelnk.net>
References: <FB39F4E77226B448BC1388D3BE4E00CD01DBEE8F@blums0008.bluelnk.net>
Content-Type: text/plain
Date: Tue, 29 May 2007 18:53:53 +0000
Message-Id: <1180464833.10995.111.camel@sgc>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2007-05-29 at 11:37 -0700, Clarkson, Mike R (US SSA) wrote:
> -----Original Message-----
> From: Stephen Smalley [mailto:sds@tycho.nsa.gov] 

> On Wed, 2007-05-23 at 17:29 -0700, Clarkson, Mike R (US SSA) wrote:
> > I'm trying to reduce the number of sensitivities from 16 to 5 (s0 -
> s4)
> 
> Suggest posting to selinux list, cc Chris PeBenito
> <cpebenito@tresys.com>
> 
> This is a general question for selinux policy.
> 
> I suspect you have to rebuild the policy package with your modified
> notion of SystemHigh to make it take effect throughout.

You would have to recompile the entire policy, since the declarations,
any contexts (e.g. file contexts), range transitions, and users that
refer to system high would have to be updated.  Conveniently, the number
of sensitivities and categories are build time options and all the above
is handled by the infrastructure.  You just have to set MLS_SENS and
MLS_CATS in build.conf and then rebuild it.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
