Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j2SCAfDo025821
	for <selinux@tycho.nsa.gov>; Mon, 28 Mar 2005 07:10:41 -0500 (EST)
Received: from postoffice9.mail.cornell.edu (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j2SC9r1g020642
	for <selinux@tycho.nsa.gov>; Mon, 28 Mar 2005 12:09:53 GMT
Subject: Re: Desktop apps interoperability
From: Ivan Gyurdiev <ivg2@cornell.edu>
Reply-To: ivg2@cornell.edu
To: Tom <tom@lemuria.org>
Cc: "Fedora SELinux support list for users &amp;  developers." <fedora-selinux-list@redhat.com>,
   selinux@tycho.nsa.gov
In-Reply-To: <20050328132653.F27857@lemuria.org>
References: <1111985855.1514.70.camel@cobra.ivg2.net>
	 <1111986213.1514.77.camel@cobra.ivg2.net>
	 <1111987652.1514.97.camel@cobra.ivg2.net>
	 <20050328132653.F27857@lemuria.org>
Content-Type: text/plain
Date: Mon, 28 Mar 2005 07:15:29 -0500
Message-Id: <1112012129.1514.187.camel@cobra.ivg2.net>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2005-03-28 at 13:26 +0200, Tom wrote:
> On Mon, Mar 28, 2005 at 12:27:31AM -0500, Ivan Gyurdiev wrote:
> > Part of the problem seems to be the way Linux apps treat /home, as the
> > place for everything. 
> 
> It doesn't. It treats $HOME as the only place that the user has
> permission to store his stuff. On a well-configured system, that
> assumption is correct.

Ah, but that's not true. The user is actively encouraged to store stuff
in $HOME, and not elsewhere, because:

1) There's no other folder that exists. The average user makes use of
what's already there.

2) The GNOME desktop has a large home icon where you put your files.

3) All applications that have a save dialog open /home as the default.

4) It's designated as a place to store your files in the GNOME Places

5) There's no easy way to export files you care about (minus settings)
through Samba, while there is an automatic HOME share you get for /home.

6) From a SELinux viewpoint, why does the user domain *need* access
to /home's setting part at all? Those are files created w/out direct
user interaction. They could be made accessible to individual
application domains, without user_t selinux access. 

Anyway, more to the point:

7) I can't call file_type_auto_trans twice on the same folder.

> If you want applications to share data, there are several ways to
> accomplish that goal. Here's just a quick idea:
> 
> * add $HOME/Downloads as a directory
> * give it its own type, maybe ROLE_downloads_t
> * give mozilla permissions to write there, with file_type_auto_trans
> * give mplayer permissions to the resulting files

...that's what I already proposed, but I'm saying that:

A) In the future if all desktop apps are restricted, this folder will
have to become something more generic that doesn't have anything to do
with downloads. It would become the equivalent of a new /home where you
keep your files. Are there any plans to restrict desktop apps ?

B) Whatever is decided upon needs to work out of the box. It needs to be
the default way things work, as opposed to me having to jump through
hoops to make SElinux work. Otherwise the average user will just disable
any protection and not look back.

> voila, mplayer can now play stuff downloaded from the web, without
> opening up the big hole of giving it permissions to all mozilla files.

Actually now I remember mplayer actually does have access to mozilla
files... but as you say that is a hack, which shouldn't be there.
However mplayer doesn't have access to gift files, which is what I was
thinking of. 

> The point is - I may or may not want mplayer to play random stuff from
> the web with potentially dangerous content. If you want to, evaluate
> your security requirements and institute the appropriate solution.

This email was titled "Desktop apps interoperability". It implies that
we're talking about the average desktop, as opposed to a paranoid
environment. The average person does not know (or care) for evaluating
security requirements and dealing with selinux. He/she wants
transparency, but there's still value in using selinux.

If you choose to download the content in question, and choose to run
mplayer on it, then it seems to me that it should work without messing
with security contexts.

--------

In the short run a downloads folder sounds like a good idea to me.
If added to skel, and set as the default download folder for mozilla,
that would be an improvement, I think. 

-- 
Ivan Gyurdiev <ivg2@cornell.edu>
Cornell University


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
