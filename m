Subject: Re: [PATCH 10/10] cr: lsm: restore file->f_security
From: Stephen Smalley <sds@tycho.nsa.gov>
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: Linux Containers <containers@lists.osdl.org>,
        Oren Laadan <orenl@cs.columbia.edu>,
        David Howells <dhowells@redhat.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morgan <morgan@kernel.org>, SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <20090610014704.GI5658@us.ibm.com>
References: <20090610014412.GA5628@us.ibm.com>
	 <20090610014704.GI5658@us.ibm.com>
Content-Type: text/plain
Date: Wed, 10 Jun 2009 09:54:50 -0400
Message-Id: <1244642090.20265.144.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2009-06-09 at 20:47 -0500, Serge E. Hallyn wrote:
> file->f_cred is the cred of the task which opened it.  file->f_security
> can be separately set by the LSM.  Checkpoint the file->f_security,
> and at restart ask the LSM, using security_file_restore, based on the current
> task's context and the checkpointed f_security, which f_security to apply (or
> whether to refuse the restart altogether).
> 
> For Smack, accept the checkpointed label if the restarting task has
> CAP_MAC_ADMIN.
> 
> For SELinux, I currently ignore the checkpointed label and call
> file_alloc_security().  Do we want to have 'restore' permission for
> class file?

Yes - otherwise we'll end up with a restarted process that may not be
able to access its open files.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
