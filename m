Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k5SElHG0008293
	for <selinux@tycho.nsa.gov>; Wed, 28 Jun 2006 10:47:17 -0400
Received: from wr-out-0506.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k5SElFmf006251
	for <selinux@tycho.nsa.gov>; Wed, 28 Jun 2006 14:47:15 GMT
Received: by wr-out-0506.google.com with SMTP id 37so492048wra
        for <selinux@tycho.nsa.gov>; Wed, 28 Jun 2006 07:47:14 -0700 (PDT)
Message-ID: <44A2966A.2040905@gmail.com>
Date: Wed, 28 Jun 2006 10:47:06 -0400
From: David-Alexandre Davidson <ryvore@gmail.com>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: Wrong tclass on a cifs share content
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

When accessing folders over a cifs share from a selinux context, I get 
audit messages, reporting denied actions
such as 0x100000 and 0x200000 , which refers to search, and rmdir. The 
problem is that selinux incorrectly
report the target class as "file", when it is in reality a "dir" 
element. Being unable to map these Hex code to
a valid action for a file, every request is denied no mater what policy 
rules are in effect. (actions like read,
setattr, getattr are valid because they are the same for file and dir 
elements)

I'm running Fedora core 5 with the lastest stable kernel, and it can 
easily be reproduced. Just map a cifs share,
(I use automount) and attempt a rmdir  /theshare/sample_dir  as root. 
and then :

type=AVC msg=audit(1151197545.712:144): avc:  denied  { 0x200000 } for  pid=2608
comm="rmdir" name="sample_dir" dev=cifs ino=8889
scontext=root:staff_r:staff_t:s0-s0:c0.c255 tcontext=system_u:object_r:cifs_t:s0
tclass=file


If anyone can help on that matter, or tell me who I should report this 
to, it would be very appreciated. I
believe it is related to the kernel either at the point the labeling is 
made when the share is mounted, or
if not, when selinux lookup the tclass on those element. Without 
selinux, everything work fine, and no file
system error occur. I'll be browsing the source code to find more 
details about what causes this issue,
but I'm not really familiar with that part of the kernel source.


-----------------------------
David-Alexandre Davidson

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
