From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Daniel J Walsh <dwalsh@redhat.com>
Subject: Re: More fixes for nscd in targeted policy
Date: Thu, 23 Sep 2004 22:45:47 +1000
Cc: Stephen Smalley <sds@epoch.ncsc.mil>, SELinux <SELinux@tycho.nsa.gov>
References: <41475DEA.90907@redhat.com> <1095253977.28981.80.camel@moss-spartans.epoch.ncsc.mil> <41484CFE.3050804@redhat.com>
In-Reply-To: <41484CFE.3050804@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200409232245.47674.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 16 Sep 2004 00:09, Daniel J Walsh <dwalsh@redhat.com> wrote:
> >>+#
> >>+# Handle winbind for samba, Might only be needed for targeted policy
> >>+#
> >>+dontaudit nscd_t var_run_t:sock_file rw_file_perms;
> >
> >This doesn't make sense; nscd_t has these permissions as a consequence
> >of having nscd_client_domain attribute in the policy (since it is used
> >for both the client and the daemon).
>
> I don't believ nscd_t has access to var_run_t.  It can do this to
> nscd_var_run_t.   It is
> trying to communicate with a socket created by winbind.

Any reference to var_run_t:sock_file should have ifdef(`targetted' around it.

In strict policy there will be no var_run_t:sock_file.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
