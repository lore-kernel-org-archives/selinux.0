Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m5CI0wIW020134
	for <selinux@tycho.nsa.gov>; Thu, 12 Jun 2008 14:00:58 -0400
Received: from an-out-0708.google.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m5CI0vgJ018257
	for <selinux@tycho.nsa.gov>; Thu, 12 Jun 2008 18:00:57 GMT
Received: by an-out-0708.google.com with SMTP id d30so901091and.75
        for <selinux@tycho.nsa.gov>; Thu, 12 Jun 2008 11:00:57 -0700 (PDT)
Message-ID: <a040ffdc0806121100v7732f155h881379386ad546da@mail.gmail.com>
Date: Thu, 12 Jun 2008 14:00:40 -0400
From: "max bianco" <maximilianbianco@gmail.com>
To: "Stephen Smalley" <sds@tycho.nsa.gov>
Subject: Re: SELinux References/Books
Cc: selinux@tycho.nsa.gov, "Christopher J. PeBenito" <cpebenito@tresys.com>,
        "Karl MacMillan" <kmacmillan@tresys.com>,
        "Frank Mayer" <mayerf@tresys.com>, "david caplan" <dac@tresys.com>,
        fedora-selinux-list@redhat.com
In-Reply-To: <1213273867.17842.179.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <48502D42.4030905@gmail.com>
	 <1213217350.17842.140.camel@moss-spartans.epoch.ncsc.mil>
	 <4850518E.8030508@gmail.com>
	 <1213273867.17842.179.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, Jun 12, 2008 at 8:31 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
>
> On Wed, 2008-06-11 at 18:28 -0400, max wrote:
>> Stephen Smalley wrote:
>> > On Wed, 2008-06-11 at 15:53 -0400, max wrote:
>> >> I would prefer to get a desktop reference rather than having to refer
>> >> to online documents or the hardcopies of individual papers I have
>> >> printed off, many of which are also dated. In any case I feel like I
>> >> have learned enough that I can open a book on the subject of SELinux and
>> >> not get completely lost. It looks like I have basically two options :
>> >>
>> >> SELinux by Example: Using Security Enhanced Linux (Prentice Hall Open
>> >> Source Software Development Series) by Frank Mayer, Karl MacMillan, and
>> >> David Caplan (Paperback - Aug 6, 2006)
>> >>
>> >> SELinux: NSA's Open Source Security Enhanced Linux by Bill McCarty
>> >> (Paperback - Oct 11, 2004) - Illustrated
>> >>
>> >> The first is more recent so I am leaning that way but I have seen
>> >> opinions that suggest even it is way out of date. I don't mind spending
>> >> money on a good book, reading is one of my favorite past times, but I
>> >> don't want anything so dated that it won't serve as a decent reference
>> >> for the near future (next year or so). I understand nothing is going to
>> >> be up to the minute.  Should I purchase one? or are they too out of date
>> >> to even serve as good references? This is definitely something I am
>> >> interested in learning about or I wouldn't bother to ask. Suggestions
>> >> and advice from all corners of reality welcome.
>> >
>> > What kind of information are you looking for?
>> >
>> > The first, more recent, book includes discussion of reference policy and
>> > policy modules and thus is relatively consistent with what you find in
>> > modern SELinux, although newer developments like system-config-selinux,
>> > setroubleshoot, etc naturally don't appear in it.  It was written during
>> > the development of Fedora Core 5, which marked the transition of SELinux
>> > from the old way (example policy, monolithic policy) to the new way
>> > (reference policy, modular policy, semanage).
>> >
>>
>> Well I'd like to learn it all but I think a practical approach would
>> mean learning to write policy first, since that is a skill I could put
>> to use now. I don't expect it will be easy but that's ok, I have some
>> time right now and I'd like to learn the policy language. If the first
>> book covers this then I will get it. Is there a better reference for
>> aspiring policy writers? I don't care about the gui tools so much, not
>> that they aren't useful but I prefer to do most things myself and not
>> automate it since this brings me less understanding.
>
> Yes, the first book covers the policy language and provides an
> introduction to writing a policy module, although specific interfaces
> and patterns are always evolving in the reference policy.
> oss.tresys.com/projects/refpolicy is a good resource for detailed
> refpolicy documentation, and the interface documentation is also locally
> installed on your system under /usr/share/doc/selinux-policy-x.y.z/html.
>
> I don't know of a better reference at present, although it seems like we
> are overdue for an updated edition of it, which could be significantly
> simplified by dropping all discussion of Fedora Core 3 and 4 conventions
> and focusing more specifically on how things are done now, although it
> no doubt would retain some of the older information for RHEL 4 users.
>
> --
> Stephen Smalley
> National Security Agency
>
>

Yes a more up to date reference would be nice but SELinux by Example
will do for starters. I went ahead and had the local bookstore order
it in so I could flip through it before I buy it but it seems
inevitable that I will make this purchase no matter what. One thing
that I notice a lot of people trying to do with computers in general
is memorize things. A bad idea I think, people want quick answers but
without an understanding of the underlying system it just creates more
confusion and ultimately leads to bigger blunders. Ego of course also
gets in the way, nobody wants to look stupid so often questions go
unasked, I am working on abandoning that notion as it seems to be one
of the biggest barriers to learning, though a modicum of judgment is
still required but I don't know if that can be taught you just have to
learn it over time. Getting to know the system is of course going to
require some real focus but I think in the long run it makes for a
better understanding, even if it means it takes twice (or more) as
long to get to my goal. One of the real barriers to understanding and
acceptance is good consistent documentation that people can turn too,
advancement shouldn't get frozen for the sake of publishing a book but
if the basics are solid and unlikely to change too much then I think
its time for an up to date reference. If you want a newcomers
perspective I personally would be happy to provide it but also don't
forget the mailing lists. I am sure I am not the only one trying to
learn this and looking for a good guide. Posting bits to the various
selinux related lists for feedback from  the experienced and
inexperienced users would certainly help as far as coverage and
readability are concerned. Another thing I can think of, though I
don't know how feasible it is, is the notion of a moderated thread. I
like my mailing lists unmoderated but say for instance you want to
post a how to or work on one. The thread would be restricted to one or
more persons posting to it until they are finished working out
whatever it is and then opened for comments. There may be many factors
here that I am unaware of or that simply aren't occurring to me right
now. I can't be the first person to have such an idea and it will of
course be pointed out that live journals work much the same but here
my point is the scope of the audience that you are reaching on a
mailing list vs. an individual blog of which there are hundred's of
thousands if not millions. Also it would help by adding more
transparency to the process. I am no expert on mailing lists or email
servers but I thought it might be worth floating the idea anyway. The
other thing I noticed, while at the bookstore, is that various/most of
the Linux magazines on the shelf right now have articles on security
in them and one, i forget which, has a piece on SELinux. It seems its
a hot topic everywhere I look. Cspan aired a rerun, from yesterday I
think, of a hearing on computer spyware. I think congressmen
Nelson(florida) and Pryor(?) were running the show. One of them maybe
a senator but anyway there is apparently some legislation on the
horizon. They had a couple of reps from various places there,
including a guy from Symantec. I didn't watch the whole thing but in
what I saw nobody mentioned the real problem. As far as I am concerned
the "real" problem is having the widespread use of an operating system
that makes things like drive by downloads so easy in the first place,
where most of the security rests with a program(anti virus) that
relies almost exclusively on updates but that is another debate and
probably not one worth having anyway. Unfortunately it will probably
take a major virus outbreak, on a scale we have yet to see, or a
massive, widespread, and very public breach of security to wake people
up. I will go ahead and shutdown here,  my real point is that it seems
people are starting to pay a lot more attention :^). Thanks for the
feedback.

Max


-- 
I am altering the deal. Pray I do not alter it any further. --Darth Vader

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
