Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j2SE9dDo026602
	for <selinux@tycho.nsa.gov>; Mon, 28 Mar 2005 09:09:39 -0500 (EST)
Received: from mail.lemuria.org (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j2SE8o1g028482
	for <selinux@tycho.nsa.gov>; Mon, 28 Mar 2005 14:08:50 GMT
Date: Mon, 28 Mar 2005 16:09:36 +0200
From: Tom <tom@lemuria.org>
To: Ivan Gyurdiev <ivg2@cornell.edu>
Cc: "Fedora SELinux support list for users &amp;  developers." <fedora-selinux-list@redhat.com>,
   selinux@tycho.nsa.gov
Subject: Re: Desktop apps interoperability
Message-ID: <20050328160935.B28563@lemuria.org>
References: <1111985855.1514.70.camel@cobra.ivg2.net> <1111986213.1514.77.camel@cobra.ivg2.net> <1111987652.1514.97.camel@cobra.ivg2.net> <20050328132653.F27857@lemuria.org> <1112012129.1514.187.camel@cobra.ivg2.net> <20050328151126.B28232@lemuria.org> <1112017584.1514.239.camel@cobra.ivg2.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1112017584.1514.239.camel@cobra.ivg2.net>; from ivg2@cornell.edu on Mon, Mar 28, 2005 at 08:46:24AM -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, Mar 28, 2005 at 08:46:24AM -0500, Ivan Gyurdiev wrote:
> I was suggesting that content should be kept in a sub-folder of /home,
> not that it should be kept somewhere else. I'm sorry for the
> misunderstanding. I am suggesting that this folder(s) should be
> standartized somehow. I am saying that settings should be kept separate.

ah! What you want is /home/tom/.etc/ ?



> > Generic folders are the bane of anything even resembling security.
> > Being _specific_ is what SELinux is all about. That's what the ENHANCED
> > means, if you strip away all the bullshit bingo words. MAC and RBAC are
> > just the means used.
> 
> ... that's a valid point, but how do you suggest interoperability should
> be addressed? When I say "generic" I don't mean that it should be used
> for everything under the Sun. I mean something that makes sense.

I posted my vision below - an explicit transfer. True, you can still
trick the user, but it stops any automated exploits.


> > Downloads, especially, deserve to be treated differently, as they are
> > data from untrusted sources.
> 
> ... all the more reason to put them in their own folder location.

As I suggested. :)



> > > It would become the equivalent of a new /home where you
> > > keep your files. Are there any plans to restrict desktop apps ?
> > 
> > Define "restrict".
> 
> I mean make them run in their own domain with minimum priviledge
> required to operate, as opposed to running in user_t. I do not 
> mean that they should be unable to perform their intended operation.

Then yes, I do believe many programs should be restricted. Anything
with outside contact (web browser, mail reader, etc.) most definitely.


> Say I rip a bunch of songs with sound-juicer. Now I want to share them
> with gift (p2p app). I can't make that work out of the box without
> changing the context, because gift can't read user_t files. If the songs
> went into a common "content"-style folder, I could make that readable by
> gift, mplayer, and whatever needs it, and make them stay away from
> user_t.

I'm still opposed to a generic "content" directory. However, what about
a generic "share" directory with proper auto_trans rules? Anything I
explicitly move there is readable by anything that knows what read()
ist.



> I don't think so. The hoops are unnecessary, and the problem can be
> solved nicely to fit all people's needs. What you're telling me is that
> I shouldn't bother with SElinux anymore -  my main motivation for
> playing with this technology at all is that it's applicable to my home
> machine - not some ultrasecure server in a basement. I want something 
> usable that can improve security at the same time.

SELinux is incredible flexible. It can be configured totally insecure,
if you want. :)



> > The average person also doesn't want their home machine turned into a
> > spammer zombie. At the current growth rate, the average person will
> > soon be faced with a few hard choices. I mean, you can't seriously buy 
> > Windows XP anymore, because you'll be infected with at least one malware
> > before the download of SP2 is finished. The only option is OEM versions
> > that already have at least SP2 applied.
> 
> What's the point that you're trying to make?
> If you're implying that security is more important than usability, then
> I'm not convinced. 

I'm implying that jumping through hoops for security reasons is
becoming generally accepted. Most dummy users know that they need a
virus scanner. They have no idea what it is, except that it somehow
protects them from viruses. In fact, most dummy users I've talked to
don't know the difference between a firewall and a virus scanner.
However, they are quite willing to put up with whatever inconvenience
the virus scanner is putting on them, because the point that it's
necessary has been hammered home.

Why should Linux be any different?
"Ok, aunt Ellie, this is a Linux system. It doesn't need a virus
scanner like your windos system did, but [add whatever we finally agree
on as the user-friendly-and-still-safe method]"



> That's a tradeoff I'm inclined to accept - especially since mplayer can
> stream stuff off the net itself.

Not if you don't want. That's the beauty of SELinux - I don't care how
many kitchen sinks they've built into their software, on _my_ system it
does what I allow it to do and nothing else.


> > In the long term, an explicit transfer (a nice GUI tool would make it
> > almost painless for the user. In fact, on a drag-and-drop desktop you
> > could probably add it to the drag&drop process) seems to be the better
> > solution.
> 
> How exactly will that work - some details?

Aunt Ellie downloads a movie. It goes into the Download folder (or
really anywhere, it doesn't matter much). She drags the movie icon to
the movie player and lets it drop. Movie plays.

Behind the scenes, the file is relabeled or moved into another
directory where mplayer can access it.

Why is this more secure? Because it requires the intervention of a
"trusted 3rd party" (the desktop environment) so you can not force bad
data on my mplayer by compromising Firefox. You can not, for example,
create movie-player-popup ads.



-- 
http://web.lemuria.org/pubkey.html
pub  1024D/2D7A04F5 2002-05-16 Tom Vogt <tom@lemuria.org>
     Key fingerprint = C731 64D1 4BCF 4C20 48A4  29B2 BF01 9FA1 2D7A 04F5

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
