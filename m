Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k5SKMOFF015063
	for <selinux@tycho.nsa.gov>; Wed, 28 Jun 2006 16:22:24 -0400
Received: from fsjrez04.rome.afmc.ds.af.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k5SKMNUU018419
	for <selinux@tycho.nsa.gov>; Wed, 28 Jun 2006 20:22:23 GMT
Message-ID: <43055FDD054D464FA7923D0FFAF2C9C70291F7C2@fsjrez02.adm.rl.af.mil>
From: "Wightman, Reid K Civ AFRL/IFEB" <Reid.Wightman@rl.af.mil>
To: selinux@tycho.nsa.gov, redhat-lspp@redhat.com
Subject: libselinux get_default_context not working?
Date: Wed, 28 Jun 2006 16:07:06 -0400
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov



Infinite apologies if this posts twice.  *grumbles something about
MS-Exchange not being the best MTA*

I'm playing with the refpolicy (20060307 from sourceforge...is there a
redhat-blessed version of refpolicy w/source available?) and am noticing
some odd things in libselinux.  When calling get_default_context('user_u',
NULL, &conref), the function eventually gets to get_context_list.c line 444
where it tries to open /etc/selinux/refpolicy/contexts/users/user_u .  That
file doesn't exist.  

I'm curious what the format of the file should be.  I don't see anything by
the same name in the targeted or strict policies that come with FC5.  As it
is, it eventually fails to order the reachable list it builds, so user_u is
shown as having a default context of user_u:user_r:user_xserver_t, which
probably isn't right, (it just happens to be the first entry on the
reachable contexts list).  I'd think the default context for user_u in the
default refpolicy would be user_u:user_r:user_t...

Would it be worthwhile for me to play with the Makefile to automatically
generate some of these files?  What stuff should the <user>_u files have in
them?  Or shouldn't I be playing with refpolicy for policy analysis at this
point (or, as above, is there a redhat version somewhere)?  I don't see a
'user_u' file in targeted o
r strict policies, either, so I'd guess that this same sort of thing would
happen in them?

Thanks,
Reid
--
()  ascii ribbon campaign - against html mail 
/\                        - against proprietary attachments

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
