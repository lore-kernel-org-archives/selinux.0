Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id PAA01720
	for <selinux@tycho.nsa.gov>; Tue, 9 Jul 2002 15:21:31 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id TAA02559
	for <selinux@tycho.nsa.gov>; Tue, 9 Jul 2002 19:20:56 GMT
Received: from avocet.mail.pas.earthlink.net (avocet.mail.pas.earthlink.net [207.217.120.50])
	by jazzswing.ncsc.mil  with ESMTP id TAA02555
	for <selinux@tycho.nsa.gov>; Tue, 9 Jul 2002 19:20:55 GMT
From: "Ryan Bergauer" <privateryan@mindspring.com>
To: "'Stephen Smalley'" <sds@tislabs.com>
Cc: <selinux@tycho.nsa.gov>
Subject: RE: quota and ampd (and one more thing)
Date: Tue, 9 Jul 2002 14:21:21 -0500
Message-ID: <000701c2277d$cf5f9be0$6501a8c0@donkey>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <Pine.GSO.4.33.0207090714340.27193-100000@raven>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:

>> In addition, I'm getting quite a few denied messages at boot and
>> shutdown regarding killall5 when I enable Advanced Power Management
Bios
>> in the kernel (with apmd_t wanting read-type permissions for items in
>> init_t and kernel_t.) This sound familiar to anyone else? Please note
>> that this was occurring before the new release, I just never got
around
>> to confronting it until now.
>
> What are the specific audit messages (or at least some examples)?

Here are four of the ones appearing at boot. They're pretty
representative of the rest.

avc:  denied  { getattr } for  pid=712 exe=/sbin/killall5 path=/1/stat
dev=00:03 ino=65547 scontext=system_u:system_r:apmd_t
tcontext=system_u:system_r:init_t tclass=file

avc:  denied  { read } for  pid=712 exe=/sbin/killall5 path=/1/exe
dev=00:03 ino=65543 scontext=system_u:system_r:apmd_t
tcontext=system_u:system_r:init_t tclass=lnk_file

avc:  denied  { search } for  pid=712 exe=/sbin/killall5 path=/4
dev=00:03 ino=262146 scontext=system_u:system_r:apmd_t
tcontext=system_u:system_r:kernel_t tclass=dir

avc:  denied  { read } for  pid=712 exe=/sbin/killall5 path=/4/stat
dev=00:03 ino=262155 scontext=system_u:system_r:apmd_t
tcontext=system_u:system_r:kernel_t tclass=file


Also, I tried running run_init this morning and received the message
(after authentication):

execvp_secure: No such file or directory

Has anyone encountered this?

-Ryan 


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
