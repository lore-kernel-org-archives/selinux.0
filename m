Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i72EfRrT012842
	for <selinux@tycho.nsa.gov>; Mon, 2 Aug 2004 10:41:27 -0400 (EDT)
Received: from moss-huskies.epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i72EetXV024523
	for <selinux@tycho.nsa.gov>; Mon, 2 Aug 2004 14:40:55 GMT
Received: from moss-huskies.epoch.ncsc.mil (localhost.localdomain [127.0.0.1])
	by moss-huskies.epoch.ncsc.mil (8.12.8/8.12.8) with ESMTP id i72EfEJQ032460
	for <selinux@tycho.nsa.gov>; Mon, 2 Aug 2004 10:41:14 -0400
Received: (from hdholm@localhost)
	by moss-huskies.epoch.ncsc.mil (8.12.8/8.12.8/Submit) id i72EfEXP032458
	for selinux@tycho.nsa.gov; Mon, 2 Aug 2004 10:41:14 -0400
Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i71KGerT008452
	for <selinux@tycho.nsa.gov>; Sun, 1 Aug 2004 16:16:40 -0400 (EDT)
Received: from smtp803.mail.ukl.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with SMTP id i71KG852027668
	for <selinux@tycho.nsa.gov>; Sun, 1 Aug 2004 20:16:08 GMT
Received: from unknown (HELO hyd) (selinux@tycho.nsa.gov@81.152.10.162 with poptime)
  by smtp803.mail.ukl.yahoo.com with SMTP; 1 Aug 2004 20:16:36 -0000
Date: Sun, 1 Aug 2004 21:27:40 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Erich Schubert <erich@vitavonni.de>
Cc: SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: user-directory _is_ home directory
Message-ID: <20040801202740.GG20103@lkcl.net>
References: <20040801143236.GA15949@lkcl.net> <1091388560.7861.7.camel@wintermute.xmldesign.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1091388560.7861.7.camel@wintermute.xmldesign.de>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, Aug 01, 2004 at 09:29:20PM +0200, Erich Schubert wrote:
> Hi,
> 
> > my question is: does anyone have any recommendations on how to deal
> > with /home being a mount point, and also being a user's home directory.
> 
> why would you want to do so?

 this is almost entirely off-topic, but i'm explaining it in case anyone
 who would otherwise be discouraged from answering if they didn't feel
 that there was a reasonable justification for removing /home/XXXX.

 background:

 there is only one user: they do not have a password, they will not
 be given a password.  they will not be given the root password, they
 will most likely not know what a root password _is_, the target users
 are in fact extremely unlikely to CARE about passwords [which is the
 whole reason why i'm using selinux, because such people are scarey]

 i'm installing usb-mount and autofs with --timeout 5 and
 integrating the two so that they don't have to deal with
 umount.  this is for people who don't know what umount is,
 and don't really care, but _do_ care about their files getting
 corrupted on their usb memory cards and usb floppy drives.

 answer:

 in kde's devices, the user is presented with /boot, /usr, /var, / and
 /home.

 none of these things are in the SLIGHTEST bit useful to a user that
 doesn't know and doesn't care, and i wish there was a way to damn well
 get rid of them ALL from konqueror.

 in order to minimise the amount of impact on such users - think c:\ - 
 i decided to get rid of the concept of /home/XXXX.

 after all, if there's only one user (with no password), what's the point?

 so, if i create a /MyDocuments and symlink it to
 /home/theoneandonlyuser, then that STILL leaves them with
 /home/theoneandonlyuser in the kde devices's list.
 
 l.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
