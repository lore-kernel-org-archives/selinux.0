Subject: Re: dynamic context transitions
From: Karl MacMillan <kmacmillan@tresys.com>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: Darrel Goeddel <dgoeddel@TrustedCS.com>,
   SELinux List <SELinux@tycho.nsa.gov>, Chad Hanson <chanson@TrustedCS.com>,
   John Ramsdell <ramsdell@mitre.org>, Trent Jaeger <jaegert@us.ibm.com>
In-Reply-To: <1099328185.21386.140.camel@moss-spartans.epoch.ncsc.mil>
References: <4182959B.4080503@trustedcs.com>
	 <1099328185.21386.140.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Mon, 01 Nov 2004 16:44:02 -0500
Message-Id: <1099345442.23756.70.camel@pham.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2004-11-01 at 11:56 -0500, Stephen Smalley wrote:
> On Fri, 2004-10-29 at 15:10, Darrel Goeddel wrote:
> >       Since the ability to perform dynamic transitions is controlled by
> > separate permission from exec-based transitions (process setcurrent),
> > policy writers have the ability to not use the new feature.  The chain
> > of allowable dynamic  transitions is also controlled on a context-pair
> > basis.  This allows a "dynamic  transition group" to be treated as an
> > equivalence class for policy analysis.
> 
> Question for people writing policy analysis tools (some cc'd): What
> impact do you see such a change having on the ability to analyze
> policies?  How difficult would it be to have your tools collapse the
> domains in one of these "dynamic transition groups" into a single
> equivalence class for information flow analysis?
> 

It is certainly possible for apol to collapse domains for information
flow analysis. I would say that it is non-trivial but certainly doable.
This capability might even be useful in general so that a group of
domains can be considered as a single security domain. Collapsing the
domains means that the analysis results can't be used to make assurance
arguments about the application, of course, which seems to counter one
of the major arguments for doing this.

Karl

-- 
Karl MacMillan
Tresys Technology
kmacmillan@tresys.com
http://www.tresys.com


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
