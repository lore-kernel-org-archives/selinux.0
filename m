Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l3NCD4bE000660
	for <selinux@tycho.nsa.gov>; Mon, 23 Apr 2007 08:13:04 -0400
Received: from wr-out-0506.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l3NCD3r9004785
	for <selinux@tycho.nsa.gov>; Mon, 23 Apr 2007 12:13:04 GMT
Received: by wr-out-0506.google.com with SMTP id q50so1457115wrq
        for <selinux@tycho.nsa.gov>; Mon, 23 Apr 2007 05:13:03 -0700 (PDT)
Message-ID: <462CA1F0.2000400@gmail.com>
Date: Mon, 23 Apr 2007 20:09:20 +0800
From: Ken YANG <spng.yang@gmail.com>
MIME-Version: 1.0
To: SELinux List <selinux@tycho.nsa.gov>
Subject: can not boot with strict policy
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


hi all:

i run in FC7 Rawhide with strict policy, which is built from svn
refpolicy:

TYPE = strict-mcs
DIRECT_INITRC=y
MONOLITHIC=n
MLS_SENS=16
MLS_CATS=1024
MCS_CATS=1024

after i loaded the policy:

make && make install && make load && \
"modify /etc/selinux/config to use new policy" && \
touch /.autorelabel


and reboot, but "kernel panic" occur:

"......
avc: denied {execute} for pid=1 comm="init" name="libsepol.so.1"
scontext=system_u:system_r:init_t:s0 tcontext=user_u:object_r:lib_t:s0
tclass=file
Kernel panic - not syncing: Attempted to kill init!
......"


i think the reason of above "execute error" is due to the following
policy:

allow files_unconfined_type file_type:{ file chr_file } ~execmod;
......
ifdef(`targeted_policy',`
	unconfined_domain(init_t)
')
......
files_type(lib_t)



is that right?

i made some tests, in which i removed the "targed_policy" conditions.
the "execute error" disappear, but there are more avc denied during
init process, and after following avc denied, the system restarting:

"
avc: denied { execute } ... comm="init" name="/lib/libblkid.so.1.0"
Restarting system.
"


i don't know what's wrong with my method?

thanks in advance


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
