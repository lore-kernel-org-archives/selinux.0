Subject: Re: MCS and unconfined_t
From: Stephen Smalley <sds@tycho.nsa.gov>
Reply-To: sds@tycho.nsa.gov
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
Cc: KaiGai Kohei <kaigai@kaigai.gr.jp>, Russell Coker <russell@coker.com.au>,
        James Morris <jmorris@redhat.com>, Daniel J Walsh <dwalsh@redhat.com>,
        selinux@tycho.nsa.gov
In-Reply-To: <1143649773.13732.30.camel@sgc.columbia.tresys.com>
References: <442933AD.3040208@kaigai.gr.jp>
	 <1143581268.3037.149.camel@moss-spartans.epoch.ncsc.mil>
	 <1143649773.13732.30.camel@sgc.columbia.tresys.com>
Content-Type: text/plain
Date: Wed, 29 Mar 2006 11:45:40 -0500
Message-Id: <1143650740.24555.5.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2006-03-29 at 11:29 -0500, Christopher J. PeBenito wrote:
> My issue with that patch was that it had types hardcoded into the
> constraints, violating encapsulation.  In the interim other parts of the
> patch were fixed and resubmitted, but this piece got lost along the way.
> I've committed it, using an attribute and an interface.

Ok, but it seems like something still isn't quite conceptually here in
MCS - pam_selinux was removed from su, so su isn't supposed to switch
levels, yet running su on FC5 does change to a fully ranged context,
presumably via range_transition.  Which makes no sense to me at all
given the intent of MCS.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
