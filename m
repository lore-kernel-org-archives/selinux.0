Subject: Re: SELinux References/Books
From: Stephen Smalley <sds@tycho.nsa.gov>
To: max <maximilianbianco@gmail.com>
Cc: selinux@tycho.nsa.gov, "Christopher J. PeBenito" <cpebenito@tresys.com>,
        Karl MacMillan <kmacmillan@tresys.com>,
        Frank Mayer <mayerf@tresys.com>, david caplan <dac@tresys.com>
In-Reply-To: <4850518E.8030508@gmail.com>
References: <48502D42.4030905@gmail.com>
	 <1213217350.17842.140.camel@moss-spartans.epoch.ncsc.mil>
	 <4850518E.8030508@gmail.com>
Content-Type: text/plain
Date: Thu, 12 Jun 2008 08:31:07 -0400
Message-Id: <1213273867.17842.179.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Wed, 2008-06-11 at 18:28 -0400, max wrote:
> Stephen Smalley wrote:
> > On Wed, 2008-06-11 at 15:53 -0400, max wrote:
> >> I would prefer to get a desktop reference rather than having to refer 
> >> to online documents or the hardcopies of individual papers I have 
> >> printed off, many of which are also dated. In any case I feel like I 
> >> have learned enough that I can open a book on the subject of SELinux and 
> >> not get completely lost. It looks like I have basically two options :
> >>
> >> SELinux by Example: Using Security Enhanced Linux (Prentice Hall Open 
> >> Source Software Development Series) by Frank Mayer, Karl MacMillan, and 
> >> David Caplan (Paperback - Aug 6, 2006)
> >>
> >> SELinux: NSA's Open Source Security Enhanced Linux by Bill McCarty 
> >> (Paperback - Oct 11, 2004) - Illustrated
> >>
> >> The first is more recent so I am leaning that way but I have seen 
> >> opinions that suggest even it is way out of date. I don't mind spending 
> >> money on a good book, reading is one of my favorite past times, but I 
> >> don't want anything so dated that it won't serve as a decent reference 
> >> for the near future (next year or so). I understand nothing is going to 
> >> be up to the minute.  Should I purchase one? or are they too out of date 
> >> to even serve as good references? This is definitely something I am 
> >> interested in learning about or I wouldn't bother to ask. Suggestions 
> >> and advice from all corners of reality welcome.
> > 
> > What kind of information are you looking for?
> >
> > The first, more recent, book includes discussion of reference policy and
> > policy modules and thus is relatively consistent with what you find in
> > modern SELinux, although newer developments like system-config-selinux,
> > setroubleshoot, etc naturally don't appear in it.  It was written during
> > the development of Fedora Core 5, which marked the transition of SELinux
> > from the old way (example policy, monolithic policy) to the new way
> > (reference policy, modular policy, semanage).
> > 
> 
> Well I'd like to learn it all but I think a practical approach would 
> mean learning to write policy first, since that is a skill I could put 
> to use now. I don't expect it will be easy but that's ok, I have some 
> time right now and I'd like to learn the policy language. If the first 
> book covers this then I will get it. Is there a better reference for 
> aspiring policy writers? I don't care about the gui tools so much, not 
> that they aren't useful but I prefer to do most things myself and not 
> automate it since this brings me less understanding.

Yes, the first book covers the policy language and provides an
introduction to writing a policy module, although specific interfaces
and patterns are always evolving in the reference policy.
oss.tresys.com/projects/refpolicy is a good resource for detailed
refpolicy documentation, and the interface documentation is also locally
installed on your system under /usr/share/doc/selinux-policy-x.y.z/html.

I don't know of a better reference at present, although it seems like we
are overdue for an updated edition of it, which could be significantly
simplified by dropping all discussion of Fedora Core 3 and 4 conventions
and focusing more specifically on how things are done now, although it
no doubt would retain some of the older information for RHEL 4 users.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
