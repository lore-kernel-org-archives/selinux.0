Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i18GWgRb000542
	for <selinux@tycho.nsa.gov>; Sun, 8 Feb 2004 11:32:42 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i18GWeOi000879
	for <selinux@tycho.nsa.gov>; Sun, 8 Feb 2004 16:32:40 GMT
Received: from crisium.vnl.com (crisium.vnl.com [194.46.8.33])
        by jazzband.ncsc.mil  with ESMTP id i18GWdWW000870 for <selinux@tycho.nsa.gov>; Sun, 8 Feb 2004 16:32:39 GMT
Date: Sun, 8 Feb 2004 16:32:36 +0000
From: Dale Amon <amon@vnl.com>
To: selinux@tycho.nsa.gov
Subject: Problem with defaulting answers to selinux-policy-default
Message-ID: <20040208163236.GF10500@vnl.com>
Mime-Version: 1.0
Content-Type: message/rfc822
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Date: Fri, 6 Feb 2004 21:51:14 +0000
From: Dale Amon <amon@vnl.com>
To: selinux@tycho.nsa.gov
Subject: Problem with defaulting answers to selinux-policy-default
Message-ID: <20040206215114.GJ21675@vnl.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Operating-System: Linux, the choice of a GNU generation
User-Agent: Mutt/1.5.5.1+cvs20040105i

I think Russell is again buried in email and work, so
perhaps someone else can make a suggestion. It is probably
something simple I would have known about if I had not
been off on the road. I've a few hours here and there
over the next week or so (maybe) so I wanted to try to
get this working again:


As you probably remember, I use a set of build scripts
to do this all completely hands off. It looks like 
something broke them again while I was off doing other
jobs. I see the following:

-------
Using policy installation method "Semi-Automatic"
Copying the sample /usr/share/selinux/policy/current directory from
/usr/share/selinux/policy/default
Removal of unwanted policy files
Removing "current/domains/program/gnome-pty-helper.te"
Include "Checkpolicy - SELinux policy compliler" (current/domains/program/checkpolicy.te) in policy?
 (References known installed packages: checkpolicy)
 Yes/No/Display/Background [Y/n/d/b]? 

-------

but I shouldn't be seeing it at all because the install
is being done with this line:

"${CHROOT_BIN}"/yes "" | PRIORITY=low DEBIAN_FRONTEND=noninteractive /usr/bin/apt-get -qqqqq -y install "$name" > /dev/null

where in this case $name is selinux-policy-default.

Any idea what I now have to do to make this line
just unconditionally *do it* and not ask silly
questions? Keep in mind that the install is to a
de novo system, a freshly created loopback file.

Either something of mine has died of bitrot in the
last 2 months while I was doing other things, or
something has changed in the way this package
installs.

-- 
------------------------------------------------------
   Dale Amon     amon@islandone.org    +44-7802-188325
       International linux systems consultancy
     Hardware & software system design, security
    and networking, systems programming and Admin
	      "Have Laptop, Will Travel"
------------------------------------------------------

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
