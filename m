From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: sds@tycho.nsa.gov
Subject: Re: MCS and unconfined_t
Date: Wed, 29 Mar 2006 11:36:51 +1100
Cc: KaiGai Kohei <kaigai@kaigai.gr.jp>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>,
        James Morris <jmorris@redhat.com>, Daniel J Walsh <dwalsh@redhat.com>,
        selinux@tycho.nsa.gov
References: <442933AD.3040208@kaigai.gr.jp> <1143581268.3037.149.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1143581268.3037.149.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200603291136.58087.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wednesday 29 March 2006 08:27, Stephen Smalley <sds@tycho.nsa.gov> wrote:
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

The problem we have is that we want su(1) to allow changing to the SE Linux 
context of the new user with the appropriate MCS categories.  To do this we 
need to have su run in it's own domain so that it is permitted to increase 
the categories while the unconfined_t domain isn't.  I plan to release this 
as an FC5 update.

For the moment KaiGai Kohei is correct and there is no way to effectively 
constrain unconfined_t.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
