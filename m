Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j2SDBUDo026122
	for <selinux@tycho.nsa.gov>; Mon, 28 Mar 2005 08:11:30 -0500 (EST)
Received: from mail.lemuria.org (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j2SD82UJ020890
	for <selinux@tycho.nsa.gov>; Mon, 28 Mar 2005 13:08:03 GMT
Date: Mon, 28 Mar 2005 15:11:26 +0200
From: Tom <tom@lemuria.org>
To: Ivan Gyurdiev <ivg2@cornell.edu>
Cc: "Fedora SELinux support list for users &amp;  developers." <fedora-selinux-list@redhat.com>,
   selinux@tycho.nsa.gov
Subject: Re: Desktop apps interoperability
Message-ID: <20050328151126.B28232@lemuria.org>
References: <1111985855.1514.70.camel@cobra.ivg2.net> <1111986213.1514.77.camel@cobra.ivg2.net> <1111987652.1514.97.camel@cobra.ivg2.net> <20050328132653.F27857@lemuria.org> <1112012129.1514.187.camel@cobra.ivg2.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1112012129.1514.187.camel@cobra.ivg2.net>; from ivg2@cornell.edu on Mon, Mar 28, 2005 at 07:15:29AM -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> > It doesn't. It treats $HOME as the only place that the user has
> > permission to store his stuff. On a well-configured system, that
> > assumption is correct.
> 
> Ah, but that's not true. The user is actively encouraged to store stuff
> in $HOME, and not elsewhere, because:

Because there are many reasons for that. The most important ones
in my book are:

* other locations might be mounted read-only
* /home may be a remote (e.g. NFS) mount
* various standards define what /usr or /var are for, and storing
  user-specific data is not on that list
* security - seperation between system and user data

That last one is the one that we don't want to break, on a SECURITY
ENHANCED Linux system least of all.



All your reasons except for #1 are really just consequences of the fact
that /home is where Unix users store their stuff.


> 6) From a SELinux viewpoint, why does the user domain *need* access
> to /home's setting part at all? Those are files created w/out direct
> user interaction. They could be made accessible to individual
> application domains, without user_t selinux access. 

These are files that are totally created with user interaction. Just
because Joe Dummy doesn't vi his .muttrc doesn't mean that I don't.

It also saves us the headache of writing a policy for each and every
file that stores something in $HOME - which means pretty much
everything that has an options or settings dialog.



> Anyway, more to the point:
> 
> 7) I can't call file_type_auto_trans twice on the same folder.

That is why I suggested a new folder for that specific purpose. I only
need one file_type_auto_trans there, namely when I store the stuff.

If I recall correctly, I had written a mozilla policy with such a
change a year or so ago.



> A) In the future if all desktop apps are restricted, this folder will
> have to become something more generic that doesn't have anything to do
> with downloads. 

Are you insane?
Generic folders are the bane of anything even resembling security.
Being _specific_ is what SELinux is all about. That's what the ENHANCED
means, if you strip away all the bullshit bingo words. MAC and RBAC are
just the means used.

Downloads, especially, deserve to be treated differently, as they are
data from untrusted sources.



> It would become the equivalent of a new /home where you
> keep your files. Are there any plans to restrict desktop apps ?

Define "restrict".

"Do their intended operation" - no, I don't think there are any plans
to prevent that.

"Mess at will with anything else in $HOME" - why yes, absolutely. If my
movie player has any reasons reading my mail preferences, I really want
to know them.



> B) Whatever is decided upon needs to work out of the box. It needs to be
> the default way things work, as opposed to me having to jump through
> hoops to make SElinux work. Otherwise the average user will just disable
> any protection and not look back.

There will be hoops. Just like putting on the safety belt when getting
into your car is one.

I'm sure everyone involved in SELinux development wants to avoid
unnecessary hoops. But some will be necessary, just like a firewall,
two virus scanners and a yearly reinstall are necessary on today's
windos systems.



> This email was titled "Desktop apps interoperability". It implies that
> we're talking about the average desktop, as opposed to a paranoid
> environment. The average person does not know (or care) for evaluating
> security requirements and dealing with selinux. He/she wants
> transparency, but there's still value in using selinux.

The average person also doesn't want their home machine turned into a
spammer zombie. At the current growth rate, the average person will
soon be faced with a few hard choices. I mean, you can't seriously buy 
Windows XP anymore, because you'll be infected with at least one malware
before the download of SP2 is finished. The only option is OEM versions
that already have at least SP2 applied.



> If you choose to download the content in question, and choose to run
> mplayer on it, then it seems to me that it should work without messing
> with security contexts.

Ah, but maybe you don't want mplayer to access everything you
downloaded?

In the long term, an explicit transfer (a nice GUI tool would make it
almost painless for the user. In fact, on a drag-and-drop desktop you
could probably add it to the drag&drop process) seems to be the better
solution.




-- 
http://web.lemuria.org/pubkey.html
pub  1024D/2D7A04F5 2002-05-16 Tom Vogt <tom@lemuria.org>
     Key fingerprint = C731 64D1 4BCF 4C20 48A4  29B2 BF01 9FA1 2D7A 04F5

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
