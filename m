Message-ID: <483DA6AF.1070807@redhat.com>
Date: Wed, 28 May 2008 14:38:39 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Joe Nall <joe@nall.com>
CC: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        SELinux Mail List <selinux@tycho.nsa.gov>,
        Eamon Walsh <ewalsh@tycho.nsa.gov>
Subject: Re: rbacsep: collapsing xserver
References: <1211985533.5008.116.camel@gorn.columbia.tresys.com>	 <ddbc00640805280816i24c06b68u65a7e4d7b68bf213@mail.gmail.com>	 <1211990530.5008.127.camel@gorn.columbia.tresys.com>	 <ddbc00640805280942n4ca2619h6185e89dc7d3c108@mail.gmail.com>	 <1211998598.5008.138.camel@gorn.columbia.tresys.com> <ddbc00640805281127ld1e848bs54c9f2dc53eaf8b8@mail.gmail.com>
In-Reply-To: <ddbc00640805281127ld1e848bs54c9f2dc53eaf8b8@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Joe Nall wrote:
> On Wed, May 28, 2008 at 1:16 PM, Christopher J. PeBenito
> <cpebenito@tresys.com> wrote:
>> On Wed, 2008-05-28 at 11:42 -0500, Joe Nall wrote:
>>> What is the driver for the derived types? User preference files in
>>> their home directory?
> 
> I'm still trying to understand the need for the derived types. What
> does the xserver need to do that is constrained by user role?
> 
>>> Any opinions on spitting the display manager (gdm/xdm) policy out of
>>> the xserver policy? The current xserver policy is quite a bit bigger
>>> than apache and several times the average policy size (te + if).
>> You can blame me for that.  The xdm policy used to be separate before
>> refpolicy, but it was so intertwined with the xserver policy that there
>> wasn't a sane way to write the policies separately and still keep the
>> refpolicy encapsulation.  If we collapse all xservers into xserver_t, it
>> may be possible to separate xdm again.  If not, xdm will be put into a
>> tunable when we get real tunable support in the compiler.
> 
> What drives the complexity/policy commingling? Or, what would have to
> change to allow the policies to be separated and simplified?
> 
> joe
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
I say collapse it and do not allow staff_t or user_t to execute startx.
 This is what fedora does.  Allowing a confined domain to start
something as complex as X windows is just a big headache.  And would
probably allow lots of escalations and lots of bugs.

xdm (gdm.kdm) is starting to run lots of software before user login, so
we need to do a better job of isolating this from the xserver.

The current XAce software is far to complex to do anything usefull in my
opinion.  We have way too many types and transitions.  We need to
simplify down to a lot less types.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
