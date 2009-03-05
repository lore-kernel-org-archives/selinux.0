Subject: Re: PAM, GNOME, etc
From: Stephen Smalley <sds@tycho.nsa.gov>
To: russell@coker.com.au
Cc: SE-Linux <selinux@tycho.nsa.gov>, Daniel J Walsh <dwalsh@redhat.com>
In-Reply-To: <200903051749.31665.russell@coker.com.au>
References: <200903051749.31665.russell@coker.com.au>
Content-Type: text/plain
Date: Thu, 05 Mar 2009 11:05:00 -0500
Message-Id: <1236269100.9366.11.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2009-03-05 at 17:49 +1100, Russell Coker wrote:
> Currently the gdm package in Debian has some degree of SE Linux support (I 
> haven't yet read the source to see what it does).  However it seems that the 
> pam_selinux.so module is required and that it can't be the last module 
> (previously I just appended a line to the pam configuration).
> 
> session required pam_selinux.so
> session optional        pam_gnome_keyring.so auto_start
> 
> The above is part of my /etc/pam.d/gdm file.  The SE Linux module needs to be 
> run before the pam_gnome_keyring.so module so that the daemon it spawns for 
> the user will get the correct context.
> 
> It seems that we have three broad classes of session modules.  Those which 
> launch no child processes, those which launch system processes (EG automatic 
> home directory creation), and those which launch user processes (such as a 
> GNOME keyring).
> 
> Dan, what are you guys doing in Fedora in this regard?  Are you integrating SE 
> Linux support manually in every pam.d file to make sure you get it right?  It 
> seems that any automatic method (such as just appending a line to every one 
> of a set of files) is not going to work.

I think they are manually set up and maintained by the package
maintainers, e.g. the gdm source package has a gdm-pam file that already
contains this sequence for session modules:

session    required    pam_selinux.so close
session    required    pam_loginuid.so
session    optional    pam_console.so
session    required    pam_selinux.so open
session    optional    pam_keyinit.so force revoke
session    required    pam_namespace.so
session    optional    pam_gnome_keyring.so auto_start
session    include     system-auth

and the openssh source package has a sshd.pam file that looks like this:
# pam_selinux.so close should be the first session rule
session    required     pam_selinux.so close
session    required     pam_loginuid.so
# pam_selinux.so open should only be followed by sessions to be executed in the user context
session    required     pam_selinux.so open env_params
session    optional     pam_keyinit.so force revoke
session    include      system-auth

> Or have you patched a bunch of PAM modules to call setexeccon(NULL) before 
> they call exec()?

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
