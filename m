Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i4IEQ7Rb001878
	for <selinux@tycho.nsa.gov>; Tue, 18 May 2004 10:26:07 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i4IENaB2018192
	for <selinux@tycho.nsa.gov>; Tue, 18 May 2004 14:23:37 GMT
Received: from mxlx1.surveysavvy.com (mxlx1.surveysavvy.com [63.108.92.46])
	by jazzswing.ncsc.mil  with SMTP id i4IENawi018189
	for <selinux@tycho.nsa.gov>; Tue, 18 May 2004 14:23:36 GMT
Message-ID: <2613.68.6.187.64.1084889973.squirrel@mxlx1.surveysavvy.com>
In-Reply-To: <200405190007.35107.russell@coker.com.au>
References: <OFC9F6DDFC.10588DF6-ONCA256E98.00360A82@lesbell.com.au>
    <200405190007.35107.russell@coker.com.au>
Date: Tue, 18 May 2004 07:19:33 -0700 (PDT)
Subject: Re: suggestion to help transition to selinux: dynamic loading of
     libselinux
From: "Chris Babcock" <cbabcock@luthresearch.com>
To: russell@coker.com.au
Cc: "Les Bell" <lesbell@lesbell.com.au>, selinux@tycho.nsa.gov
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> On Tue, 18 May 2004 19:50, "Les Bell" <lesbell@lesbell.com.au> wrote:
>> "Chris Babcock" <cbabcock@luthresearch.com> wrote:
>> > Does this sound dangerous to anybody else?
>
> If you can replace /lib/libselinux.so then you can surely compromise the
> entire system in many other ways.
>
>> Does the design of SELinux depend on the state machine theory of
>> security,
>> i.e. if a system starts in a secure state, and all transitions are
>> secure,
>> then the system will remain secure? This design would seem unable to
>> support that theory, i.e. until the selinux library is loaded, there are
>> no
>> constraints on the state of the machine. Just a thought. . .
>
> Until the policy is loaded there are no SE Linux constraints on the
> machine
> state.  However at that time only init is running so it shouldn't be a
> problem.
>

The danger involved with replacement of /lib/libselinux.so on an selinux
system is pretty obvious, however if the system is operating properly it
shouldn't be too much of an issue.

What I was thinking about was more along the lines of what happens on a
system where a vendor distributes selinux enabled utilities (using dlopen
as described) but doesn't install the library by default and leaves
selinux disabled in kernel.

In this case a bogus libselinux could be installed...  The vendor
utilities, core libraries (glib etc), and kernel wouldn't even have to be
modified, so they would still pass a signature check.

I was just thinking that this idea may be opening up an interesting attack
vector on some systems given the way some distros seem to be going.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
