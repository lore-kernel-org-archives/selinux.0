MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: Re: kernel flask headers
Date: Tue, 16 Oct 2007 11:24:50 -0400
Message-ID: <1192548290.32627.25.camel@gorn>
In-Reply-To: <1192547487.8702.90.camel@moss-spartans.epoch.ncsc.mil>
References: <1192547487.8702.90.camel@moss-spartans.epoch.ncsc.mil>
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: "Stephen Smalley" <sds@tycho.nsa.gov>
Cc: <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2007-10-16 at 11:11 -0400, Stephen Smalley wrote:
> On the refpolicy trunk, if you run make in refpolicy/policy/flask and
> try to use the resulting kernel headers, the kernel won't build.
> 
> Looks like flask.py is inserting S_(0, 0, 0) lines into av_inherit.h,
> which isn't valid in the kernel's definition of S_() there.  Should just
> omit the line altogether I would expect.

Odd, since the script hasn't changed since March, and I though we
verified it was putting out correct headers.

> Also, we don't presently seem to have a way of marking common
> definitions as userspace-only and omitting them from the kernel's
> headers, so it is adding the common database definitions
> (unnecessarily).

This should be interesting to fix, since they're not declared in
security_classes like regular classes are.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
