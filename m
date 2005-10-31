Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j9V7GvMA009882
	for <selinux@tycho.nsa.gov>; Mon, 31 Oct 2005 02:16:58 -0500 (EST)
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j9V7CBmc018499
	for <selinux@tycho.nsa.gov>; Mon, 31 Oct 2005 07:12:12 GMT
Received: from localhost (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id EB8B961B01
	for <selinux@tycho.nsa.gov>; Mon, 31 Oct 2005 18:12:05 +1100 (EST)
Received: from smtp.sws.net.au ([127.0.0.1])
	by localhost (smtp [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 15822-03 for <selinux@tycho.nsa.gov>;
	Mon, 31 Oct 2005 18:12:05 +1100 (EST)
Received: from aeon.coker.com.au (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id 633AD61B00
	for <selinux@tycho.nsa.gov>; Mon, 31 Oct 2005 18:12:05 +1100 (EST)
Received: from aeon (aeon [127.0.0.1])
	by aeon.coker.com.au (Postfix) with ESMTP id B870727123
	for <selinux@tycho.nsa.gov>; Mon, 31 Oct 2005 18:12:03 +1100 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "SE-Linux" <selinux@tycho.nsa.gov>
Subject: unreasonably long SE Linux context display
Date: Mon, 31 Oct 2005 18:11:56 +1100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200510311812.02462.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Would it be possible to use shorter names in the setrans.conf file than 
SystemLog and SystemHigh?  For example could we have "Low-High" or 
"sLow-sHigh" instead?

An 80 column display is the Unix standard, it's what xterm type programs 
default to, it's what generally works best with serial consoles, and it's the 
only option for Braille displays.

Currently in Fedora and RHEL (and probably the default installs of most 
distributions) the virtual consoles are 80 columns wide.  So anything that 
requires more than 80 columns in a display will not work well with the 
majority of Linux systems.

For "ps" output we have to fit 80 columns, everything else is truncated, this 
means that the increasing width of SE Linux output from "ps axZ" is reducing 
the amount of other data available.  Currently the sensitivity labels of 
"s0-s0:c0.c255" take up a significant part of the screen space and adding an 
extra 7 characters by translating it to "SystemLow-SystemHigh" will only make 
things worse (it will then take up 25% of the screen giving a total of almost 
75% of the screen for the SE Linux context).

Also I think we should consider making the various utility programs display 
part of the SE Linux context.  For example it's a common practice for an 
administrator to search for a listing of processes in a particular domain or 
role with commands such as the following:
ps axZ|grep kernel_t
ps axZ|grep system_r

It seems to me that one way of improving the situation with ps might be to 
allow specifying a regex for the context to match in a similar manner to 
killall (could probably take the same code).  Another possibility is to allow 
displaying partial contexts.  For example I might want to see the domains 
used by system processes (role==system_r) but not have the role or identity 
displayed (because they are not relevant).  Of course we may have great 
trouble trying to get such changes accepted upstream.

For ls it would be good to be able to display part of the context.  For the 
vast majority of invocations of "ls -Z" on a SE Linux system the identity and 
role are not desired in the output.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
