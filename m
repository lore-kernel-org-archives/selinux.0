Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m4UF1Kk9012396
	for <selinux@tycho.nsa.gov>; Fri, 30 May 2008 11:01:20 -0400
Received: from fk-out-0910.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m4UF1JU1006334
	for <selinux@tycho.nsa.gov>; Fri, 30 May 2008 15:01:19 GMT
Received: by fk-out-0910.google.com with SMTP id 18so235135fks.2
        for <selinux@tycho.nsa.gov>; Fri, 30 May 2008 08:01:01 -0700 (PDT)
Message-ID: <ddbc00640805300801y65fb769u510cea3b1fe3c815@mail.gmail.com>
Date: Fri, 30 May 2008 10:01:00 -0500
From: "Joe Nall" <joe@nall.com>
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
Subject: Re: rbacsep: collapsing xserver
Cc: "Xavier Toth" <txtoth@gmail.com>, "Daniel J Walsh" <dwalsh@redhat.com>,
        "SELinux Mail List" <selinux@tycho.nsa.gov>,
        "Eamon Walsh" <ewalsh@tycho.nsa.gov>
In-Reply-To: <1212155223.31546.42.camel@gorn>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <1211985533.5008.116.camel@gorn.columbia.tresys.com>
	 <ddbc00640805280816i24c06b68u65a7e4d7b68bf213@mail.gmail.com>
	 <1211990530.5008.127.camel@gorn.columbia.tresys.com>
	 <ddbc00640805280942n4ca2619h6185e89dc7d3c108@mail.gmail.com>
	 <1211998598.5008.138.camel@gorn.columbia.tresys.com>
	 <ddbc00640805281127ld1e848bs54c9f2dc53eaf8b8@mail.gmail.com>
	 <483DA6AF.1070807@redhat.com>
	 <cadfc0e40805300619l5feb8dddj7efb9f9797e3e9c3@mail.gmail.com>
	 <1212155223.31546.42.camel@gorn>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, May 30, 2008 at 8:47 AM, Christopher J. PeBenito
<cpebenito@tresys.com> wrote:
> On Fri, 2008-05-30 at 08:19 -0500, Xavier Toth wrote:
>> On Wed, May 28, 2008 at 1:38 PM, Daniel J Walsh <dwalsh@redhat.com> wrote:
>> > The current XAce software is far to complex to do anything usefull in my
>> > opinion.  We have way too many types and transitions.  We need to
>> > simplify down to a lot less types.
>>
>> Going back to Dan's concern about the complexity of the X SELinux
>> extension and the number of types and transitions I'd like to see some
>> discussion/resolution. Eamon what's your position on this topic?
>
> I don't want to speak for Eamon, but I suspect that he would defend the
> current setup since he's the one that wrote the policy.  I just
> restructured it to fit nicer in refpolicy and actually removed a few
> types :)
>
> My position is that its fine as is.  Simplifying it unconditionally
> starts to make it less usable for people that actually want fine grained
> controls on the desktop.  Making things simpler tends to be easy, since
> it tends to be merging types or using attributes for blanket access,
> like unconfined does.  The black magic voodoo that happens in the
> xserver, that only a select few have previously known about, has only
> recently been exposed via the SELinux controls.  I feel that it may be
> premature to simplify the policy, since side effects probably aren't
> well understood yet.  At least they aren't understood well by me yet.

I can relate to that :)

Voodoo note: Any post-login setuid magic will have to allow the
xserver object manager to continue to audit.

I chimed in on this thread because we need to get MLS X up and running
locally in enforcing mode. I wanted to make sure that we (Ted and I)
understood the issues involved as much as possible before changing any
policy.

joe

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
