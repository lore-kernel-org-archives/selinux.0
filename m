Message-ID: <52716F8C.6060109@tycho.nsa.gov>
Date: Wed, 30 Oct 2013 16:43:56 -0400
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: Daniel J Walsh <dwalsh@redhat.com>
CC: Joshua Brindle <jbrindle@tresys.com>, SELinux <selinux@tycho.nsa.gov>
Subject: Re: Been looking at further shrinkage of the SELinux footprint on
 Linux.
References: <52715E75.5000005@redhat.com> <527168B1.4040905@tycho.nsa.gov> <52716DE6.8040401@redhat.com>
In-Reply-To: <52716DE6.8040401@redhat.com>
Content-Type: text/plain; charset=UTF-8
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 10/30/2013 04:36 PM, Daniel J Walsh wrote:
> Well we have done some work on combining like domains, see antivirus and
> spamassassin, but this is a lot of work which no one has time for.
> 
> I would love to see the mailserver and mailclients domains combined.
> 
> If people want to suggest or more importantly submit patches to combine other
> domains, I am all for it.
> 
> Problems with shipping policy within rpm still exists. although we (Red Hat)
> are at least moving toward layered products shipping their own policy.
> openstack-selinux, openshift-selinux, gluster-selinux.  This is more for them
> updating quicker then RHEL.
> 
> 1. semanage is slowwwwwwwww.  If we ran all pp files without combining them
> into a single transaction the installation  and yum updates would take a long
> time.

Yes, I have to wonder if we don't need a complete overhaul/replacement
of libsemanage (+ module portions of libsepol).  It seems like
semodule/semanage transactions are far slower than running the entire
policy through checkpolicy again (i.e. just using source modules and
running them through m4 + checkpolicy on each transaction, ala the
source policy module work that sadly has yet to reach maturity/completion).

> 2.  Cordination between domains, we put a fix into an interface and we need to
> trigger 10 packages to update.
> 
> For every apache bug in policy, do we want to wait for an update apache
> package, or do we ship lots more packages.

That's also fixed if we go with source modules, right, since interface
change would get applied by the m4 + checkpolicy cycle.  Or CIL.

> 3. Uninstall of types leaves unlabeled_t content on disk.

That's the only one that seems fundamental.  What if we pushed all file
type declarations into their own module linked to the base filesystem
package and just always installed that?  That won't affect policy size
substantially; it is the allow rules that are the issue IIUC, not just
the type decls.




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
