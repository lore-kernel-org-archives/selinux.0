Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j2SDfZDo026313
	for <selinux@tycho.nsa.gov>; Mon, 28 Mar 2005 08:41:35 -0500 (EST)
Received: from postoffice9.mail.cornell.edu (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j2SDel1g026094
	for <selinux@tycho.nsa.gov>; Mon, 28 Mar 2005 13:40:47 GMT
Subject: Re: Desktop apps interoperability
From: Ivan Gyurdiev <ivg2@cornell.edu>
Reply-To: ivg2@cornell.edu
To: Tom <tom@lemuria.org>
Cc: "Fedora SELinux support list for users &amp;  developers." <fedora-selinux-list@redhat.com>,
   selinux@tycho.nsa.gov
In-Reply-To: <20050328151126.B28232@lemuria.org>
References: <1111985855.1514.70.camel@cobra.ivg2.net>
	 <1111986213.1514.77.camel@cobra.ivg2.net>
	 <1111987652.1514.97.camel@cobra.ivg2.net>
	 <20050328132653.F27857@lemuria.org>
	 <1112012129.1514.187.camel@cobra.ivg2.net>
	 <20050328151126.B28232@lemuria.org>
Content-Type: text/plain
Date: Mon, 28 Mar 2005 08:46:24 -0500
Message-Id: <1112017584.1514.239.camel@cobra.ivg2.net>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2005-03-28 at 15:11 +0200, Tom wrote:
> > > It doesn't. It treats $HOME as the only place that the user has
> > > permission to store his stuff. On a well-configured system, that
> > > assumption is correct.
> > 
> > Ah, but that's not true. The user is actively encouraged to store stuff
> > in $HOME, and not elsewhere, because:
> 
> Because there are many reasons for that. The most important ones
> in my book are:
> 
> * other locations might be mounted read-only
> * /home may be a remote (e.g. NFS) mount
> * various standards define what /usr or /var are for, and storing
>   user-specific data is not on that list
> * security - seperation between system and user data

I was suggesting that content should be kept in a sub-folder of /home,
not that it should be kept somewhere else. I'm sorry for the
misunderstanding. I am suggesting that this folder(s) should be
standartized somehow. I am saying that settings should be kept separate.

> > 6) From a SELinux viewpoint, why does the user domain *need* access
> > to /home's setting part at all? Those are files created w/out direct
> > user interaction. They could be made accessible to individual
> > application domains, without user_t selinux access. 
> 
> These are files that are totally created with user interaction. Just
> because Joe Dummy doesn't vi his .muttrc doesn't mean that I don't.

That's a valid point - and the way home_domain macro currently works 
is that it allows the user to access the data. Anyway, I still think
there's advantages to keeping settings separate from "content".


> > Anyway, more to the point:
> > 
> > 7) I can't call file_type_auto_trans twice on the same folder.
> 
> That is why I suggested a new folder for that specific purpose. I only
> need one file_type_auto_trans there, namely when I store the stuff.
> 
> If I recall correctly, I had written a mozilla policy with such a
> change a year or so ago.

So let's add this folder to /skel with the appropriate context
(*different* from the current ROLE_mozilla_home_t), and make it the
default for mozilla. See what I write elsewhere first tho.

> > A) In the future if all desktop apps are restricted, this folder will
> > have to become something more generic that doesn't have anything to do
> > with downloads. 
> 
> Are you insane?
> Generic folders are the bane of anything even resembling security.
> Being _specific_ is what SELinux is all about. That's what the ENHANCED
> means, if you strip away all the bullshit bingo words. MAC and RBAC are
> just the means used.

... that's a valid point, but how do you suggest interoperability should
be addressed? When I say "generic" I don't mean that it should be used
for everything under the Sun. I mean something that makes sense.
Right now most of the system uses user_home_t anyway - that seems pretty
generic to me.

> Downloads, especially, deserve to be treated differently, as they are
> data from untrusted sources.

... all the more reason to put them in their own folder location.

> > It would become the equivalent of a new /home where you
> > keep your files. Are there any plans to restrict desktop apps ?
> 
> Define "restrict".

I mean make them run in their own domain with minimum priviledge
required to operate, as opposed to running in user_t. I do not 
mean that they should be unable to perform their intended operation.

> "Mess at will with anything else in $HOME" - why yes, absolutely. If my
> movie player has any reasons reading my mail preferences, I really want
> to know them.

Well, as of right now your movie player has the ability to read
user_home_t, as a possible source of movies to play. I can't remember
whether it was mplayer or xine that had the capability to act as a movie
server, but I know one of them did. Now they can transmit .bashrc, and
who knows what over the net. 

Say I rip a bunch of songs with sound-juicer. Now I want to share them
with gift (p2p app). I can't make that work out of the box without
changing the context, because gift can't read user_t files. If the songs
went into a common "content"-style folder, I could make that readable by
gift, mplayer, and whatever needs it, and make them stay away from
user_t.

> 
> > B) Whatever is decided upon needs to work out of the box. It needs to be
> > the default way things work, as opposed to me having to jump through
> > hoops to make SElinux work. Otherwise the average user will just disable
> > any protection and not look back.
> 
> There will be hoops. Just like putting on the safety belt when getting
> into your car is one.
> 
> I'm sure everyone involved in SELinux development wants to avoid
> unnecessary hoops. But some will be necessary, just like a firewall,
> two virus scanners and a yearly reinstall are necessary on today's
> windos systems.

I don't think so. The hoops are unnecessary, and the problem can be
solved nicely to fit all people's needs. What you're telling me is that
I shouldn't bother with SElinux anymore -  my main motivation for
playing with this technology at all is that it's applicable to my home
machine - not some ultrasecure server in a basement. I want something 
usable that can improve security at the same time.


> > This email was titled "Desktop apps interoperability". It implies that
> > we're talking about the average desktop, as opposed to a paranoid
> > environment. The average person does not know (or care) for evaluating
> > security requirements and dealing with selinux. He/she wants
> > transparency, but there's still value in using selinux.
> 
> The average person also doesn't want their home machine turned into a
> spammer zombie. At the current growth rate, the average person will
> soon be faced with a few hard choices. I mean, you can't seriously buy 
> Windows XP anymore, because you'll be infected with at least one malware
> before the download of SP2 is finished. The only option is OEM versions
> that already have at least SP2 applied.

What's the point that you're trying to make?
If you're implying that security is more important than usability, then
I'm not convinced. 

> > If you choose to download the content in question, and choose to run
> > mplayer on it, then it seems to me that it should work without messing
> > with security contexts.
> 
> Ah, but maybe you don't want mplayer to access everything you
> downloaded?
 
That's a tradeoff I'm inclined to accept - especially since mplayer can
stream stuff off the net itself.

> In the long term, an explicit transfer (a nice GUI tool would make it
> almost painless for the user. In fact, on a drag-and-drop desktop you
> could probably add it to the drag&drop process) seems to be the better
> solution.

How exactly will that work - some details?

-- 
Ivan Gyurdiev <ivg2@cornell.edu>
Cornell University


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
