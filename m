MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: Multiple small fixes to policycoreutils
Date: Thu, 16 Nov 2006 19:50:42 -0500
Message-ID: <6FE441CD9F0C0C479F2D88F959B015885C7A9D@exchange.columbia.tresys.com>
In-Reply-To: <455CE2F3.3070200@mentalrootkit.com>
From: "Joshua Brindle" <jbrindle@tresys.com>
To: "Karl MacMillan" <kmacmillan@mentalrootkit.com>
Cc: "Daniel J Walsh" <dwalsh@redhat.com>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>,
        "SE Linux" <selinux@tycho.nsa.gov>,
        "Stephen Smalley" <sds@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> From: Karl MacMillan [mailto:kmacmillan@mentalrootkit.com] 
> 
> Joshua Brindle wrote:
> >> From: Karl MacMillan [mailto:kmacmillan@mentalrootkit.com]
> >>
> >> Daniel J Walsh wrote:
> >>> Joshua Brindle wrote:
> >>>> Karl MacMillan wrote:
> >> <snip>
> >>
> >>>>> What about a top-level USE_PIE makefile variable that 
> directs all 
> >>>>> sub-Makefiles to set PIE flags if appropriate for that 
> module? By 
> >>>>> default it would be off. This gets the behavior you 
> want without 
> >>>>> having to carry a patch and keeps the current behavior.
> >>>>>
> >>>> No patch necessary, like Chris said make CFLAGS="-fPIE 
> -02 -Werror 
> >>>> -Wall" LDFLAGS="-pie"
> >>>>
> >>>> done and done.
> >>>>
> >>> No, because then all compiled apps become -pie.  We only
> >> want this on
> >>> the daemons.
> >>>
> >> What about this instead?
> > 
> > Why doesn't make CFLAGS="-fPIE -02 -Werror -Wall" 
> LDFLAGS="-pie" work? 
> > Why does it matter if everything is built pie?
> > 
> 
> There are performance costs associated with pie, particularly 
> at startup. Talking to Dan though, he doesn't think it is 
> enough to not just build everything as pie.
> 

Yea, I don't think startup costs on checkpolicy, semodule, setfiles and
so on are a big deal, not worth adding extra distro dependant logic into
the make system. The actual issue though is that prelinking doesn't do
anything on pie binaries, which is no big deal here, prelinking won't do
much anyway.

> Resend below that I will apply unless there are other objections.
> 

It's the same patch sans the make stuff right? Looks fine to me

> > This is distro specific (gentoo completely overrides the CFLAGS and 
> > LDFLAGS, I'm not sure what debian does). I don't think 
> whether or not 
> > to override the user CFLAGS with non-critical things (e.g., things 
> > necessary to build the app like -I($PREFIX)/include) is appropriate 
> > for the upstream makefiles.
> > 
> > For that matter, anyone know why -D_FILE_OFFSET_BITS=64 is in the 
> > override?
> > 
> 
> I wondered that as well - Dan?
> 



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
