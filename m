Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id OAA10015
	for <selinux@tycho.nsa.gov>; Thu, 29 Nov 2001 14:48:12 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id TAA28133
	for <selinux@tycho.nsa.gov>; Thu, 29 Nov 2001 19:47:32 GMT
Received: from avalon.informatik.uni-freiburg.de (avalon.informatik.uni-freiburg.de [132.230.150.1])
	by jazzband.ncsc.mil  with ESMTP id TAA28129
	for <selinux@tycho.nsa.gov>; Thu, 29 Nov 2001 19:47:31 GMT
Received: from informatik.uni-freiburg.de (paere.informatik.uni-freiburg.de [132.230.166.137])
	by avalon.informatik.uni-freiburg.de (8.9.0/8.9.0) with ESMTP id UAA23586
	for <selinux@tycho.nsa.gov>; Thu, 29 Nov 2001 20:48:08 +0100 (MET)
Received: (from brucker@localhost)
	by informatik.uni-freiburg.de (8.9.0/8.9.0) id UAA14821
	for selinux@tycho.nsa.gov; Thu, 29 Nov 2001 20:48:05 +0100 (MET)
Date: Thu, 29 Nov 2001 20:48:05 +0100
From: "Achim D. Brucker" <brucker@informatik.uni-freiburg.de>
To: selinux@tycho.nsa.gov
Subject: Re: Fwd: Re: SE Linux packages of login, sshd, tar, stat, findutils, fileutils, and [xkg]dm
Message-ID: <20011129204805.A14777@paere.informatik.uni-freiburg.de>
References: <1BF4DDD78DDA5D4EB0769BEA7F158E5A6F384C@amcw2ms812.amc.ds.af.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1BF4DDD78DDA5D4EB0769BEA7F158E5A6F384C@amcw2ms812.amc.ds.af.mil>; from randy.flood@scott.af.mil on Thu, Nov 29, 2001 at 11:08:00AM -0600
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, Nov 29, 2001 at 11:08:00AM -0600, Flood Randy Capt AFCA/TCAA wrote:
> 
> This seems to be a flaw with the Debian distribution then.  Doesn't the
> Linux filesystems standard (or whatever its called) specify that
> software should be installed there?
No it is not a flaw ;-). 
The main argument/idea is, that the directories 
/usr/local and /opt are 100% controlled by the local policy, therefore no 
package controlled through the packet manager is allowed to put files in
there. The main advante for the system administrator is, that is can do 
whatever he wants below /usr/local without the risk of breaking the 
packet manager. Personally I like this very much and it perfectly conforms
to the Linux file system standard.
When I remember correctly, the packages officially distributed by Suse or
Redhat do not write files into /usr/local. Surely there are rpms (and even 
debs) floating around the net, which install files below /usr/local, but they
are not distributed as official parts of any the distribution (I assume this
for Redhat/Mandrake/Suse and it is a strict policy for Debian).  When SE-Linux
is included in Debian (which I wish), it has to play the game of the Debian
Guidelines because it would be an official part of the distribution.


Best wishes
	Achim
-- 
Achim D. Brucker, brucker@informatik.uni-freiburg.de 
 http://www.informatik.uni-freiburg.de/~brucker
pgp-key on request: send mail with subject: public-key

Those who do not understand Unix are condemned to reinvent it, poorly. 
 -- Henry Spencer


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
