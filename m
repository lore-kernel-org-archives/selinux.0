Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h3L4UKI4018599
	for <selinux@tycho.nsa.gov>; Mon, 21 Apr 2003 00:30:21 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h3L4UHVf012710
	for <selinux@tycho.nsa.gov>; Mon, 21 Apr 2003 04:30:17 GMT
Received: from kang.snu.edu (kang.snu.edu [204.126.2.3])
	by jazzswing.ncsc.mil  with ESMTP id h3L4UF4D012707
	for <selinux@tycho.nsa.gov>; Mon, 21 Apr 2003 04:30:16 GMT
Received: from gw.snu.edu ([172.16.200.11] helo=atlas.snu.edu)
	by kang.snu.edu with esmtp (Exim 4.12)
	id 197SwJ-00057I-00
	for selinux@tycho.nsa.gov; Sun, 20 Apr 2003 23:29:59 -0500
Message-Id: <sea32d76.091@atlas.snu.edu>
Date: Sun, 20 Apr 2003 23:29:25 -0500
From: "Joshua Brindle" <JBrindle@snu.edu>
To: <lms@ispgaya.pt>, <selinux@tycho.nsa.gov>
Subject: Re: SELinux ISO...
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

>On Mon, 21 Apr 2003 01:06, Luís Miguel Silva wrote:
>> Why isnt there a ISO of the SELinux available?
>
>So far the only person to work on this is Brian May.  He has paused in
his 
>work due to issues of bandwidth etc (transferring ISOs over modem
links is 
>really painful) and due to having other things to work on.
>
>It will get done eventually.
>

http://sourceforge.net/project/showfiles.php?group_id=21266&release_id=122117
there are iso's available there, i think they are based off redhat and
they are sorta old
--
I think there is a commercial effort to provide these called Westcam(?)
I can't 
find their url offhand but if you search the archives of this list you
should find
them.
--
I also have a project which just started up called Hardened Gentoo, one
of the
subprojects is SELinux integration, once we have usable policies and
everything
we'll have an SELinux kernel on the gentoo install cd. The SELinux
patches userland
patches and kernel are already in our package tree (called portage). 

SELinux on Gentoo isn't yet usable without the kernel in development
mode, but
it's quickly getting there, I'll make some sort of announcement when
it's really ready.

I'm not trying to advirtise, sorry if it seems that way but if you are
interested in the 
project check out http://cvs.gentoo.org/~method . Thanks


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
