Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k2SD1dOW007537
	for <selinux@tycho.nsa.gov>; Tue, 28 Mar 2006 08:01:39 -0500
Received: from www346.sakura.ne.jp (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k2SD1a5d007387
	for <selinux@tycho.nsa.gov>; Tue, 28 Mar 2006 13:01:37 GMT
Received: from [127.0.0.1] (j069218.ppp.asahi-net.or.jp [61.213.69.218])
	by www346.sakura.ne.jp (8.12.11-p1/8.12.11) with ESMTP id k2SD1ZCu060918
	for <selinux@tycho.nsa.gov>; Tue, 28 Mar 2006 22:01:37 +0900 (JST)
	(envelope-from kaigai@kaigai.gr.jp)
Message-ID: <442933AD.3040208@kaigai.gr.jp>
Date: Tue, 28 Mar 2006 22:01:33 +0900
From: KaiGai Kohei <kaigai@kaigai.gr.jp>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: MCS and unconfined_t
Content-Type: text/plain; charset=ISO-2022-JP
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello,

Today, I'm considering an configuration for Fedora core 5 using MCS.

Some users are associated with restricted category 'c0,c1' at most.
If user field in security context would not change, they cannot
transit to wider range of categories.

But they can login with unconfined_t domain in default.
Because unconfined_t domain has 'execcon' permission, they can
transit to discretional range of categories by re-writing the
user field in security context.

Is it possible to control the unconfined_t processes by MCS ?
It seems a bit difficult.
Please notice me, if I have misunderstanding or misconfiguration.

Thanks,

---- current configuration ----
'ymj' logins with 'officer:system_r:unconfined_t:President'.
He can transit to 'user_t:system_t:unconfined_t:God' via an evil
program calls setexeccon().
It makes all MCS configuration nonsense.

[root@ayu ~]# semanage translation -l

Level                     Translation

s0
s0-s0:c0                  Executive
s0-s0:c0,c1               President
s0-s0:c0.c255             God
s0:c0                     Secret
s0:c0,c1                  TopSecret
[root@ayu ~]# semanage user -l

                MLS/       MLS/
SELinux User    MCS Level  MCS Range        SELinux Roles

officer         s0         President        system_r
root            s0         God              sysadm_r user_r system_r
system_u        s0         God              system_r
user_u          s0         God              sysadm_r user_r system_r
[root@ayu ~]# semanage login -l

Login Name                SELinux User              MLS/MCS Range

__default__               user_u                    s0
root                      root                      God
tak                       officer                   Executive
ymj                       officer                   President
[root@ayu ~]#

-- 
KaiGai Kohei <kaigai@kaigai.gr.jp>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
