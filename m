Subject: Re: Fwd: "star -xattr" in SELinux enabled system
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Nagendra Tomar <tomer_iisc@yahoo.com>
Cc: SELinux@tycho.nsa.gov
In-Reply-To: <2433.82487.qm@web53709.mail.re2.yahoo.com>
References: <2433.82487.qm@web53709.mail.re2.yahoo.com>
Content-Type: text/plain
Date: Fri, 08 Jun 2007 07:54:10 -0400
Message-Id: <1181303650.23351.9.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2007-06-08 at 00:02 +0100, Nagendra Tomar wrote:
> Resending after subscribing to the SELinux mailing list
> 
> Nagendra Tomar <tomer_iisc@yahoo.com> wrote:
>         Date: Thu, 7 Jun 2007 23:47:40 +0100 (BST)
>         From: Nagendra Tomar <tomer_iisc@yahoo.com>
>         Subject: "star -xattr" in SELinux enabled system
>         To: SELinux@tycho.nsa.gov
>         
>         When I try to unpack a star tarball which was packed with the
>         xattr option (to retain the selinux file contexts), I get a
>         lot of "denied" errors. These errors  are not unexpected, as
>         star tries to set the extended attributes of each of the
>         component file in the tarball as it extracts them.
>             Since, I've not given the relabelfrom/relabelto
>         permissions for those combinations of file contexts, the
>         errors are expected. Apart from the relabel from/to errors,
>         there are also mkdir/create file errors as start tries to
>         create directories and files inside directories with contexts
>         which the star process'  domain has not been authorized to.
>         Nothing wrong in this, as this is what SELinux is supposed to
>         do.
>          I'm running a modified ref policy where my goal is to be very
>         restrictive in what I allow.
>             My question is:
>         Can it be inferred that star (or tar for that matter)  is best
>         avoided if we want to make a very secure/restrictive SELinux
>         policy ? O/w the policy has to be modified for any star
>         tarball that we may want to extract. 
>             I'm running star from the rc scripts (with initrc_t)
>         domain. Everytime I allow initrc_t domain some
>         create/write/relabelto/relabelfrom permission, I feel that I
>         am allowing more than what I should. Will it be a good idea to
>         assign a different domain to the star process and allow that
>         domain all these permissions (the problem of future star
>         tarballs failing to extract is still there though)

This is somewhat similar to the question of how cp -p should handle the
situation when it cannot preserve the file security context of the
original due to a permissions issue.  My view is that such applications
should by default fall back to creating the file in the default file
creation context of the process if they are not permitted to preserve
the context of the original file unless the user specified an explicit
option indicating that the operation should abort if it cannot preserve
context.  The application should never assume that it will always be
allowed to preserve the context of the original, as many policies won't
permit that to happen even for legitimate use.

Running star in a distinct domain from initrc_t may make sense just from
the perspective that it likely requires different permissions from the
rest of initrc_t, but granting that domain the ability to extract all
file contexts is not likely what you truly want (e.g. I wouldn't want it
to be able to replace /sbin/init).
 
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
