Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7OCbvrT025829
	for <selinux@tycho.nsa.gov>; Tue, 24 Aug 2004 08:37:58 -0400 (EDT)
Received: from epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i7OCbCMZ001510
	for <selinux@tycho.nsa.gov>; Tue, 24 Aug 2004 12:37:12 GMT
Subject: Re: Users writting to home directory
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: "James R. Marcus" <jmarcus@mvalent.net>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <E6E16A6D4277CD459BBDE6713766033CA51515@exchange.mvalent.local>
References: <E6E16A6D4277CD459BBDE6713766033CA51515@exchange.mvalent.local>
Content-Type: text/plain
Message-Id: <1093350978.1800.80.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Tue, 24 Aug 2004 08:36:18 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2004-08-23 at 21:28, James R. Marcus wrote:
> I created the user with:
> 
> useradd -g users -d /usr/people/jmarcus -m -s /bin/bash -c "James R.
> Marcus" jmarcus

You need to set HOME to /usr/people in /etc/default/useradd and rebuild
your policy and relabel /usr/people.  Or just put the home directory
under /home, which is the current default.

> Aug 21 07:35:55 ftp audit(1093088155.035:0): avc:  denied  { add_name
> } for  pid=3985 exe=/usr/sbin/useradd name=jmarcus
> scontext=root:staff_r:staff_t tcontext=root:object_r:usr_t tclass=dir

Two obvious problems:  1) You are running useradd in the staff_r role
rather than the sysadm_r role.  newrole -r sysadm_r to switch to the
admin role.  2) The type on /usr/people is usr_t, whereas the policy
expects home directory root to have home_root_t.  This can be fixed as
described above, or more easily just by putting home directories under
/home as usual.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
