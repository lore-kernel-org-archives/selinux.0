Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iA1H07XZ027750
	for <selinux@tycho.nsa.gov>; Mon, 1 Nov 2004 12:00:07 -0500 (EST)
Received: from epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id iA1GwkCC013284
	for <selinux@tycho.nsa.gov>; Mon, 1 Nov 2004 16:58:46 GMT
Subject: Re: dynamic context transitions
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Darrel Goeddel <dgoeddel@TrustedCS.com>
Cc: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>,
   Chad Hanson <chanson@TrustedCS.com>, Karl MacMillan <kmacmillan@tresys.com>,
   John Ramsdell <ramsdell@mitre.org>, Trent Jaeger <jaegert@us.ibm.com>
In-Reply-To: <4182959B.4080503@trustedcs.com>
References: <4182959B.4080503@trustedcs.com>
Content-Type: text/plain
Message-Id: <1099328185.21386.140.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Mon, 01 Nov 2004 11:56:25 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2004-10-29 at 15:10, Darrel Goeddel wrote:
>       Since the ability to perform dynamic transitions is controlled by
> separate permission from exec-based transitions (process setcurrent),
> policy writers have the ability to not use the new feature.  The chain
> of allowable dynamic  transitions is also controlled on a context-pair
> basis.  This allows a "dynamic  transition group" to be treated as an
> equivalence class for policy analysis.

Question for people writing policy analysis tools (some cc'd): What
impact do you see such a change having on the ability to analyze
policies?  How difficult would it be to have your tools collapse the
domains in one of these "dynamic transition groups" into a single
equivalence class for information flow analysis?

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
