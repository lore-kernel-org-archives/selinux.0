Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id kAGDbgKW024349
	for <selinux@tycho.nsa.gov>; Thu, 16 Nov 2006 08:37:42 -0500
Received: from nz-out-0102.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id kAGDaxaI003003
	for <selinux@tycho.nsa.gov>; Thu, 16 Nov 2006 13:36:59 GMT
Received: by nz-out-0102.google.com with SMTP id z6so275350nzd
        for <selinux@tycho.nsa.gov>; Thu, 16 Nov 2006 05:37:57 -0800 (PST)
Message-ID: <e294b46e0611160537p10c3224cmfecac57ac4c1f4bc@mail.gmail.com>
Date: Thu, 16 Nov 2006 13:37:56 +0000
From: "Bradley Chapman" <kakadu@gmail.com>
To: selinux@tycho.nsa.gov
Subject: Strange file context issues
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

After tearing my hair out for the past two weeks trying to understand
the error messages I've been seeing in my Debian system, I've finally
twigged onto why I've been getting so many - there appears to be a
mislabeling of file contexts within my filesystems.

Take for example this error message in the dmesg:

audit(1163682174.716:3): avc:  denied  { read write } for  pid=1
comm="init" name="console" dev=sda6 ino=77743
scontext=system_u:system_r:init_t tcontext=system_u:object_r:file_t
tclass=chr_file

Clearly, the problem would seem to be that the file /dev/console has
the wrong context, preventing init from reading it.

Yet this is what I get when I do ls -l --context /dev/console:

crw-------  root root system_u:object_r:console_device_t /dev/console

The majority of early errors in dmesg appear to be similar, with
system_u:object_r:file_t popping up all over the place in /dev instead
of the correct contexts. I have a feeling that many of the remaining
errors I'm seeing are linked to this problem as well.

Can anyone offer any advice as to how this may have happened? I've
already tried a filesystem relabel but it doesn't seem to have had any
effect.

Brad
-- 
CONTROL YOUR TABS: https://addons.mozilla.org/extensions/158

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
