Received: from facesaver.epoch.ncsc.mil (facesaver [144.51.25.10])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m67KQ4Dh013744
	for <selinux@tycho.nsa.gov>; Mon, 7 Jul 2008 16:26:04 -0400
Subject: Re: running filecaps ltp test
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: "David L Durant (Mags)" <emags4DLD@cox.net>
Cc: "Serge E. Hallyn" <serue@us.ibm.com>, ltp-list@lists.sourceforge.net,
        SELinux <selinux@tycho.nsa.gov>, David Howells <dhowells@redhat.com>,
        Andrew Morgan <morgan@kernel.org>
In-Reply-To: <48727A05.6050505@cox.net>
References: <20080707184252.GC22937@us.ibm.com>
	 <1215456424.27975.165.camel@moss-spartans.epoch.ncsc.mil>
	 <48727A05.6050505@cox.net>
Content-Type: text/plain
Date: Mon, 07 Jul 2008 16:26:03 -0400
Message-Id: <1215462363.27975.185.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Mon, 2008-07-07 at 16:18 -0400, David L Durant (Mags) wrote:
> On Mon, 2008-07-07 14:47 -0500, Stephen Smalley wrote:
> 
> > On Mon, 2008-07-07 at 13:42 -0500, Serge E. Hallyn wrote:
> >   
> >> It looks like unconfined_t is not granted setfcap capability.  So
> >> when running ltp as unconfined_t, the file capabilities test fails.
> >> I'm just wondering what the right answer is:
> >>
> >> 	1. require running ltp as an administrative type
> >> 	2. give ltp a custom policy module to create an ltp_t
> >> 	3. give setfcap to unconfined_t
> >>     
> > unconfined_t should have all capabilities already.
> > Policy version?
> 
> Well, earlier today while running as _root_ with full-blown permissions, 
> I noticed that I couldn't access */home/dave/.gvfs*, (except to see that 
> it is a directory).
> 
> [dave@fedora ~]$ *ls -ld /home/dave/.gvfs*
> dr-x------ 2 dave durant 0 2008-07-07 09:40 /home/dave/.gvfs
> [dave@fedora ~]$ su -
> Password: 
> [root@fedora ~]# *ls -ld .gvfs*
> ls: cannot access /home/dave/.gvfs: Permission denied
> [root@fedora ~]# *secon*
> user: unconfined_u
> role: unconfined_r
> type: unconfined_t
> sensitivity: s0
> clearance: s0:c0.c1023
> mls-range: s0-s0:c0.c1023
> [root@fedora ~]# 

I don't think that is SELinux-related (retry after "setenforce 0" and/or
check your audit log via "/sbin/ausearch -m AVC -sv no").  Likely just
that /home/dave is NFS mounted and you have rootsquash on the NFS
server...

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
