From: Paul Moore <paul.moore@hp.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: [RFC PATCH v1] selinux: Fix security_compute_av() to not return unknown class errors when in permissive mode
Date: Mon, 14 Dec 2009 17:22:07 -0500
Cc: selinux@tycho.nsa.gov, russell@coker.com.au, amworsley@gmail.com
References: <20091211214213.5420.59860.stgit@flek.lan> <1260568759.26597.163.camel@moss-pluto.epoch.ncsc.mil>
In-Reply-To: <1260568759.26597.163.camel@moss-pluto.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Message-Id: <200912141722.07456.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Friday 11 December 2009 04:59:19 pm Stephen Smalley wrote:
> ... For example, I don't really think sidtab_search() can ever fail anymore
> (it falls back to the unlabeled SID, which has to be defined by the initial
> policy load) ...

I just spent a bit of time looking at the policy loading code and can't seem 
to find where it is enforced that there must be an initial SID for the 
unlabeled case.  I don't doubt that it is there, but I just spent an hour 
staring at the policydb code and I can't seem to find it ... care to toss a 
pointer my way :)

-- 
paul moore
linux @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
