Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l29HIuSd030114
	for <selinux@tycho.nsa.gov>; Fri, 9 Mar 2007 12:18:56 -0500
Received: from atlrel8.hp.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l29HIsI5018231
	for <selinux@tycho.nsa.gov>; Fri, 9 Mar 2007 17:18:54 GMT
From: Paul Moore <paul.moore@hp.com>
To: SE Linux <selinux@tycho.nsa.gov>
Subject: Recommended location of setkey configuration file?
Date: Fri, 9 Mar 2007 12:05:31 -0500
Cc: Daniel J Walsh <dwalsh@redhat.com>,
        "Christopher J.PeBenito" <cpebenito@tresys.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200703091205.32460.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

All of the following is in regards to RHEL5 and the MLS policy.

I'm trying to use a configuration file with setkey to setup the IPsec SPD in 
the kernel at boot.  Initially I created the configuration file 
as /etc/racoon/setkey.conf and put a line in my rc.local to run setkey like 
so:

 /sbin/setkey -f /etc/racoon/setkey.conf

I ran into two problems with this approach (AVCs posted below):

***
type=AVC msg=audit(1173457995.695:303): avc:  denied  { use } for  pid=2102 
comm="setkey" name="console" dev=tmpfs ino=725 
scontext=system_u:system_r:setkey_t:s0-s15:c0.c1023 
tcontext=system_u:system_r:init_t:s0-s15:c0.c1023 tclass=fd
type=AVC msg=audit(1173457995.695:303): avc:  denied  { use } for  pid=2102 
comm="setkey" name="console" dev=tmpfs ino=725 
scontext=system_u:system_r:setkey_t:s0-s15:c0.c1023 
tcontext=system_u:system_r:init_t:s0-s15:c0.c1023 tclass=fd
type=AVC msg=audit(1173457995.695:303): avc:  denied  { use } for  pid=2102 
comm="setkey" name="console" dev=tmpfs ino=725 
scontext=system_u:system_r:setkey_t:s0-s15:c0.c1023 
tcontext=system_u:system_r:init_t:s0-s15:c0.c1023 tclass=fd
type=AVC msg=audit(1173457995.721:304): avc:  denied  { search } for  pid=2102 
comm="setkey" name="racoon" dev=dm-0 ino=491816 
scontext=system_u:system_r:setkey_t:s0-s15:c0.c1023 
tcontext=system_u:object_r:ipsec_conf_file_t:s0 tclass=dir
***

The first problem involving fd use seems to have a rather simple fix, which I 
don't imagine should cause any adverse affects:

 init_use_fds(setkey_t)

However, the second problem of setkey not being allowed to search 
the /etc/racoon directory makes me believe I'm not placing my setkey.conf in 
the right location, or I simply have it named incorrectly.  Yet a quick 
search through the Reference Policy doesn't show an obvious name or location.  
My hunch is that any location under /etc should work, i.e. /etc/setkey.conf, 
but I was curious to see what the "recommended" solution is ...

Thanks.

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
