From: =?utf-8?q?T=C3=B6r=C3=B6k_Edwin?= <edwin@gurde.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: Labeling only policy and problems with booleans
Date: Thu, 27 Apr 2006 22:17:54 +0300
Cc: Joshua Brindle <jbrindle@tresys.com>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>,
        selinux@tycho.nsa.gov, fireflier-devel@lists.sourceforge.net
References: <200604021240.21290.edwin@gurde.com> <200604262113.01211.edwin@gurde.com> <1146079604.28745.183.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1146079604.28745.183.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200604272217.54944.edwin@gurde.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wednesday 26 April 2006 22:26, Stephen Smalley wrote:
> sediff of these two policies shows a _lot_ of differences, including 107
> added types in the "bad" policy.  Are you sure they are identical except
> for linking unconfined?  What is in that module (source)?
>
> I do see an allow unconfined_t security_t:security load_policy under a
> different boolean in the "bad" policy; looks like a boolean mapping
> problem at link time.  We did see those when the optionals-in-base
> support was first merged, so the Debian checkpolicy might have an issue
> there, but that should have been resolved in 1.30.3 or newer, built
> against libsepol 1.12.3 or newer.
>
I rebuilt the policy under FC5, with checkpolicy 1.30.3, and 
libsepol-1.12.4-1.fc5, checkpolicy-1.30.3-1.fc5, here it is
http://edwintorok.googlepages.com/policy.20.
Using sediff shows almost no difference to the bad policy (some te rules I 
removed, since they violated assertions), and the same 100+ differences to 
the good policy.
Looking at this line:
F               + allow unconfined_t security_t : security { compute_member 
compute_user compute_create setenforce check_context setcheckreqprot 
compute_relabel setbool load_policy setsecparam compute_av }; [ allow_execmem 
allow_execstack &&  ]

I tried setting allow_execmem and allow_execstack to true, and then I couldn't 
load policy anymore. Clearly, at linktime secure_mode_policyload was mapped 
to allow_execmem && allow_execstack. 
And AFAICT this bug it is still present in the latest checkpolicy+libsepol.

Is there a bugtracker for selinux?

(you said that  a bug like this has been fixed, do you recall where that patch 
is?, it might be a good starting point on fixing this issue)

Edwin

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
