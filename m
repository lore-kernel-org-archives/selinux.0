Subject: Re: general security lib (was: 2.6.0-test3)
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: =?ISO-8859-1?Q?Magos=E1nyi_=C1rp=E1d?= <mag@bunuel.tii.matav.hu>
Cc: Colin Walters <walters@verbum.org>, SELinux <SELinux@tycho.nsa.gov>
In-Reply-To: <1061555921.1648.142.camel@kusturica>
References: <1061468940.1665.16.camel@kusturica>
	 <200308212337.59952.russell@coker.com.au>
	 <1061487623.22355.27.camel@columbia>  <1061555921.1648.142.camel@kusturica>
Content-Type: text/plain; charset=UTF-8
Message-Id: <1061559409.28086.105.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 22 Aug 2003 09:36:49 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2003-08-22 at 08:38, Magosányi Árpád wrote:
> The approach is described in
> http://reality.sgiweb.org/offer/papers/PACM/
> in the rationale paper.

By the way, I get a bit weary of people referring to this proposal as if
it predates SELinux or is more general than the SELinux API.  Neither is
true.  The PACM reports were written after SELinux had already been
released, along with the original SELinux API, documentation describing
that API, and extensive reports analyzing the generality of the
interface and framework for SELinux's predecessors (see the DTOS
reports, linked from the SELinux Background page).  Yet the PACM reports
do not appear to draw from the SELinux API or evaluate how the PACM API
compares with it, and the end result is that the PACM API cannot even
support the requirements of the SELinux API.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
