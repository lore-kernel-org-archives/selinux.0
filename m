Message-ID: <1327516014.9496.8.camel@moss-lions.epoch.ncsc.mil>
Subject: Re: SEAndroid app data labeling
From: James Carter <jwcart2@tycho.nsa.gov>
Reply-To: jwcart2@tycho.nsa.gov
To: Joshua Brindle <method@manicmethod.com>
Cc: SE Linux <selinux@tycho.nsa.gov>, Stephen Smalley <sds@tycho.nsa.gov>
Date: Wed, 25 Jan 2012 13:26:54 -0500
In-Reply-To: <4F201BE3.1020603@manicmethod.com>
References: <4F201BE3.1020603@manicmethod.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2012-01-25 at 10:12 -0500, Joshua Brindle wrote:
> I'm working through some denials with SEAndroid on Galaxy Nexus and I'm confused 
> about app data labeling. I thought that the app data would be labeled with the 
> same category as the app, so c13 app would have c13 on the files in /data. I see 
> the note in seapp_contexts that levelfromUID only works on apps. How do you get 
> filesystem separation without labeling the apps with the category?
> 
> 
On both the emulator and my Nexus S, the files in /data/data are labeled
with categories.

> Also, I'm getting denials like this, which I'm a little confused about since 
> trusted_app is part of appdomain and appdomain has create_file_perms on 
> app_data_file. I'm not sure how untrusted_app would be able to keep any state 
> since everything in /data/data seems to be labeled app_data_file though:
> 
> <5>[   25.067932] type=1400 audit(1327503267.632:59): avc:  denied  { add_name } 
> for  pid=461 comm="ContactsProvide" name="contacts2.db-mj1A7E80AF" 
> scontext=u:r:trusted_app:s0:c0 tcontext=u:object_r:app_data_file:s0 tclass=dir
> <5>[   25.148498] type=1400 audit(1327503267.718:60): avc:  denied  { 
> remove_name } for  pid=461 comm="ContactsProvide" name="contacts2.db-mj1A7E80AF" 
> dev=mmcblk0p12 ino=578665 scontext=u:r:trusted_app:s0:c0 
> tcontext=u:object_r:app_data_file:s0 tclass=dir
> <5>[   26.209320] type=1400 audit(1327503268.773:61): avc:  denied  { write } 
> for  pid=570 comm="viders.calendar" name="calendar.db" dev=mmcblk0p12 ino=578386 
> scontext=u:r:trusted_app:s0:c6 tcontext=u:object_r:app_data_file:s0 tclass=file
> <5>[   26.263183] type=1400 audit(1327503268.828:62): avc:  denied  { setattr } 
> for  pid=570 comm="viders.calendar" name="calendar.db" dev=mmcblk0p12 ino=578386 
> scontext=u:r:trusted_app:s0:c6 tcontext=u:object_r:app_data_file:s0 tclass=file
> 

I believe that these are from MLS constraints on writing down.

I don't think your /data/data is labeled properly.

> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.

-- 
James Carter <jwcart2@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
