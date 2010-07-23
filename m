Subject: Re: This is my first patch for systemd
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Kyle Moffett <kyle@moffetthome.net>
Cc: Daniel J Walsh <dwalsh@redhat.com>, SELinux <selinux@tycho.nsa.gov>,
        Eric Paris <eparis@parisplace.org>
In-Reply-To: <AANLkTinBsvbjKR4RnRc7NkWUsHRFqVSw7haMnYyR=-mL@mail.gmail.com>
References: <4C4837F2.1070806@redhat.com>
	 <AANLkTinBsvbjKR4RnRc7NkWUsHRFqVSw7haMnYyR=-mL@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 23 Jul 2010 16:05:03 -0400
Message-ID: <1279915503.32473.18.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2010-07-22 at 22:33 -0400, Kyle Moffett wrote:
> On Thu, Jul 22, 2010 at 08:22, Daniel J Walsh <dwalsh@redhat.com> wrote:
> > The patch does not handle, systemd creating the directories for the
> > fifo_file.  In the future, their is talk of making /var/run a tmpfs file
> > system.  This would mean systemd would create /var/run/mysqld/ before
> > creating /var/run/mysqld/mysqld.socket.  Additional SELinux controls
> > would have to be added to systemd to get this correct.  Not sure if the
> > correct thing to do is at selabel or use
> > selinux_getfileconfrompath(daemon, parentdir, "dir")
> 
> Hmm, one thing that I've been thinking about for a while now is a
> policy extension to type transitions allowing a match against the
> object name.
> 
> So for example, assuming /var/run gets correctly labelled as var_run_t:
> 
> typename_transition systemd_t var_run_t:file "mysqld" mysql_var_run_t;
> 
> If some form of globbing or patterns was added, this could in theory
> even replace the current file_contexts file with a big list of
> named_type_transitions in the policy.  Admittedly it could potentially
> make the policy larger, but I believe with careful encoding and
> compression it would be a net reduction in the size of
> /etc/selinux/$POLICYNAME/ (since the plain-text highly-repetitive
> file_contexts would go away).

I don't think so.  The file_contexts configuration is for the initial
assignment of filesystem labeling state by userspace, not for
determining how files are labeled at runtime.  The file_contexts
configuration would still be needed for applications like rpm and
install in order to determine the right security context, even with an
extended type_transition construct.  So this would not eliminate the
need for file_contexts.

We did previously discuss enabling type_transition rules to match on
last component name, but the initial forays on linux-fsdevel on the
necessary changes to pass down the name to the right function were shot
down by the vfs folks IIRC.

restorecond is your best bet if you can't make use of the existing type
transition rules.

> There are a few limitations that I can think of, though:
> 
>  * You could only match on whatever "name" field is available in the
> security manager, not the full path, although with proper labels on
> most of the path components this is not really an issue.
> 
>  * Since the name matching would need to be performed in the kernel,
> there would be a very strict limit on the complexity of the pattern or
> glob engine (probably NOT a bad thing :-D)
> 
> As an example of where this would be useful, you could automatically
> assign separate labels to ".htpasswd" and ".htaccess" files created in
> www-data directories to prevent compromised web applications from
> creating, modifying, or even reading them.
> 
> Cheers,
> Kyle Moffett

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
