Subject: Re: MCS and unconfined_t
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: sds@tycho.nsa.gov
Cc: KaiGai Kohei <kaigai@kaigai.gr.jp>, Russell Coker <russell@coker.com.au>,
        James Morris <jmorris@redhat.com>, Daniel J Walsh <dwalsh@redhat.com>,
        selinux@tycho.nsa.gov
In-Reply-To: <1143581268.3037.149.camel@moss-spartans.epoch.ncsc.mil>
References: <442933AD.3040208@kaigai.gr.jp>
	 <1143581268.3037.149.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Wed, 29 Mar 2006 11:29:33 -0500
Message-Id: <1143649773.13732.30.camel@sgc.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2006-03-28 at 16:27 -0500, Stephen Smalley wrote:
> On Tue, 2006-03-28 at 22:01 +0900, KaiGai Kohei wrote:
> > Today, I'm considering an configuration for Fedora core 5 using MCS.
> > 
> > Some users are associated with restricted category 'c0,c1' at most.
> > If user field in security context would not change, they cannot
> > transit to wider range of categories.
> > 
> > But they can login with unconfined_t domain in default.
> > Because unconfined_t domain has 'execcon' permission, they can
> > transit to discretional range of categories by re-writing the
> > user field in security context.
> > 
> > Is it possible to control the unconfined_t processes by MCS ?
> > It seems a bit difficult.
> > Please notice me, if I have misunderstanding or misconfiguration.
> 
> Hmmm...I had thought that Russell had introduced a mlsconstraint on
> process transition and dyntransition permissions in policy/mcs, see the
> earlier discussion on list in Feb.  But it appears to be missing from
> the current policy, which does mean that an unconfined process can
> easily escape its restrictions via runcon or newrole -l.  Seems to be
> missing in FC5 too.

My issue with that patch was that it had types hardcoded into the
constraints, violating encapsulation.  In the interim other parts of the
patch were fixed and resubmitted, but this piece got lost along the way.
I've committed it, using an attribute and an interface.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
