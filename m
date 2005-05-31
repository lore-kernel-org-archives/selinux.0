Subject: Re: file_type_auto_trans is not sufficient
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Ivan Gyurdiev <ivg2@cornell.edu>
Cc: SELinux@tycho.nsa.gov, dwalsh@redhat.com
In-Reply-To: <1117249760.19257.18.camel@localhost.localdomain>
References: <1117249760.19257.18.camel@localhost.localdomain>
Content-Type: text/plain
Date: Tue, 31 May 2005 09:18:46 -0400
Message-Id: <1117545526.28924.57.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2005-05-27 at 23:09 -0400, Ivan Gyurdiev wrote:
> To address those problems, I think I need to add selinux support
> to a number of applications, and perform the transition in the code. 
> I'm not sure what's the best way to do that. Does adding 
> the following functions to libselinux (or elsewhere) make sense?
> 
> int mkdir_restorecon(const char *pathname, mode_t mode);
> int creat_restorecon(const char *pathname, mode_t mode);
> int mknod_restorecon(const char *pathname, mode_t mode, dev_t dev);
> 
> Those would perform getfscreate/matchpathcon/setfscreate cycle,
> and would ignore errors in permissive mode.

I'd advise against creating a composite interface like this, as it runs
into the same problems that we had with the original SELinux API (which
had extended forms of mkdir/creat/mknod/exec), i.e. use of glibc
functions that internally use these functions, as you note in a later
message.  Instead, keep the setting and resetting of the fscreate
context as a separate operation, and then let the application continue
to use ordinary mkdir/create/mknod or glibc functions for the actual
creation.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
