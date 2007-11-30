From: Paul Moore <paul.moore@hp.com>
To: Joshua Brindle <method@manicmethod.com>
Subject: Re: PATCH: peersid capability support
Date: Fri, 30 Nov 2007 11:19:51 -0500
Cc: Stephen Smalley <sds@tycho.nsa.gov>, tmiller@tresys.com,
        selinux@tycho.nsa.gov
References: <200711291927.lATJRixF021978@rawhidevm-targeted.columbia.tresys.com> <200711301044.16726.paul.moore@hp.com> <47503412.20007@manicmethod.com>
In-Reply-To: <47503412.20007@manicmethod.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200711301119.51954.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Friday 30 November 2007 11:02:26 am Joshua Brindle wrote:
> Paul Moore wrote:
> > On Friday 30 November 2007 10:31:57 am Joshua Brindle wrote:
> >> Equivalence between every module? I don't see how this would possibly
> >> work in practice, how would audit2allow know what caps to include when
> >> it creates a new module? How would support for new caps come from a
> >> policy upgrade when there are local modules present that don't have
> >> them?
> >
> > I know this is more work both in the code as well as for policy writers,
> > but how about two policy bitmaps for each module: one bitmap (call this
> > bitmap A) indicates the capabilities that the module is knows about (i.e.
> > the policy capabilities that were defined when the module was written)
> > and one bitmap (call this bitmap B) to signal which capabilities should
> > be toggled on?  This way when you load/link/install a series of policy
> > modules you can check to make sure that the union of all the B bitmaps is
> > a subset of the intersection of all the A bitmaps.  If this is not the
> > case you can print an error and refuse to load the module, or load it
> > with the offending capability turned off.
>
> I think this is way too complicated from a user point of view.

I won't argue that it isn't more complicated than the other options presented 
so far ...

> I don't want users to 1) have to know capabilities that have nothing to do
> with their module

It's probably worth trying to better define "user" in this case.  Are you 
talking about the policy writer who is creating the module or the sysadmin 
trying to load the module?

> 2) disable all caps by not including any in a module and potentially
> hose their system. 

Wait a minute here, you'll have to explain this for me because I don't see how 
you jumped to that conclusion, I never said to disable all capabilities.  
Here is my thinking ...

1. System has policy installed and is working, or "not hosed"
2. Sysadmin tries to load new policy module which introduces a new capability 
which is not known/understood by all of the currently loaded modules, we can 
either:
2a. Fail to load the module and have the sysadmin report the problem, system 
continues without new policy, still "not hosed"
2b. Allow a forced load of the new module with the new capability disabled, 
the new module may not work correctly but hey we warned you ... 
potential "hosing" but should be easily repaired on the fly by removing the 
module

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
