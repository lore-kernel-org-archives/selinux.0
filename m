Subject: Re: question about su and passwd
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: lky <lky77@sjtu.edu.cn>
Cc: SELINUX <SELinux@tycho.nsa.gov>, Daniel J Walsh <dwalsh@redhat.com>,
   Russell Coker <russell@coker.com.au>
In-Reply-To: <001401c39a74$ac06b370$5d38a8c0@lky>
References: <001401c39a74$ac06b370$5d38a8c0@lky>
Content-Type: text/plain
Message-Id: <1067266352.18818.51.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 27 Oct 2003 09:52:32 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2003-10-24 at 17:20, lky wrote:
> Hi, When I change the account with su I found the security context
> didn't change( the 2 account have different contexts ). Should I use
> aother command?

Since 'su' is most frequently used simply to obtain privileges (aka
capabilities) for administrative tasks by becoming the Linux superuser,
it seems undesirable to also change the SELinux user identity, as
SELinux can represent such changes via role/domain changes while
preserving user accountability.  newrole supports changing roles within
a session, and domain transitions within a role can occur upon executing
an associated entrypoint program.  The SELinux user identity is
presently only set by programs such as login, sshd, and gdm.  Do you
truly need to switch the actual user identity during a session?

> Another problem is I couldn't change my passwd under enforced
> mode.When I login as root and run "passwd" it said I coundn't do that
>  while when I login as another general user and run "passwd" it let me
> input my Unix passwd but always fail. Who can tell me the reason? I
> have installed 2.6-based SELinux and the patched utilities on
> redhat9.0.

We need to know more detail in order to diagnose, e.g. what exactly did
passwd display, and what denials were logged to /var/log/messages when
you ran it?  Note that there are two possible levels of denial for
passwd:
- The passwd program performs a permission check when the password for a
user other than the current SELinux user identity would be changed, e.g.
you ran passwd after doing a 'su' so that your SELinux user identity
no longer matches your Linux uid or you ran passwd with a username
argument other than your own.  This is to prevent someone with the
Linux root uid from being able to change the passwords of other users
unless they are also in an authorized role/domain.
- The kernel performs permission checks for the various kernel
operations invoked by the passwd program, e.g. invoking cracklib
to check the strength of the passwd, accessing the cracklib database,
updating /etc/shadow, etc.  The policy or file contexts configurations
may need to be adjusted to grant the appropriate permissions or set
the appropriate file types.  Is crack.te enabled?

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
