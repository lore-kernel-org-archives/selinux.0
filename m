Subject: Re: [SEPOL] Const in APIs (part 1)
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Ivan Gyurdiev <ivg2@cornell.edu>
Cc: SELinux List <SELinux@tycho.nsa.gov>
In-Reply-To: <43BE76CF.6070804@cornell.edu>
References: <43BD635A.7040709@cornell.edu>
	 <1136559006.16811.26.camel@moss-spartans.epoch.ncsc.mil>
	 <43BE76CF.6070804@cornell.edu>
Content-Type: text/plain; charset=utf-8
Date: Fri, 06 Jan 2006 11:06:29 -0500
Message-Id: <1136563589.16811.63.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2006-01-06 at 08:55 -0500, Ivan Gyurdiev wrote:
> >> Makes a ton of things const for the purposes of enhanced error checking.
> >>
> >> I can't figure this out out:
> >> context.c: In function ‘sepol_check_context’:
> >> context.c:25: warning: passing argument 1 of ‘sepol_context_to_sid’ 
> >> discards qualifiers from pointer target type
> >>
> >> Something's confusing it - either the hidden proto, or the fact that the 
> >> typedef wraps the pointer - not sure why it won't go away.
> >>     
> >
> > I added an explicit type cast to silence it.
> >   
> ... but that's cheating! Why does it really occur?
> The whole point of the const types is to reveal bugs, which you are 
> hiding by casting..

No, I keep the const, but it is converting one const type (const char*)
to another (const sepol_security_context_t).  It is the typedef that is
confusing it.  Another option might be to define a variant of
sepol_security_context_t that is const char* and use it instead.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
