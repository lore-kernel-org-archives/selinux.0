Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m67KJsM0012461
	for <selinux@tycho.nsa.gov>; Mon, 7 Jul 2008 16:19:54 -0400
Received: from eastrmmtao104.cox.net (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m67KJr2F029575
	for <selinux@tycho.nsa.gov>; Mon, 7 Jul 2008 20:19:54 GMT
Message-ID: <48727A05.6050505@cox.net>
Date: Mon, 07 Jul 2008 16:18:13 -0400
From: "David L Durant (Mags)" <emags4DLD@cox.net>
MIME-Version: 1.0
To: Stephen Smalley <sds@epoch.ncsc.mil>
CC: "Serge E. Hallyn" <serue@us.ibm.com>, ltp-list@lists.sourceforge.net,
        SELinux <selinux@tycho.nsa.gov>, David Howells <dhowells@redhat.com>,
        Andrew Morgan <morgan@kernel.org>
Subject: Re: running filecaps ltp test
References: <20080707184252.GC22937@us.ibm.com> <1215456424.27975.165.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1215456424.27975.165.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2008-07-07 14:47 -0500, Stephen Smalley wrote:

> On Mon, 2008-07-07 at 13:42 -0500, Serge E. Hallyn wrote:
>   
>> It looks like unconfined_t is not granted setfcap capability.  So
>> when running ltp as unconfined_t, the file capabilities test fails.
>> I'm just wondering what the right answer is:
>>
>> 	1. require running ltp as an administrative type
>> 	2. give ltp a custom policy module to create an ltp_t
>> 	3. give setfcap to unconfined_t
>>     
> unconfined_t should have all capabilities already.
> Policy version?

Well, earlier today while running as _root_ with full-blown permissions, 
I noticed that I couldn't access */home/dave/.gvfs*, (except to see that 
it is a directory).

[dave@fedora ~]$ *ls -ld /home/dave/.gvfs*
dr-x------ 2 dave durant 0 2008-07-07 09:40 /home/dave/.gvfs
[dave@fedora ~]$ su -
Password: 
[root@fedora ~]# *ls -ld .gvfs*
ls: cannot access /home/dave/.gvfs: Permission denied
[root@fedora ~]# *secon*
user: unconfined_u
role: unconfined_r
type: unconfined_t
sensitivity: s0
clearance: s0:c0.c1023
mls-range: s0-s0:c0.c1023
[root@fedora ~]# 

David L Durant
=================

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
