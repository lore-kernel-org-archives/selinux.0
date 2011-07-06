Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p66D8Ckc023380
	for <selinux@tycho.nsa.gov>; Wed, 6 Jul 2011 09:08:12 -0400
Received: from exchange10.columbia.tresys.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id p66D8Axw018979
	for <selinux@tycho.nsa.gov>; Wed, 6 Jul 2011 13:08:10 GMT
Message-ID: <4E145E39.9050202@tresys.com>
Date: Wed, 6 Jul 2011 09:08:09 -0400
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
MIME-Version: 1.0
To: <Kurt.Nelson@gtri.gatech.edu>
CC: <selinux@tycho.nsa.gov>
Subject: Re: MLS Not enforcing secadm and auditadm
References: <BC2F7132E56EEE4E864092975C1447BA730123@apatlisdmbx02>
In-Reply-To: <BC2F7132E56EEE4E864092975C1447BA730123@apatlisdmbx02>
Content-Type: text/plain; charset="windows-1252"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 07/06/11 08:42, Kurt.Nelson@gtri.gatech.edu wrote:
> I’m setting up a RHEL6 box with MLS and am having issues with it
> enforcing the use of roles. Secadm_r and auditadm_r are not required to
> run setenforce or semanage and no role is able to write in /etc/audit/
> at all. The IRC channel seems to believe there is an issue with the
> ifndef(‘enable_mls’… not triggering.
[....]
> [root@hatch ~]# sesearch --allow -s sysadm_t -t semanage_exec_t -c file
> -p execute
>    allow sysadm_t application_exec_type : file { ioctl read getattr lock
> execute execute_no_trans open } ;
>    type_transition sysadm_t semanage_exec_t : process semanage_t;

I did some looking at Refpolicy, and it doesn't appear to have this problem.

-- 
Chris PeBenito
Tresys Technology, LLC
www.tresys.com | oss.tresys.com

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
