Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j2V9i7Do023285
	for <selinux@tycho.nsa.gov>; Thu, 31 Mar 2005 04:44:07 -0500 (EST)
Received: from postoffice9.mail.cornell.edu (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j2V9eATg010942
	for <selinux@tycho.nsa.gov>; Thu, 31 Mar 2005 09:40:10 GMT
Subject: Re: Desktop apps interoperability
From: Ivan Gyurdiev <ivg2@cornell.edu>
Reply-To: ivg2@cornell.edu
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Cc: Casey Schaufler <casey@schaufler-ca.com>, selinux@tycho.nsa.gov
In-Reply-To: <1112261119.10971.14.camel@cobra.ivg2.net>
References: <20050330170426.86197.qmail@web31606.mail.mud.yahoo.com>
	 <20050330172630.GA10139@lkcl.net> <1112204662.8592.42.camel@cobra.ivg2.net>
	 <20050330220018.GA9752@lkcl.net> <1112261119.10971.14.camel@cobra.ivg2.net>
Content-Type: text/plain
Date: Thu, 31 Mar 2005 04:48:53 -0500
Message-Id: <1112262533.10971.21.camel@cobra.ivg2.net>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> 
> Okay, here's how this is going to work - if you want to delete the
> preinstalled music content folder, and put your things somewhere else,
> music_content_t would be configured as a customizable context - all
> those contexts should be customizable. That means they survive a
> restorecon, among other things.
> 
> Then you can make a folder, and in nautilus you right click,
> and you see the SELinux content (dwalsh has a patch for that).
> Then I've wanted to modify that patch to have a drop-down box 
> of customizable contexts for the user to choose from. I haven't gotten
> around to doing that yet, but I think you should be able to right click
> in nautilus, open up a drop-down box of contents, and pick: Media
> (media_content_t), or whatever. Then after that your app will be able to
> save to that folder too.

Then for downloaded files, you can right-click and change their content
to whatever you want (list of customizables), or double-click on the
file, and GNOME does a mime-lookup on the file, and determines the
proper handler, and the proper context for that handler (like the other
person suggested)

Whenever you do that there could be a box saying something like:

"You are attempting to relabel potentially harmful content. 
 Are you sure you want to do this: Yes | No | Scan buttons 
 Checkbox: Do not ask again
 Checkbox: Perform a virus scan when opening file of this type"

... or something like that

-- 
Ivan Gyurdiev <ivg2@cornell.edu>
Cornell University


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
