Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m55DZQQx002858
	for <selinux@tycho.nsa.gov>; Thu, 5 Jun 2008 09:35:26 -0400
Received: from QMTA08.westchester.pa.mail.comcast.net (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m55DZQJQ015471
	for <selinux@tycho.nsa.gov>; Thu, 5 Jun 2008 13:35:26 GMT
Subject: Re:
	[PATCH]	libselinux:	add	support	for	/contexts/postgresql_contexts
From: Chris PeBenito <pebenito@gentoo.org>
To: KaiGai Kohei <kaigai@ak.jp.nec.com>
Cc: Eamon Walsh <ewalsh@tycho.nsa.gov>, Stephen Smalley <sds@tycho.nsa.gov>,
        selinux@tycho.nsa.gov
In-Reply-To: <48473ECC.6020501@ak.jp.nec.com>
References: <483A9137.5050509@ak.jp.nec.com>
	 <1211908477.19360.28.camel@moss-spartans.epoch.ncsc.mil>
	 <1211910942.5008.57.camel@gorn.columbia.tresys.com>
	 <1211913263.19360.72.camel@moss-spartans.epoch.ncsc.mil>
	 <1211914557.5008.72.camel@gorn.columbia.tresys.com>
	 <483C6BEA.8040101@tycho.nsa.gov>
	 <1211981040.5008.105.camel@gorn.columbia.tresys.com>
	 <483EF06E.7080406@tycho.nsa.gov> <1212085228.31546.5.camel@gorn>
	 <483F48AB.7030406@tycho.nsa.gov> <1212150456.31546.16.camel@gorn>
	 <4843CB24.1040000@ak.jp.nec.com>  <48442E7E.9050303@tycho.nsa.gov>
	 <1212431955.31546.94.camel@gorn>  <48451C0C.6060303@ak.jp.nec.com>
	 <1212496632.31546.105.camel@gorn.columbia.tresys.com>
	 <4846142F.8090100@ak.jp.nec.com>
	 <1212589930.4140.16.camel@gorn.columbia.tresys.com>
	 <48473ECC.6020501@ak.jp.nec.com>
Content-Type: text/plain
Date: Thu, 05 Jun 2008 09:35:16 -0400
Message-Id: <1212672916.15752.7.camel@gorn.pebenito.net>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2008-06-05 at 10:18 +0900, KaiGai Kohei wrote:
> Christopher J. PeBenito wrote:
> > On Wed, 2008-06-04 at 13:03 +0900, KaiGai Kohei wrote:
> >> Christopher J. PeBenito wrote:
> >>> On Tue, 2008-06-03 at 19:25 +0900, KaiGai Kohei wrote:
> >>>> Christopher J. PeBenito wrote:
> >>>>> I'm out of arguments; clearly I'm in the minority on this issue.  I
> >>>>> already said I wouldn't block the policy over this, so KaiGai, if you
> >>>>> would send a last patch based on the revisions I made [1], let see if we
> >>>>> can finally get this merged.
> >>>>>
> >>>>> [1] http://marc.info/?l=selinux&m=120999566809541&w=2
> >>>> I'll submit a revised version later.
> >>>> (Now we cannot update SVN repository, due to server maintenance.)
> >>>>
> >>>> Before this, I want to modify the following points:
> > 

> >> Then, the above dontaudit rule should be rewritten as follows:
> >>
> >>   dontaudit { sepgsql_client_type sepgsql_unpriv_type postgresql_t } \
> >>             { sepgsql_table_type - sepgsql_sysobj_table_type } : db_tuple *;
> >>
> >> At first, I used a boolean (sepgsql_enable_audittuple) to turn on/off
> >> tuple-level access logs, but you suggested it is unnecessary, so I removed it.
> > 
> > I don't agree because of:
> > 
> > +allow postgresql_t sepgsql_table_type:{ db_table db_column db_tuple } *;
> > +allow sepgsql_unconfined_type sepgsql_table_type:{ db_table db_column db_tuple } *;
> > 
> > so dontauditing for postgresql_t and sepgsql_unconfined_type doesn't do
> > anything since the access is allowed.
> 
> It is correct in type enforcement.
> But MCS/MLS can prevent to access by unconfined domains, and make flood of
> access denied logs.

Ok, I see your point.  Please add a comment in the policy that explains
this, so I don't mistakenly remove the dontaudit in the future :)

One thing I just realized: do we really want to dontaudit all perms?  It
seems like use and/or select might be sufficient.  Dontauditing
relabelto and relabelfrom doesn't seem like a good idea.

-- 
Chris PeBenito
<pebenito@gentoo.org>
Developer,
Hardened Gentoo Linux
 
Public Key: http://pgp.mit.edu:11371/pks/lookup?op=get&search=0xE6AF9243
Key fingerprint = B0E6 877A 883F A57A 8E6A  CB00 BC8E E42D E6AF 9243


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
