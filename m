Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j2V9KbDo023151
	for <selinux@tycho.nsa.gov>; Thu, 31 Mar 2005 04:20:37 -0500 (EST)
Received: from postoffice9.mail.cornell.edu (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j2V9GeTg010380
	for <selinux@tycho.nsa.gov>; Thu, 31 Mar 2005 09:16:40 GMT
Subject: Re: Desktop apps interoperability
From: Ivan Gyurdiev <ivg2@cornell.edu>
Reply-To: ivg2@cornell.edu
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Cc: Casey Schaufler <casey@schaufler-ca.com>, selinux@tycho.nsa.gov
In-Reply-To: <20050330220018.GA9752@lkcl.net>
References: <20050330170426.86197.qmail@web31606.mail.mud.yahoo.com>
	 <20050330172630.GA10139@lkcl.net> <1112204662.8592.42.camel@cobra.ivg2.net>
	 <20050330220018.GA9752@lkcl.net>
Content-Type: text/plain
Date: Thu, 31 Mar 2005 04:25:19 -0500
Message-Id: <1112261119.10971.14.camel@cobra.ivg2.net>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> 
> > This is a discussion of desktop applications that manipulate content
> > relevant to the user - not internal settings. 
> 
>  i believe it started out as internal settings [someone
>  suggested a ~/.etc / registry etc solution e.g. gconfd]
>  or maybe that was a different thread.  ... anyway.

(Re-adding fedora-selinux-list to cc - why was it removed?)

It's another part of the same problem - the internal settings are mixed
with the content, and that's bad. You can move the settings, move the
content, or both. Since the second is easier, that's what I suggest be 
done to begin with - later something can be done about settings.

The content folders should exist whether or not SElinux is installed, as
an organizational tool - there's no reason why mozilla should go and
clutter up my /home folder whether or not SELinux is involved - I never
liked that, which is why I always make a separate folder anyway, and put
stuff there. Apps should be configured to store things at their
particular content folder by default. Those folders should be in 
GNOME's Places menu.

The only controversial thing seems to be that I'm suggesting that they
can *only* write there, the SElinux-imposed restriction. 

I'm not sure that's such a huge problem.

Okay, here's how this is going to work - if you want to delete the
preinstalled music content folder, and put your things somewhere else,
music_content_t would be configured as a customizable context - all
those contexts should be customizable. That means they survive a
restorecon, among other things.

Then you can make a folder, and in nautilus you right click,
and you see the SELinux content (dwalsh has a patch for that).
Then I've wanted to modify that patch to have a drop-down box 
of customizable contexts for the user to choose from. I haven't gotten
around to doing that yet, but I think you should be able to right click
in nautilus, open up a drop-down box of contents, and pick: Media
(media_content_t), or whatever. Then after that your app will be able to
save to that folder too.

-- 
Ivan Gyurdiev <ivg2@cornell.edu>
Cornell University


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
