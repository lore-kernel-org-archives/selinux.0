Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id kAHKuG6J011200
	for <selinux@tycho.nsa.gov>; Fri, 17 Nov 2006 15:56:16 -0500
Received: from moss-lions.epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id kAHKscaE010090
	for <selinux@tycho.nsa.gov>; Fri, 17 Nov 2006 20:54:38 GMT
Received: from moss-lions.epoch.ncsc.mil (localhost.localdomain [127.0.0.1])
	by moss-lions.epoch.ncsc.mil (8.13.8/8.13.8) with ESMTP id kAHKsNAW025320
	for <selinux@tycho.nsa.gov>; Fri, 17 Nov 2006 15:54:23 -0500
Received: (from jwcart2@localhost)
	by moss-lions.epoch.ncsc.mil (8.13.8/8.13.8/Submit) id kAHKsNJW025319
	for selinux@tycho.nsa.gov; Fri, 17 Nov 2006 15:54:23 -0500
Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id kAHKsGrV011146
	for <selinux@tycho.nsa.gov>; Fri, 17 Nov 2006 15:54:16 -0500
Subject: Re: Trouble with gconf and Thunar
From: James Carter <jwcart2@epoch.ncsc.mil>
Reply-To: jwcart2@epoch.ncsc.mil
To: Bradley Chapman <kakadu@gmail.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <e294b46e0611160916h6ab95fe7p62c8a4637f616624@mail.gmail.com>
References: <e294b46e0611160916h6ab95fe7p62c8a4637f616624@mail.gmail.com>
Content-Type: text/plain
Date: Fri, 17 Nov 2006 15:52:23 -0500
Message-Id: <1163796743.22589.8.camel@moss-lions.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2006-11-16 at 17:16 +0000, Bradley Chapman wrote:
> After doing a bit of searching through the mail archive I came across
> a new gconf policy by james Carter that I wanted to use due to issues
> with the existing policy on Debian unstable. After installing it
> though I'm confronted with the same errors as before:
> 
> audit(1163697082.507:93): avc:  denied  { read } for  pid=1874
> comm="gconfd-2" name="path" dev=sda6 ino=28650
> scontext=staff_u:staff_r:staff_t
> tcontext=system_u:object_r:gconf_etc_t tclass=file
> audit(1163697082.559:94): avc:  denied  { write } for  pid=1874
> comm="gconfd-2" name=".gconf" dev=sda7 ino=16353
> scontext=staff_u:staff_r:staff_t
> tcontext=staff_u:object_r:staff_gconf_home_t tclass=dir
> audit(1163697082.559:95): avc:  denied  { add_name } for  pid=1874
> comm="gconfd-2" name=".testing.writeability"
> scontext=staff_u:staff_r:staff_t
> tcontext=staff_u:object_r:staff_gconf_home_t tclass=dir
> audit(1163697082.559:96): avc:  denied  { create } for  pid=1874
> comm="gconfd-2" name=".testing.writeability"
> scontext=staff_u:staff_r:staff_t
> tcontext=staff_u:object_r:staff_gconf_home_t tclass=file
> audit(1163697082.567:97): avc:  denied  { remove_name } for  pid=1874
> comm="gconfd-2" name=".testing.writeability" dev=sda7 ino=282074
> scontext=staff_u:staff_r:staff_t
> tcontext=staff_u:object_r:staff_gconf_home_t tclass=dir
> audit(1163697082.567:98): avc:  denied  { unlink } for  pid=1874
> comm="gconfd-2" name=".testing.writeability" dev=sda7 ino=282074
> scontext=staff_u:staff_r:staff_t
> tcontext=staff_u:object_r:staff_gconf_home_t tclass=file
> audit(1163697082.603:99): avc:  denied  { read } for  pid=1874
> comm="gconfd-2" name="saved_state" dev=sda7 ino=24530
> scontext=staff_u:staff_r:staff_t
> tcontext=staff_u:object_r:staff_gconf_home_t tclass=file
> audit(1163697082.607:100): avc:  denied  { append } for  pid=1874
> comm="gconfd-2" name="saved_state" dev=sda7 ino=24530
> scontext=staff_u:staff_r:staff_t
> tcontext=staff_u:object_r:staff_gconf_home_t tclass=file
> audit(1163697082.719:101): avc:  denied  { read } for  pid=1874
> comm="gconfd-2" name="%gconf-tree.xml" dev=sda6 ino=147170
> scontext=staff_u:staff_r:staff_t tcontext=staff_u:object_r:gconf_etc_t
> tclass=file
> 
> The fact the gconfd-2 is running in the staff_u:staff_r:staff_t domain
> implies that it isn't labelled correctly:
> 
> ls --context /usr/lib/libgconf2-4/gconfd-2
> -rwxr-xr-x  root root system_u:object_r:lib_t
> /usr/lib/libgconf2-4/gconfd-2
> 
This should be labeled as system_u:object_r:gconfd_exec_t
The problem is that in Fedora gconfd-2 is at /usr/libexec/gconfd-2.
Your gconf.fc file needs to have /usr/lib/libgconf2-4/gconfd-2 instead
of /usr/libexec/gconfd-2.

> So what label do I need to assign to bring the gconf-2 executable in
> line with Mr. Carter's policy?
> 

It should be labeled as staff_u:staff_r:staff_gconfd_t and it will be if
the executable is labeled correctly.

> Also, does anyone have a policy for the Thunar Filesystem Manager?
> 
> Brad
-- 
James Carter <jwcart2@epoch.ncsc.mil>
National Security Agency

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
