Message-ID: <416FCFEB.90504@redhat.com>
Date: Fri, 15 Oct 2004 09:26:03 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@epoch.ncsc.mil>, Russell Coker <rcoker@redhat.com>,
   SELinux <SELinux@tycho.nsa.gov>
Subject: Not sure the best way to handle this one.
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Oct 15 08:37:55 dhcppc1 kernel: audit(1097843874.920:692545): avc:  
denied  { sys_module } for  pid=4338 exe=/usr/bin/nifd capability=16 
scontext=system_u:system_r:howl_t tcontext=system_u:system_r:howl_t 
tclass=capability

Ideas.

Dan

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
