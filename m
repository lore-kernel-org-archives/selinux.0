Subject: Re: general security lib (was: 2.6.0-test3)
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: =?ISO-8859-1?Q?Magos=E1nyi_=C1rp=E1d?= <mag@bunuel.tii.matav.hu>
Cc: Colin Walters <walters@verbum.org>, SELinux <SELinux@tycho.nsa.gov>
In-Reply-To: <1061555921.1648.142.camel@kusturica>
References: <1061468940.1665.16.camel@kusturica>
	 <200308212337.59952.russell@coker.com.au>
	 <1061487623.22355.27.camel@columbia>  <1061555921.1648.142.camel@kusturica>
Content-Type: text/plain; charset=UTF-8
Message-Id: <1061557106.28086.65.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 22 Aug 2003 08:58:26 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2003-08-22 at 08:38, Magosányi Árpád wrote:
> But for the long run it would be better if the upstream maintainers
> would integrate support for the userspace security API. And they
> won't necessarily like that they should use separate code for
> selinux, rsbac, etc. It means that there should be a general
> security lib. I now think that the current API of libselinux is
> good, only the inside workings should be made more general, to
> make it possible to plug other modules in.
> The approach is described in
> http://reality.sgiweb.org/offer/papers/PACM/
> in the rationale paper.

RSBAC isn't a good motivating example, as it doesn't include patches for
userspace, and its author seemed specifically inclined against patching
userspace for RSBAC.

I don't quite follow your argument; if you agree that the SELinux API is
good and that we just need to modularize the libselinux implementation,
then what is your objection to the coreutils patch, which simply invokes
the API?  

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
