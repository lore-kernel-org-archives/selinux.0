Subject: Re: [RFC PATCH v1] selinux: Fix security_compute_av() to not
 return unknown class errors when in permissive mode
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Paul Moore <paul.moore@hp.com>
Cc: selinux@tycho.nsa.gov, russell@coker.com.au, amworsley@gmail.com
In-Reply-To: <200912141722.07456.paul.moore@hp.com>
References: <20091211214213.5420.59860.stgit@flek.lan>
	 <1260568759.26597.163.camel@moss-pluto.epoch.ncsc.mil>
	 <200912141722.07456.paul.moore@hp.com>
Content-Type: text/plain
Date: Wed, 16 Dec 2009 09:59:55 -0500
Message-Id: <1260975595.19290.9.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2009-12-14 at 17:22 -0500, Paul Moore wrote:
> On Friday 11 December 2009 04:59:19 pm Stephen Smalley wrote:
> > ... For example, I don't really think sidtab_search() can ever fail anymore
> > (it falls back to the unlabeled SID, which has to be defined by the initial
> > policy load) ...
> 
> I just spent a bit of time looking at the policy loading code and can't seem 
> to find where it is enforced that there must be an initial SID for the 
> unlabeled case.  I don't doubt that it is there, but I just spent an hour 
> staring at the policydb code and I can't seem to find it ... care to toss a 
> pointer my way :)

Hmmm...I think you are correct, although the system would not work very
well if you did in fact omit such a definition from the policy.  Initial
SIDs handling needs an overhaul, that's already noted on the todo list.

So I guess sidtab_search() can possibly fail still, although it won't
with any correctly configured policy.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
