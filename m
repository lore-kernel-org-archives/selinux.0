Subject: general security lib (was: 2.6.0-test3)
From: =?ISO-8859-1?Q?Magos=E1nyi_=C1rp=E1d?= <mag@bunuel.tii.matav.hu>
To: Colin Walters <walters@verbum.org>
Cc: SELinux <SELinux@tycho.nsa.gov>
In-Reply-To: <1061487623.22355.27.camel@columbia>
References: <1061468940.1665.16.camel@kusturica>
	<200308212337.59952.russell@coker.com.au>
	<1061487623.22355.27.camel@columbia>
Content-Type: text/plain; charset=ISO-8859-2
Date: 22 Aug 2003 14:38:41 +0200
Message-Id: <1061555921.1648.142.camel@kusturica>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

2003-08-21, cs keltezéssel Colin Walters ezt írta:
> at all.  Russell, what do you think about starting to send these patches
> to the Debian package maintainers and get them integrated?  At least the

It might be the least unconvenient solution for the short run.

But for the long run it would be better if the upstream maintainers
would integrate support for the userspace security API. And they
won't necessarily like that they should use separate code for
selinux, rsbac, etc. It means that there should be a general
security lib. I now think that the current API of libselinux is
good, only the inside workings should be made more general, to
make it possible to plug other modules in.
The approach is described in
http://reality.sgiweb.org/offer/papers/PACM/
in the rationale paper.


-- 
GNU GPL: csak tiszta forrásból


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
