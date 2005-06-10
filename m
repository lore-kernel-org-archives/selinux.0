Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j5A2dngA015585
	for <selinux@tycho.nsa.gov>; Thu, 9 Jun 2005 22:39:49 -0400 (EDT)
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j5A2WHpU009273
	for <selinux@tycho.nsa.gov>; Fri, 10 Jun 2005 02:32:17 GMT
Subject: Re: Restorecon script
From: Ivan Gyurdiev <gyurdiev@redhat.com>
Reply-To: gyurdiev@redhat.com
To: Joshua Brindle <jbrindle@tresys.com>
Cc: Daniel J Walsh <dwalsh@redhat.com>, SELinux <selinux@tycho.nsa.gov>,
   selinux-dev@tresys.com
In-Reply-To: <42A8F6C1.20106@tresys.com>
References: <1118328119.29360.4.camel@dhcp83-8.boston.redhat.com>
	 <42A8F6C1.20106@tresys.com>
Content-Type: text/plain
Date: Thu, 09 Jun 2005 22:32:47 -0400
Message-Id: <1118370767.30464.16.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> What problem is this solving?

It is solving the problem of labeling things properly in /tmp and /home
(according to recent policy changes, which I've been working on).
This cannot be accomplished by either inheriting the parent's context,
(because it's not the same), or by file_type_auto_trans, because of
ambiguity - same type change rule matches multiple target types.
You can see details of what I mean in the thread "file_type_auto_trans
is not sufficient" on selinux@tycho.nsa.gov.

It can be solved by setfscreate code in the application, but
that's worse - intrusive code in multiple applications.

Creating folders ahead of time is the most acceptable solution so far.
I'm not sure how exactly this should be done, but some sort of simple 
script like this is one possibility. 

>  In general relabeling isn't something that 
> should be done without careful attention, especially when automated. 

I agree.

> User home directories shouldn't have incorrect labels is care is taken 
> (ie, skel contains the directories you'd be relabeling anyway and they 
> are labeled correctly when the user is added).

skel is populated when installing individual applications, and 
that doesn't fix the labels for existing users, only for newly 
created users. Also, that doesn't address /tmp.
==============

Here's a new script:

#!/bin/bash

([ -x /usr/sbin/selinuxenabled ] && /usr/sbin/selinuxenabled) || exit

DIRS=" \
/tmp/orbit-$USER \
$HOME/.fonts \
$HOME/.fonts/auto \
$HOME/.gnome2 \
$HOME/.gnome2/share/fonts \
$HOME/.gnome2/share/cursor-fonts \
$HOME/.gnome2_private \
$HOME/.mozilla \
$HOME/.evolution \
$HOME/.thunderbird \
"

for DIR in $DIRS; do
[ -d $DIR ] || mkdir -m 700 -p $DIR
done

RESTORED=`/sbin/restorecon -v $DIRS 2>&1`
if [ ! -z "$RESTORED" ]; then
        RESULT=`echo "$RESTORED" | awk '{ print $3 }'`
        echo "Restoring SELinux context for:"
        echo $RESULT | sed 's| |\n|g'
        /sbin/restorecon -R $RESULT
fi




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
