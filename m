Subject: Re: Multiple small fixes to policycoreutils
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SE Linux <selinux@tycho.nsa.gov>, Stephen Smalley <sds@tycho.nsa.gov>
In-Reply-To: <4559EC69.90407@redhat.com>
References: <4559DB81.7060601@redhat.com>
	 <1163520813.18181.131.camel@sgc.columbia.tresys.com>
	 <4559EC69.90407@redhat.com>
Content-Type: text/plain
Date: Tue, 14 Nov 2006 14:19:05 -0500
Message-Id: <1163531945.7374.11.camel@sgc.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2006-11-14 at 11:18 -0500, Daniel J Walsh wrote:
> Christopher J. PeBenito wrote:
> > On Tue, 2006-11-14 at 10:06 -0500, Daniel J Walsh wrote:
> >   
> >> Add -fPIE and -pie to build of restorecond.
> >>     
> >
> >   
> >> -CFLAGS ?= -g -Werror -Wall -W
> >> -override CFLAGS += -I$(PREFIX)/include -D_FILE_OFFSET_BITS=64
> >> +LDFLAGS ?= -pie
> >> +CFLAGS ?= -g -Werror -Wall -W 
> >> +override CFLAGS += -I$(PREFIX)/include -D_FILE_OFFSET_BITS=64 -fPIE
> >>     
> >
> > I would say that this shouldn't be added in general, especially not to
> > the override.  The default flags should be pretty basic, IMO.
> >
> >   
> How about if we change
> LDFLAGS ?= ?= $(RANDLDFLAG)
> override CFLAGS += -I$(PREFIX)/include -D_FILE_OFFSET_BITS=64 $(RANDCFLAG)

Why does this need to be special?  "?=" means if the variable isn't
already set (setting CFLAGS to "" counts as set), then its set with the
right side.  This assignment won't happen if CFLAGS is set:

CFLAGS ?= -g -Werror -Wall -W

So in your spec file you just change your make command to `make
CFLAGS="-fPIE" LDFLAGS="-pie"`, then you'll get the behavior of the
patch above.  Keeping the makefile as is will keep the defaults safe,
and then distros can set things whichever way they want with CFLAGS and
LDFLAGS and not have extra compile/linking flags pop up.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
