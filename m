Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id nB9Lk1OT020484
	for <selinux@tycho.nsa.gov>; Wed, 9 Dec 2009 16:46:01 -0500
Received: from g1t0026.austin.hp.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id nB9LmI6g021029
	for <selinux@tycho.nsa.gov>; Wed, 9 Dec 2009 21:48:19 GMT
From: Paul Moore <paul.moore@hp.com>
To: russell@coker.com.au
Subject: Re: tun/tap and SE Linux in 2.6.32
Date: Wed, 9 Dec 2009 16:45:46 -0500
Cc: Stephen Smalley <sds@epoch.ncsc.mil>, "SE-Linux" <selinux@tycho.nsa.gov>
References: <200912091232.26387.russell@coker.com.au> <200912091548.03369.paul.moore@hp.com> <200912100756.24553.russell@coker.com.au>
In-Reply-To: <200912100756.24553.russell@coker.com.au>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <200912091645.46800.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wednesday 09 December 2009 03:56:22 pm Russell Coker wrote:
> On Thu, 10 Dec 2009, Paul Moore <paul.moore@hp.com> wrote:
> > > Subject: selinux PERMISSIVE blocking tun/tap device creation in v2.6.32
> >
> > I imagine this is because the original reporter is using a SELinux policy
> > without the new TUN socket classes/permissions (which is likely the
> > common case at this point).  The unknown class/permission handling that
> > Eric added _should_ protect us from this - Russel do you have any more
> > information about the distribution and policy in use here?
> 
> Sorry, the original message apparently wasn't clear enough (I've added some
> caps).
> 
> The problem occurred in permissive mode.  When the system is in permissive
> mode then SE Linux should not deny any action that Unix permissions will
> permit.

Yes, I agree.  The avc_has_perm_noaudit() function, which is called by 
avc_has_perm(), checks to see if the system is in enforcing or permissive mode 
and does the right thing ... except for one case that I can see, the case 
where security_compute_av() returns an error/non-zero value.

Looking at security_compute_av() there is definitely code that will return an 
error, even the EINVAL that was reported, but it would appear to only be 
possible if the allow unknown classes/permissions flag was set to "no".  Could 
you please verify with the original reporter that this is the case?  It would 
also be interesting to see which distribution is shipping policy that has this 
flag set to "no".

        requested = unmap_perm(orig_tclass, orig_requested);
        tclass = unmap_class(orig_tclass);
        if (unlikely(orig_tclass && !tclass)) {
                if (policydb.allow_unknown)
                        goto allow;
                rc = -EINVAL;
                goto out;
        }

As for fixing this, there are a few options that I can think of, one of which 
is to change avc_has_perm_noaudit() so that it does not return a error code, 
only access denials.


-- 
paul moore
linux @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
