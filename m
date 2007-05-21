Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l4LIw6Sf014711
	for <selinux@tycho.nsa.gov>; Mon, 21 May 2007 14:58:06 -0400
Received: from mail1.sea5.speakeasy.net (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l4LIw49R011198
	for <selinux@tycho.nsa.gov>; Mon, 21 May 2007 18:58:05 GMT
Date: Mon, 21 May 2007 14:58:02 -0400 (EDT)
From: James Morris <jmorris@namei.org>
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
cc: sds@tycho.nsa.gov, jmorris@redhat.com, eparis@redhat.com,
        selinux@tycho.nsa.gov
Subject: Re: [PATCH 4/4] selinux: add selinuxfs structure for object class
 discovery
In-Reply-To: <1179772903.10995.13.camel@sgc>
Message-ID: <Line.LNX.4.64.0705211456230.17765@d.namei>
References: <11797619161088-git-send-email-cpebenito@tresys.com>
 <11797619172804-git-send-email-cpebenito@tresys.com>
 <1179761918482-git-send-email-cpebenito@tresys.com>
 <1179761920707-git-send-email-cpebenito@tresys.com>
 <11797619233926-git-send-email-cpebenito@tresys.com>
 <Line.LNX.4.64.0705211306480.17008@d.namei> <1179772903.10995.13.camel@sgc>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 21 May 2007, Christopher J. PeBenito wrote:

> Well its 32 because the access vector is a u32, so an object class can
> only have 32 perms max, which is why I had the following macro.  Perhaps
> the macro should be moved to security.h, next to the struct av_decision
> definition?

Yes, and keep in mind that we may move to u64 sometime.

> > > +#define NVECTORS 32
> > 
> > Macro name is too generic.
> 
> Maybe something like SEL_AV_MAX or SEL_PERM_MAX?

SEL_VEC_MAX ?

> > > +#define DIV(a, b) ((a) / (b) - ((a) % (b) < 0))
> > 
> > Also too generic, and should be a static inline.
> 
> Ok.  I noticed it other places in the kernel, which is why I used it.
> What should it be called?  sel_div()?

Yep, should be fine.

KJ folk may be interested in finding all of these and using a common 
inline instead.


- James
-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
