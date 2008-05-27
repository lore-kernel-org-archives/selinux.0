Subject: Re: Quick question
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Ioannis Aslanidis <iaslanidis@flumotion.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <483C46FA.9030904@flumotion.com>
References: <483C46FA.9030904@flumotion.com>
Content-Type: text/plain
Date: Tue, 27 May 2008 13:56:49 -0400
Message-Id: <1211911009.19360.51.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Tue, 2008-05-27 at 19:38 +0200, Ioannis Aslanidis wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Hello,
> 
> I do not know if this is the proper place for this; however, neither on
> IRC in #selinux on freenode nor in other places related to SELinux I was
> able to get the appropriate help. I have also spent over a month reading
> through documentation and googling around to find something similar to
> what I needed, but to no avail.
> 
> I would like to know how to create a module or policy or modify the
> current policy so that users of the system are:
> 1. Unable to list the /home directory
> 2. Unable to get into other users directory using SELinux rules
> 3. (optional) Be able to list /home, but be unable to see anything apart
> from his home.
> 
> I have specific needs in my production environment which require these
> specifications. Normal permissions are not an option in my environment,
> because of shared permissions of nfs mounts.
> 
> Getting a template and working over it or converting deny rules to allow
> rules is not an option for me, as I need to be able to understand and
> allow others to understand the text and be able to easily maintainy and
> modify it.
> 
> In order to prevent the users from getting any data in /etc/passwd I
> plan to use PAM + LDAP or a similar solution.
> 
> I hope you can give me a hand with this.

If I understand correctly, you want to provide separation on a per-user
basis (not just per-role) for NFS-mounted home directories.  I don't
think that is realistically supportable by SELinux today, as 1) SELinux
distinguishes based on security context/label, not uid, and 2) NFS
doesn't support file labeling yet.  Sounds more like a job for 'normal
permissions' i.e. discretionary access modes and/or ACLs.  There is
ongoing work to support file labeling in NFSv4, but it is still in
development, and even then, instantiating a separate role for every user
is going to be problematic for any large number of users.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
