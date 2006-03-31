From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
Subject: Re: MCS and unconfined_t
Date: Sat, 1 Apr 2006 01:55:16 +1100
Cc: sds@tycho.nsa.gov, KaiGai Kohei <kaigai@kaigai.gr.jp>,
        James Morris <jmorris@redhat.com>, Daniel J Walsh <dwalsh@redhat.com>,
        selinux@tycho.nsa.gov
References: <442933AD.3040208@kaigai.gr.jp> <1143581268.3037.149.camel@moss-spartans.epoch.ncsc.mil> <1143649773.13732.30.camel@sgc.columbia.tresys.com>
In-Reply-To: <1143649773.13732.30.camel@sgc.columbia.tresys.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200604010155.22827.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thursday 30 March 2006 03:29, "Christopher J. PeBenito" 
<cpebenito@tresys.com> wrote:
> > Hmmm...I had thought that Russell had introduced a mlsconstraint on
> > process transition and dyntransition permissions in policy/mcs, see the
> > earlier discussion on list in Feb.  But it appears to be missing from
> > the current policy, which does mean that an unconfined process can
> > easily escape its restrictions via runcon or newrole -l.  Seems to be
> > missing in FC5 too.
>
> My issue with that patch was that it had types hardcoded into the
> constraints, violating encapsulation.  In the interim other parts of the
> patch were fixed and resubmitted, but this piece got lost along the way.
> I've committed it, using an attribute and an interface.

http://people.redhat.com/rcoker/pol/

At the above URL I've put some packages for rawhide that fix this issue and a 
few other things.

Among the changes is the change to file contexts to separate /usr(/.*)? 
into /usr -d and /usr/.* etc.  This causes a relabel of most of the system on 
package install (so I'm not planning to put it in FC5), but gives a small 
performance increase on setfiles/restorecon etc once it's in place.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
