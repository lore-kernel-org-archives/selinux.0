Subject: Re: vserver and vprocunhide
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Daniel Gil Mayol <Daniel.Gil-Mayol@brunel.de>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <200610251033.18810.Daniel.Gil-Mayol@brunel.de>
References: <200610231751.50609.Daniel.Gil-Mayol@brunel.de>
	 <200610240847.58333.Daniel.Gil-Mayol@brunel.de>
	 <1161705205.3987.88.camel@moss-spartans.epoch.ncsc.mil>
	 <200610251033.18810.Daniel.Gil-Mayol@brunel.de>
Content-Type: text/plain
Date: Wed, 25 Oct 2006 09:07:18 -0400
Message-Id: <1161781638.3987.256.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2006-10-25 at 10:33 +0200, Daniel Gil Mayol wrote:
> > > I want to unhide /proc/1 because seems that vserver try to access there:
> >
> > That isn't clear.  IIUC, you are getting these denials because you are
> > trying to unhide /proc/1, not the other way around.  
> 
> But the "denied messages" I sent you before, are reported before I try to 
> unhide the /proc/1.

Then let's focus first on just addressing the avc messages, not on
vprocunhide.

> > Where does this process run?  On the "base" system or 
> > within each vserver instance?
> 
> Do you mean vserver_ids? I think within each vserver.

Are you sure?  Please verify.  What is its purpose?  Why would you run
an IDS within each vserver instance, where it can be compromised by a
process within that vserver instance, vs. running it in the "host
context" protected from the vserver instances aka "guests"?

> > No, you wouldn't relabel the /proc/1 files; you would define a domain
> > transition for init in your policy and then init would automatically run
> > in init_t, and the /proc/1 files would automatically inherit that
> > domain.  This is already done in strict policy, as well as in newer
> > targeted policies in Fedora Core.
> 
> I wrote the following:
>      domain_auto_trans(init_t, vserver_ids_exec_t, vserver_ids_t);

That is a transition from init_t to vserver_ids_t upon executing a file
labeled vserver_ids_exec_t.  But nothing is yet running in init_t, so
the rule achieves nothing by itself.

Before playing with an init_t domain, let's just make sure we understand
what is going on here and what is truly required.  See my questions
above about vserver_ids_t.

> and I am still receiving the same:
> 
> Oct 25 09:18:06 cnsu kernel: audit(1161767886.890:1510): avc:  denied  
> { search } for  pid=3322 comm="pidof" name="1" dev=proc ino=65538 
> scontext=root:system_r:vserver_ids_t tcontext=user_u:system_r:unconfined_t 
> tclass=dir

Ok, so you know of at least one way to address this, by adding an allow
rule and adjusting the neverallow rule to permit it.  Another way is to
not allow it but suppress the audit message via a dontaudit rule (same
syntax as the allow rule); that is appropriate if the access is not
truly required for the functioning of the vserver daemon.  

> The second "allow" was in my policy, I have added the first (audit_write) and 
> I see the same message:
> 
> Oct 25 07:57:27 cnsu dbus: Can't send to audit system: USER_AVC pid=26679 
> uid=81 loginuid=-1 message=avc:  0 AV entries and 0/512 buckets used, 
> longestchain length 0

Ok, I'm not sure about the cause then.  It isn't critical.

> I am trying to understand the "denied messages" to avoid to use allow with 
> unconfined. For example the following:

Allowing unconfined_t to do things is ok; it is supposed to be
unrestricted (and usually this happens automatically when you use the
right type attributes on any new types you define, like the "file_type"
attribute for file types and the "domain" attribute for domains).
Allowing other domains to access unconfined_t is the concern.

> Oct 25 08:02:37 cnsu kernel: audit(1161763357.211:1434): avc:  denied  
> { search } for  pid=30655 comm="ls" name="util-vserver" dev=hda5 ino=208827 
> scontext=root:system_r:unconfined_t 
> tcontext=system_u:object_r:vserver_utils_t tclass=dir

If you install the "audit" package and run auditd, then you can also get
syscall audit records with more information, like the full pathname.
Note that when auditd is running, both the avc messages and the syscall
audit records will be logged to /var/log/audit/audit.log instead
of /var/log/messages.

> In the first denied, ino=208827 is a node that, after execute "find / -inum 
> 208827" I see that corresponds with the following 
> directory: /usr/lib/util-vserver that is labelled with 
> "system_u:object_r:vserver_utils_t", it is not unconfined. So, the denied 
> message says the process with pid 30655 (that I don't know who is it because 
> when I execute "ps -e | grep 30655" nothing appears) from the unconfined 
> domain, executes "ls" over the directory "/usr/lib/util-vserver" and have not 
> the rights to search in directories labelled with vserver_utils_t. Did I 
> interpretate right the denied?

Yes.

>  What can I do to avoid this denied without 
> write:
>     allow unconfined_t vserver_utils_t:dir { search };
>     allow unconfined_t vserver_utils_t:file { getattr }

Declare vserver_utils_t as having the file_type attribute, and it will
be automatically picked up by allow rules on that attribute.  Or if you
don't want to allow it and don't want to see audit messages about it,
define dontaudit rules.

> Something that for me is strange is that the "find -inum NUMBER" sometimes 
> reports me more than one files/directories for the same ino number, can that 
> happen?

Yes; inode numbers are per-filesystem.  That is why the avc message also
includes the dev= information.  

> Another thing that I don't understand is, why the unconfined domain ask for 
> some new permissions like:
>      allow unconfined_t crontab_exec_t:file getattr;
> I thought unconfined is free to do everything.

SELinux has no intrinsic definition of unconfined, so everything must be
explicitly allowed.  But this is usually handled transparently by using
type attributes, and then defining allow rules on those type attributes
for unconfined_t such that it picks up access to everything with those
attributes.  So if you had defined crontab_exec_t as:
	type crontab_exec_t, file_type;
or equivalently:
	type crontab_exec_t;
	typeattribute crontab_exec_t file_type;
then the existing allow rule between unconfined_t and file_type would
have picked up this access.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
