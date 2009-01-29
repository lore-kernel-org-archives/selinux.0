Date: Thu, 29 Jan 2009 10:58:04 -0600
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: Eric Paris <eparis@redhat.com>
Cc: James Morris <jmorris@namei.org>, selinux@tycho.nsa.gov, sds@tycho.nsa.gov,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH][RFC] selinux: remove noop secondary_ops calls
Message-ID: <20090129165804.GB13082@us.ibm.com>
References: <1233201347-17568-1-git-send-email-jmorris@namei.org> <1233234541.3264.34.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1233234541.3264.34.camel@localhost.localdomain>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Quoting Eric Paris (eparis@redhat.com):
> On Wed, 2009-01-28 at 19:55 -0800, James Morris wrote:
> > These patches remove calls to secondary_ops where there is no
> > real capability hook, and a couple of SELinux hooks which only
> > called these noop hooks.
> > 
> > (Following this, the noop capabilities hooks should also be removed).
> > 
> > Please review.
> > 
> > James Morris (18):
> >       selinux: remove unused bprm_check_security hook
> >       selinux: remove secondary ops call to bprm_committing_creds
> >       selinux: remove secondary ops call to bprm_committed_creds
> >       selinux: remove secondary ops call to sb_mount
> >       selinux: remove secondary ops call to sb_umount
> >       selinux: remove secondary ops call to inode_link
> >       selinux: remove secondary ops call to inode_unlink
> >       selinux: remove secondary ops call to inode_mknod
> >       selinux: remove secondary ops call to inode_follow_link
> >       selinux: remove secondary ops call to inode_permission
> >       selinux: remove secondary ops call to inode_setattr
> >       selinux: remove secondary ops call to file_mprotect
> >       selinux: remove secondary ops call to task_create
> >       selinux: remove unused cred_commit hook
> >       selinux: remove secondary ops call to task_setrlimit
> >       selinux: remove secondary ops call to task_kill
> >       selinux: remove secondary ops call to unix_stream_connect
> >       selinux: remove secondary ops call to shm_shmat
> 
> For the entire series EXCEPT #9 inode_follow_link:
> Acked-by: Eric Paris <eparis@redhat.com>

Yup, all looks reasonable, except for the wrong patch attached
to the mprotect description :)

Acked-by: Serge Hallyn <serue@us.ibm.com>

fwiw...

-serge

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
