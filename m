Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i95INqrT028506
	for <selinux@tycho.nsa.gov>; Tue, 5 Oct 2004 14:23:52 -0400 (EDT)
Received: from moss-lions.epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i95INp7h004531
	for <selinux@tycho.nsa.gov>; Tue, 5 Oct 2004 18:23:52 GMT
Subject: Re: policy patches
From: James Carter <jwcart2@epoch.ncsc.mil>
Reply-To: jwcart2@epoch.ncsc.mil
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <4162DEC3.4050306@redhat.com>
References: <200409292354.15227.russell@coker.com.au>
	 <200409300620.41527.russell@coker.com.au>
	 <1096648965.13366.35.camel@moss-lions.epoch.ncsc.mil>
	 <200410020344.04225.russell@coker.com.au>
	 <1096920735.3235.17.camel@moss-lions.epoch.ncsc.mil>
	 <4162C0C6.9090704@redhat.com>
	 <1096997754.30738.9.camel@moss-lions.epoch.ncsc.mil>
	 <4162DEC3.4050306@redhat.com>
Content-Type: text/plain
Message-Id: <1097000565.30738.20.camel@moss-lions.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Tue, 05 Oct 2004 14:22:45 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2004-10-05 at 13:49, Daniel J Walsh wrote:
> James Carter wrote:
> 
> >On Tue, 2004-10-05 at 11:41, Daniel J Walsh wrote:
> >  
> >
> >>Submitting patches against latest policy again.
> >>
> >>Dan
> >>
> >>______________________________________________________________________
> >>    
> >>
> >
> >  
> >
> >>diff --exclude-from=exclude -N -u -r nsapolicy/file_contexts/program/mozilla.fc policy-1.17.27/file_contexts/program/mozilla.fc
> >>--- nsapolicy/file_contexts/program/mozilla.fc	2004-09-30 20:48:49.000000000 -0400
> >>+++ policy-1.17.27/file_contexts/program/mozilla.fc	2004-10-05 11:37:05.225353688 -0400
> >>@@ -5,6 +5,7 @@
> >> HOME_DIR/\.gconfd(/.*)?		system_u:object_r:ROLE_mozilla_rw_t
> >> HOME_DIR/\.gconf(/.*)?		system_u:object_r:ROLE_mozilla_rw_t
> >> HOME_DIR/\.gnome2/epiphany(/.*)? system_u:object_r:ROLE_mozilla_rw_t
> >>+HOME_DIR/My Downloads(/.*)?	system_u:object_r:ROLE_mozilla_rw_t
> >> /usr/bin/netscape	--	system_u:object_r:mozilla_exec_t
> >> /usr/bin/mozilla	--	system_u:object_r:mozilla_exec_t
> >> /usr/bin/mozilla-snapshot --	system_u:object_r:mozilla_exec_t
> >>    
> >>
> >
> >Shouldn't this have an ifdef(`windows') around it? :)
> >
> >Is this going to be some sort of default download area for Mozilla?
> >Is this Fedora specific?
> >
> >  
> >
> Default download for Firefox.

This won't work with the space, I used this instead:

HOME_DIR/My.Downloads(/.*)?	system_u:object_r:ROLE_mozilla_rw_t

-- 
James Carter <jwcart2@epoch.ncsc.mil>
National Security Agency

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
