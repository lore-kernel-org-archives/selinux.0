Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id kAHKj86j010892
	for <selinux@tycho.nsa.gov>; Fri, 17 Nov 2006 15:45:08 -0500
Received: from moss-lions.epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id kAHKhUaE008071
	for <selinux@tycho.nsa.gov>; Fri, 17 Nov 2006 20:43:30 GMT
Received: from moss-lions.epoch.ncsc.mil (localhost.localdomain [127.0.0.1])
	by moss-lions.epoch.ncsc.mil (8.13.8/8.13.8) with ESMTP id kAHKhFQb025244
	for <selinux@tycho.nsa.gov>; Fri, 17 Nov 2006 15:43:15 -0500
Received: (from jwcart2@localhost)
	by moss-lions.epoch.ncsc.mil (8.13.8/8.13.8/Submit) id kAHKhFKG025243
	for selinux@tycho.nsa.gov; Fri, 17 Nov 2006 15:43:15 -0500
Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id kAGHFu89031575
	for <selinux@tycho.nsa.gov>; Thu, 16 Nov 2006 12:15:57 -0500
Received: from nz-out-0102.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id kAGHFCHF003453
	for <selinux@tycho.nsa.gov>; Thu, 16 Nov 2006 17:15:13 GMT
Received: by nz-out-0102.google.com with SMTP id z6so323680nzd
        for <selinux@tycho.nsa.gov>; Thu, 16 Nov 2006 09:16:06 -0800 (PST)
Message-ID: <e294b46e0611160916h6ab95fe7p62c8a4637f616624@mail.gmail.com>
Date: Thu, 16 Nov 2006 17:16:06 +0000
From: "Bradley Chapman" <kakadu@gmail.com>
To: selinux@tycho.nsa.gov
Subject: Trouble with gconf and Thunar
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

After doing a bit of searching through the mail archive I came across
a new gconf policy by james Carter that I wanted to use due to issues
with the existing policy on Debian unstable. After installing it
though I'm confronted with the same errors as before:

audit(1163697082.507:93): avc:  denied  { read } for  pid=1874
comm="gconfd-2" name="path" dev=sda6 ino=28650
scontext=staff_u:staff_r:staff_t
tcontext=system_u:object_r:gconf_etc_t tclass=file
audit(1163697082.559:94): avc:  denied  { write } for  pid=1874
comm="gconfd-2" name=".gconf" dev=sda7 ino=16353
scontext=staff_u:staff_r:staff_t
tcontext=staff_u:object_r:staff_gconf_home_t tclass=dir
audit(1163697082.559:95): avc:  denied  { add_name } for  pid=1874
comm="gconfd-2" name=".testing.writeability"
scontext=staff_u:staff_r:staff_t
tcontext=staff_u:object_r:staff_gconf_home_t tclass=dir
audit(1163697082.559:96): avc:  denied  { create } for  pid=1874
comm="gconfd-2" name=".testing.writeability"
scontext=staff_u:staff_r:staff_t
tcontext=staff_u:object_r:staff_gconf_home_t tclass=file
audit(1163697082.567:97): avc:  denied  { remove_name } for  pid=1874
comm="gconfd-2" name=".testing.writeability" dev=sda7 ino=282074
scontext=staff_u:staff_r:staff_t
tcontext=staff_u:object_r:staff_gconf_home_t tclass=dir
audit(1163697082.567:98): avc:  denied  { unlink } for  pid=1874
comm="gconfd-2" name=".testing.writeability" dev=sda7 ino=282074
scontext=staff_u:staff_r:staff_t
tcontext=staff_u:object_r:staff_gconf_home_t tclass=file
audit(1163697082.603:99): avc:  denied  { read } for  pid=1874
comm="gconfd-2" name="saved_state" dev=sda7 ino=24530
scontext=staff_u:staff_r:staff_t
tcontext=staff_u:object_r:staff_gconf_home_t tclass=file
audit(1163697082.607:100): avc:  denied  { append } for  pid=1874
comm="gconfd-2" name="saved_state" dev=sda7 ino=24530
scontext=staff_u:staff_r:staff_t
tcontext=staff_u:object_r:staff_gconf_home_t tclass=file
audit(1163697082.719:101): avc:  denied  { read } for  pid=1874
comm="gconfd-2" name="%gconf-tree.xml" dev=sda6 ino=147170
scontext=staff_u:staff_r:staff_t tcontext=staff_u:object_r:gconf_etc_t
tclass=file

The fact the gconfd-2 is running in the staff_u:staff_r:staff_t domain
implies that it isn't labelled correctly:

ls --context /usr/lib/libgconf2-4/gconfd-2
-rwxr-xr-x  root root system_u:object_r:lib_t
/usr/lib/libgconf2-4/gconfd-2

So what label do I need to assign to bring the gconf-2 executable in
line with Mr. Carter's policy?

Also, does anyone have a policy for the Thunar Filesystem Manager?

Brad
-- 
CONTROL YOUR TABS: https://addons.mozilla.org/extensions/158

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
