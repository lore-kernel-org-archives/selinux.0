Subject: Re: rbacsep: collapsing xserver
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Joe Nall <joe@nall.com>
Cc: SELinux Mail List <selinux@tycho.nsa.gov>,
        Eamon Walsh <ewalsh@tycho.nsa.gov>
In-Reply-To: <ddbc00640805281127ld1e848bs54c9f2dc53eaf8b8@mail.gmail.com>
References: <1211985533.5008.116.camel@gorn.columbia.tresys.com>
	 <ddbc00640805280816i24c06b68u65a7e4d7b68bf213@mail.gmail.com>
	 <1211990530.5008.127.camel@gorn.columbia.tresys.com>
	 <ddbc00640805280942n4ca2619h6185e89dc7d3c108@mail.gmail.com>
	 <1211998598.5008.138.camel@gorn.columbia.tresys.com>
	 <ddbc00640805281127ld1e848bs54c9f2dc53eaf8b8@mail.gmail.com>
Content-Type: text/plain
Date: Thu, 29 May 2008 09:04:22 -0400
Message-Id: <1212066262.5008.159.camel@gorn>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2008-05-28 at 13:27 -0500, Joe Nall wrote:
> On Wed, May 28, 2008 at 1:16 PM, Christopher J. PeBenito
> <cpebenito@tresys.com> wrote:
> > On Wed, 2008-05-28 at 11:42 -0500, Joe Nall wrote:
> >> What is the driver for the derived types? User preference files in
> >> their home directory?
> 
> I'm still trying to understand the need for the derived types. What
> does the xserver need to do that is constrained by user role?

Mainly it has to do with the associated files and domains, for the
xserver temp files, xauth, user specific fonts, etc.  If theres no
separation on the server itself, might be able to open up a window on
another role's xserver and send/receive info.  Obviously that would be
mitigated by an enforcing X server.

> >> Any opinions on spitting the display manager (gdm/xdm) policy out of
> >> the xserver policy? The current xserver policy is quite a bit bigger
> >> than apache and several times the average policy size (te + if).
> >
> > You can blame me for that.  The xdm policy used to be separate before
> > refpolicy, but it was so intertwined with the xserver policy that there
> > wasn't a sane way to write the policies separately and still keep the
> > refpolicy encapsulation.  If we collapse all xservers into xserver_t, it
> > may be possible to separate xdm again.  If not, xdm will be put into a
> > tunable when we get real tunable support in the compiler.
> 
> What drives the complexity/policy commingling? Or, what would have to
> change to allow the policies to be separated and simplified?

Mainly the special rules that xdm_xserver_t requires.

I was also thinking that I could put those extra rules in a tunable.  So
if I collapse all of the xserver types, then people on that don't want
the extra rules can just turn them off and then log in at the console
and use startx.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
