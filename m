Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i9EKAErT001177
	for <selinux@tycho.nsa.gov>; Thu, 14 Oct 2004 16:10:14 -0400 (EDT)
Received: from moss-lions.epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i9EK92mT005012
	for <selinux@tycho.nsa.gov>; Thu, 14 Oct 2004 20:09:02 GMT
Subject: Re: Agressive Trimming of types.fc
From: James Carter <jwcart2@epoch.ncsc.mil>
Reply-To: jwcart2@epoch.ncsc.mil
To: Thomas Bleher <bleher@informatik.uni-muenchen.de>
Cc: SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <20041011095410.GB15844@jmh.mhn.de>
References: <1097177305.8508.49.camel@moss-lions.epoch.ncsc.mil>
	 <20041011095410.GB15844@jmh.mhn.de>
Content-Type: text/plain
Message-Id: <1097784551.32077.76.camel@moss-lions.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Thu, 14 Oct 2004 16:09:11 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Thanks for the comments.

I added a rule to label /usr/include as usr_t.  (actually /usr/inclu.e
because of m4)

I added a rule to label the /opt stuff as var_lib_t, since it seems to
be the same stuff that is in /var/lib/ on Fedora.

It is in CVS now.

On Mon, 2004-10-11 at 05:54, Thomas Bleher wrote:
> * James Carter <jwcart2@epoch.ncsc.mil> [2004-10-07 22:53]:
> > Attached is an aggressive trimming of types.fc.  
> > 
> >  types.fc |  104
> > ++++++---------------------------------------------------------
> >  1 files changed, 11 insertions(+), 93 deletions(-)
> > 
> > I am trying to make things a little easier to maintain and a little more
> > flexible (to avoid the "it's i686 not i386" issues).  Please let me know
> > what you think.
> > 
> > This patch uses more generalized rules in labeling the following:
> > 	lib_t and shlib_t in /opt
> > 	lib_t, shlib_t, and ld_so_t in /lib(64)?
> > 	lib_t, shlib_t, ld_so_t, bin_t, and sbin_t in /usr
> 
> It looks nice from a SuSE POV, except for two small points:
> 
> /usr/sbin/setfiles:  relabeling /usr/include/pgsql/internal/lib from system_u:object_r:usr_t to system_u:object_r:lib_t
> /usr/sbin/setfiles:  relabeling /usr/include/pgsql/internal/lib/dllist.h from system_u:object_r:usr_t to system_u:object_r:lib_t
> /usr/sbin/setfiles:  relabeling /usr/include/pgsql/server/lib from system_u:object_r:usr_t to system_u:object_r:lib_t
> /usr/sbin/setfiles:  relabeling /usr/include/pgsql/server/lib/stringinfo.h from system_u:object_r:usr_t to system_u:object_r:lib_t
> /usr/sbin/setfiles:  relabeling /usr/include/pgsql/server/lib/dllist.h from system_u:object_r:usr_t to system_u:object_r:lib_t
> /usr/sbin/setfiles:  relabeling /usr/include/pgsql/server/lib/lispsort.h from system_u:object_r:usr_t to system_u:object_r:lib_t
> 
> I think everything under /usr/include should be labeled usr_t.
> I do not really know how to fix this cleanly, but I don't think it's a
> very big deal.
> 
> /usr/sbin/setfiles:  relabeling /opt/gnome2.8/var/lib from system_u:object_r:usr_t to system_u:object_r:lib_t
> /usr/sbin/setfiles:  relabeling /opt/gnome2.8/var/lib/scrollkeeper from system_u:object_r:usr_t to system_u:object_r:lib_t
> /usr/sbin/setfiles:  relabeling /opt/gnome2.8/var/lib/scrollkeeper/C from system_u:object_r:usr_t to system_u:object_r:lib_t
> /usr/sbin/setfiles:  relabeling /opt/gnome2.8/var/lib/scrollkeeper/C/scrollkeeper_cl.xml from system_u:object_r:usr_t to system_u:object_r:lib_t
> [and so on]
> 
> Should these be labeled var_lib_t?
> 
> Otherwise the patch looks good and also fixes a few wrong labelings, so
> it should definitely be included into cvs.
> 
> Thomas
-- 
James Carter <jwcart2@epoch.ncsc.mil>
National Security Agency

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
