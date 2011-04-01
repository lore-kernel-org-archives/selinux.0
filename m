Subject: Re: How to make restorecon/matchpathcon recognize role_transition
 rule for non-process classes?
From: Stephen Smalley <sds@tycho.nsa.gov>
To: HarryCiao <harrytaurus2002@hotmail.com>
Cc: selinux-mailing-list <selinux@tycho.nsa.gov>
In-Reply-To: <SNT139-w6155F82B0FEDA03D69574CABBE0@phx.gbl>
References: <SNT139-w6155F82B0FEDA03D69574CABBE0@phx.gbl>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 01 Apr 2011 08:42:42 -0400
Message-ID: <1301661762.28661.7.camel@moss-pluto>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2011-04-01 at 09:12 +0000, HarryCiao wrote:
> Hi,
> 
> If we adopt role_transition rules for non-process classes then how we
> could have restorecon or matchpathcon tools properly recognize them?
> So far these tools could only read from file_contexts, or
> file_contexts.homedirs or file_contexts.local files and they only
> knows that the role for non-process class objects to be "object_r".
> 
> Suppose we have below role_transition rule:
>     role_transition sysadm_r user_home_t:{ file dir } sysadm_r;
> 
> Which means any objects of the file or dir classes created in a parent
> directory with type as user_home_t by the sysadm_r would have sysadm_r
> as the objects' role. Since it is hard to know:
> 1. The path of such parent directories, and
> 2. The seuser that is assuming the sysadm_r role;
> It would be impossible to use "semanage fcontext -a" command to
> specify special security contexts for files at run-time, nor add
> relevant rules in the related .fc files(so as to prevent restorecon to
> relabel the ob! ject's role to "object_r").
> 
> Comments?

restorecon/setfiles doesn't know anything about any runtime transition
rules, whether type, range, or role.  It can only be used to reset the
system to an initial state, where that initial state has to be defined
through file_contexts.  For user home directories, you can already
create a homedir_template that uses the ROLE template and have the role
prefix inserted when libsemanage generates file_contexts.homedirs, so I
think you can set up a system where user home directories are labeled
with their role by default if you want that behavior.

We could also possibly change restorecon/setfiles to not relabel a file
by default if it only differs in its role field, with that being
overridden by -F (force).

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
