MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: Re: [RFC][PATCH] user_transition support for libsepol/checkpolicy
Date: Tue, 25 Mar 2008 09:01:09 -0400
Message-ID: <1206450069.16113.208.camel@gorn.columbia.tresys.com>
In-Reply-To: <1206446939.3302.139.camel@moss-spartans.epoch.ncsc.mil>
References: <47E7E7A5.6090603@manicmethod.com> <1206389718.3302.107.camel@moss-spartans.epoch.ncsc.mil> <47E80EBE.4090508@manicmethod.com> <1206390986.3302.113.camel@moss-spartans.epoch.ncsc.mil> <47E8DC2B.6010205@manicmethod.com> <1206446939.3302.139.camel@moss-spartans.epoch.ncsc.mil>
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: "Stephen Smalley" <sds@tycho.nsa.gov>
Cc: "Joshua Brindle" <method@manicmethod.com>,
        "SE Linux" <selinux@tycho.nsa.gov>, "Caleb Case" <ccase@tresys.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2008-03-25 at 08:08 -0400, Stephen Smalley wrote:
> On Tue, 2008-03-25 at 07:04 -0400, Joshua Brindle wrote:
> > Stephen Smalley wrote:
> > > On Mon, 2008-03-24 at 16:27 -0400, Joshua Brindle wrote:

> > >> Ah, another thing. While going through the policyrep implementation the 
> > >> question of object_r came up. My thought is to start adding object_r 
> > >> magic into the toolchain (adding all types, etc) and eventually purge 
> > >> object_r from the kernel. at least one magic instance of object_r will 
> > >> be removed by object role_transitions, the others are really short 
> > >> circuits in the security server that can be removed after sufficient 
> > >> support is in the toolchain. What are your thoughts on that (for future 
> > >> reference)?
> > >>     
> > >
> > > Well, the interesting question is what should the default role be in the
> > > new context in security_compute_sid, if not object_r.  Even aside from
> > > the support for per-class role transitions.  User defaults to the source
> > > context, type defaults to the related object context, and MLS range
> > > defaults to the low level of the source context.  Role could be the
> > > subject's role or the related object's role.
> > >
> > >   
> > 
> > Good question. My original assumption was that we'd use the related 
> > object role. That would require that home directories be correctly 
> > labeled with the role of the user. If we start using the source role 
> > then things will quickly change from object_r to system_r, so maybe the 
> > policy should do that anyway. Chris, any opinions on this?
> 
> Yes, related object role would likely cause the least breakage.  It
> would preserve the existing default for existing filesystems (as they
> already have object_r in the directory contexts), while allowing us to
> switch over to the user's role for home directories upon a relabel or
> new filesystem.  Source role might create more conflicts, as we enforce
> the role/type relationship for contexts and there might be a mismatch
> between the creating process role and the parent directory type.

Using the related object role seems right to me too.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
