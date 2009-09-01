Subject: Re: policycoreutils - semanage does not set umask
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Manoj Srivastava <srivasta@golden-gryphon.com>
Cc: selinux@tycho.nsa.gov, 524508-forwarded@bugs.debian.org,
        Bastian Blank <waldi@debian.org>
In-Reply-To: <87hbvyvb8h.fsf@anzu.internal.golden-gryphon.com>
References: <87hbvyvb8h.fsf@anzu.internal.golden-gryphon.com>
Content-Type: text/plain
Date: Tue, 01 Sep 2009 09:43:37 -0400
Message-Id: <1251812617.27334.107.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 2009-08-23 at 09:46 -0500, Manoj Srivastava wrote:
> Hi,
> 
>         This has been reported to the Debian BTS.
> 
>         semanage does not set the umask for itself and does not fix the
>  permissions of rewritten files. This leads to a unreadable (for generic
>  user and therfor ssh) seusers file:
>  -rw-r----- 1 root root 187 17. Apr 16:22 /etc/selinux/default/seusers
> 
>         The pam module does not bail out on that but always assigns
>  user_u for users.
> 
>         manoj
> 
> http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=524508

When installing files such as seusers, semanage should be installing
with a default file mode of 0644 or the file-mode specified
by /etc/selinux/semanage.conf.

Possibly the bug you are encountering is a consequence of the incorrect
hard linking code introduced in libsemanage 2.0.31 that was reverted in
libsemanage 2.0.35.

commit 8edc3f9730aab6bd8f52dafb9686baddaac83954
Author: Stephen Smalley <sds@tycho.nsa.gov>
Date:   Wed Aug 5 11:19:29 2009 -0400

    libsemanage: do not hard link files
    
    Remove the support for hard linking files in semanage_copy_file, as it
    is unsafe and can leave the active store corrupted if something goes
    wrong during the transaction.  It also can leave the installed policy
    files with incorrect file modes or security contexts.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
