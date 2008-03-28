Subject: Re: policy package names for Debian
From: Stephen Smalley <sds@tycho.nsa.gov>
To: russell@coker.com.au
Cc: Manoj Srivastava <srivasta@debian.org>,
        "SE-Linux," <selinux@tycho.nsa.gov>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>,
        Daniel J Walsh <dwalsh@redhat.com>
In-Reply-To: <200803281340.01991.russell@coker.com.au>
References: <200803281340.01991.russell@coker.com.au>
Content-Type: text/plain
Date: Fri, 28 Mar 2008 08:26:58 -0400
Message-Id: <1206707218.3302.393.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Fri, 2008-03-28 at 13:40 +1100, Russell Coker wrote:
> The policy names used in Fedora/RHEL (according to the SELINUXTYPE field 
> in /etc/selinux/config) are "targeted", "strict", and "mls".
> 
> The names currently used in Debian are "refpolicy-targeted" 
> and "refpolicy-strict".  For my work on MLS in Debian I have started with a 
> package named "refpolicy-mls" (but hope to release it just as "mls").
> 
> I believe that the contents of /etc/selinux/config should match between 
> distributions as much as possible.  It would be good if documentation for how 
> to solve problems on Fedora would work for people using Debian.
> 
> Also the "refpolicy" part of the name doesn't seem to add any value.  Policy 
> other than "refpolicy" is old and forgotten, and more importantly there is no 
> possibility of switching between them.  If a user could choose to have 
> either "refpolicy-targeted" or the old "targeted" then that would be a good 
> reason for having the different name.  But as they have no choice it seems 
> better to have shorter names everywhere (both in the config file and in the 
> package name).
> 
> pn  postfix-policy <none>         (no description available)
> un  selinux-policy <none>         (no description available)
> ii  selinux-policy 0.0.20061018-5 Headers from the SELinux reference policy fo
> pn  selinux-policy <none>         (no description available)
> pn  selinux-policy <none>         (no description available)
> pn  selinux-policy <none>         (no description available)
> ii  selinux-policy 0.0.20061018-5 Targeted variant of the SELinux reference po
> 
> The package name "selinux-policy-refpolicy-targeted" is unreasonably long to 
> type and is too long to be usable in a default operation of "dpkg -l" (see 
> the above output from "dpkg -l" on an 80 column xterm).
> 
> Manoj, I suggest that we change the package names to selinux-pol-targeted, 
> selinux-pol-strict, and selinux-pol-mls.  That saves typing and results in 
> the above dpkg command giving useful data.

If you are seeking consistency with Fedora, then note that it calls the
packages selinux-policy-targeted and selinux-policy-mls. The
selinux-policy-strict package is gone as of Fedora 8 and later,
obsoleted by the merge of strict and targeted policies (now one just
maps users to confined roles via semanage login and if one truly doesn't
want to leave anything unconfined at all, one can semodule -r
unconfined).

Also, there is a selinux-policy-devel package in Fedora that has what is
needed to build local policy modules.

If on the other hand you want to track the names used by upstream
refpolicy these days, then those would be standard, mcs, and mls.  The
old strict/targeted distinction is no longer there either, so the only
real distinctions are whether you have a policy with MLS field/logic
completely disabled (standard), enabled and used for MCS (mcs) or
enabled and used for MLS (mls).

BTW, recently noticed that semanage user -a is broken under standard
(non-mcs/mls) policy as there is a hardcoded :s0 in seobject.py on a
prefix context check - so that needs to be resolved.  Or we just need to
give up on non-mcs/mls policies altogether (that would simplify life for
applications and users - a single format for all contexts).

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
