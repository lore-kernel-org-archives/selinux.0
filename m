From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: user guide drafts: "Mounting File Systems"
Date: Sat, 11 Oct 2008 21:18:41 +1000
Cc: Eric Paris <eparis@redhat.com>, Murray McAllister <mmcallis@redhat.com>,
        SE Linux <selinux@tycho.nsa.gov>, James Morris <jmorris@namei.org>,
        Eric Paris <eparis@parisplace.org>, dwalsh@redhat.com
References: <48EF03BA.90901@redhat.com> <1223646314.8664.34.camel@localhost.localdomain> <1223646663.25569.65.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1223646663.25569.65.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200810112218.47136.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Saturday 11 October 2008 00:51, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> BTW, one interesting tidbit from OpenSolaris FMAC - in Solaris, the
> uid/gid/mode information for the root directory of a tmpfs mount
> defaults to the attributes of the underlying mount point directory, so I
> did likewise for the security context.  Which means that I can set the
> security context on the mount point directory as desired (tmp_t
> for /tmp, var_run_t for /var/run, ...) and then the tmpfs mount will
> pick up the right label automatically from the mount point.  I don't
> know if that makes sense in Linux, as they infer the default uid/gid
> from the mounting process instead.

If we are considering that then maybe we also should consider the reverse.  
Having a chcon on the root of a tmpfs filesystem change the mount point.

-- 
russell@coker.com.au
http://etbe.coker.com.au/          My Blog

http://www.coker.com.au/sponsorship.html Sponsoring Free Software development


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
