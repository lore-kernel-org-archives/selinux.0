Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j2S5MjDo023194
	for <selinux@tycho.nsa.gov>; Mon, 28 Mar 2005 00:22:46 -0500 (EST)
Received: from postoffice9.mail.cornell.edu (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j2S5JIUJ008547
	for <selinux@tycho.nsa.gov>; Mon, 28 Mar 2005 05:19:18 GMT
Subject: Re: Desktop apps interoperability
From: Ivan Gyurdiev <ivg2@cornell.edu>
Reply-To: ivg2@cornell.edu
To: "Fedora SELinux support list for users &amp;  developers." <fedora-selinux-list@redhat.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1111986213.1514.77.camel@cobra.ivg2.net>
References: <1111985855.1514.70.camel@cobra.ivg2.net>
	 <1111986213.1514.77.camel@cobra.ivg2.net>
Content-Type: text/plain
Date: Mon, 28 Mar 2005 00:27:31 -0500
Message-Id: <1111987652.1514.97.camel@cobra.ivg2.net>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2005-03-28 at 00:03 -0500, Ivan Gyurdiev wrote:
> Okay that was an unfinished email - sorry for my stupidity - I was 
> editing it and changing things and clicked send by mistake.
> 
> The problem is accurately described (in the first part of the email) and
> what I was getting to - I'm trying to imagine how desktop apps can be
> confined properly in the future (and right now, for that matter). How
> will they interoperate and share data?
> 
> I was thinking of a ~/downloads folder with a shared context, but 
> this makes sense for apps that download stuff. In the future if desktop
> apps are confined (say openoffice, abiword) this becomes a more generic
> problem.

Part of the problem seems to be the way Linux apps treat /home, as the
place for everything. Why are both app. settings and user data stored
in /home as the default location. That's where the problem comes from,
and that seems like a bad idea - the user doesn't care about app
settings and system files - they are not to be edited directly. That's
why they're hidden in the first place. 

Now Windows' approach of having "My Documents" and the like is starting
to make a lot of sense (even though I absolutely hate those names).

If app settings were kept separate, in a non-selinux environment you
could export your data files w/out exporting hidden important files like
your gpg keys. 

If app settings were kept separate, you could restorecon those settings
to correct contexts. Dwalsh said restorecon skips /home today because
it could accidentaly reveal out-of-place gpg keys, or because it might
be really big. Both those problems would not apply if settings were in a
separate place - you could just restorecon the settings.

-- 
Ivan Gyurdiev <ivg2@cornell.edu>
Cornell University


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
