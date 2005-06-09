Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j59Eo5gA010816
	for <selinux@tycho.nsa.gov>; Thu, 9 Jun 2005 10:50:06 -0400 (EDT)
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j59EgEFL020888
	for <selinux@tycho.nsa.gov>; Thu, 9 Jun 2005 14:42:14 GMT
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.12.11/8.12.11) with ESMTP id j59EgeWb020960
	for <selinux@tycho.nsa.gov>; Thu, 9 Jun 2005 10:42:40 -0400
Received: from mail.boston.redhat.com (mail.boston.redhat.com [172.16.76.12])
	by int-mx1.corp.redhat.com (8.11.6/8.11.6) with ESMTP id j59EgeO21381
	for <selinux@tycho.nsa.gov>; Thu, 9 Jun 2005 10:42:40 -0400
Subject: Restorecon script
From: Ivan Gyurdiev <gyurdiev@redhat.com>
Reply-To: gyurdiev@redhat.com
To: Daniel J Walsh <dwalsh@redhat.com>, SELinux <selinux@tycho.nsa.gov>
Content-Type: text/plain
Date: Thu, 09 Jun 2005 10:41:59 -0400
Message-Id: <1118328119.29360.4.camel@dhcp83-8.boston.redhat.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Any comments on the following script?
It's a profile script, to be shipped with selinux-policy-strict, 
executed per login shell. It hardcodes the applications, 
unfortunately, but does what we want for right now 
(at least a temp. solution, unless someone has a better one?)
Also, user needs to start a login shell to get it to run.

#!/bin/bash

([ -x /usr/sbin/selinuxenabled ] && /usr/sbin/selinuxenabled) || exit

DIRS=" \
/tmp/.ICE-unix \
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

UNIQUE_DIRS=" \
/tmp/.ICE-unix \
/tmp/orbit-$USER \
$HOME/.fonts \
$HOME/.gnome2 \
$HOME/.gnome2_private \
$HOME/.mozilla \
$HOME/.evolution \
$HOME/.thunderbird \
"

for DIR in $DIRS; do
[ -d $DIR ] || mkdir -p $DIR
done

RESTORED=`/sbin/restorecon -v $UNIQUE_DIRS 2>&1`
if [ ! -z "$RESTORED" ]; then
        /sbin/restorecon -R `echo "$RESTORED" | awk '{ print $3 }'`
fi



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
