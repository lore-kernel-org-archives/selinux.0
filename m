Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m4SIRZXI022769
	for <selinux@tycho.nsa.gov>; Wed, 28 May 2008 14:27:35 -0400
Received: from fk-out-0910.google.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m4SIRYOB000649
	for <selinux@tycho.nsa.gov>; Wed, 28 May 2008 18:27:35 GMT
Received: by fk-out-0910.google.com with SMTP id 18so2882667fks.2
        for <selinux@tycho.nsa.gov>; Wed, 28 May 2008 11:27:33 -0700 (PDT)
Message-ID: <ddbc00640805281127ld1e848bs54c9f2dc53eaf8b8@mail.gmail.com>
Date: Wed, 28 May 2008 13:27:33 -0500
From: "Joe Nall" <joe@nall.com>
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
Subject: Re: rbacsep: collapsing xserver
Cc: "SELinux Mail List" <selinux@tycho.nsa.gov>,
        "Eamon Walsh" <ewalsh@tycho.nsa.gov>
In-Reply-To: <1211998598.5008.138.camel@gorn.columbia.tresys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <1211985533.5008.116.camel@gorn.columbia.tresys.com>
	 <ddbc00640805280816i24c06b68u65a7e4d7b68bf213@mail.gmail.com>
	 <1211990530.5008.127.camel@gorn.columbia.tresys.com>
	 <ddbc00640805280942n4ca2619h6185e89dc7d3c108@mail.gmail.com>
	 <1211998598.5008.138.camel@gorn.columbia.tresys.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, May 28, 2008 at 1:16 PM, Christopher J. PeBenito
<cpebenito@tresys.com> wrote:
> On Wed, 2008-05-28 at 11:42 -0500, Joe Nall wrote:
>> What is the driver for the derived types? User preference files in
>> their home directory?

I'm still trying to understand the need for the derived types. What
does the xserver need to do that is constrained by user role?

>> Any opinions on spitting the display manager (gdm/xdm) policy out of
>> the xserver policy? The current xserver policy is quite a bit bigger
>> than apache and several times the average policy size (te + if).
>
> You can blame me for that.  The xdm policy used to be separate before
> refpolicy, but it was so intertwined with the xserver policy that there
> wasn't a sane way to write the policies separately and still keep the
> refpolicy encapsulation.  If we collapse all xservers into xserver_t, it
> may be possible to separate xdm again.  If not, xdm will be put into a
> tunable when we get real tunable support in the compiler.

What drives the complexity/policy commingling? Or, what would have to
change to allow the policies to be separated and simplified?

joe

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
