Subject: Re: /dev/pts/x use denials
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Ivan Gyurdiev <ivg2@cornell.edu>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1112569241.21383.37.camel@cobra.ivg2.net>
References: <1112569241.21383.37.camel@cobra.ivg2.net>
Content-Type: text/plain
Date: Mon, 04 Apr 2005 11:13:13 -0400
Message-Id: <1112627593.7629.89.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 2005-04-03 at 19:00 -0400, Ivan Gyurdiev wrote:
> Strange denials:
> 
> /dev/pts/2 has context: sysadm_tmp_t.
> Those happen intermittently, but I can't figure out when exactly.
> I am logged in as a regular user, but su-ed to root. Usually accompanied
> by a dac_override.
> 
> audit(1112568847.907:0): avc:  denied  { use } for  pid=22851
> exe=/usr/bin/mplayer path=/dev/pts/2 dev=devpts ino=4
> scontext=root:sysadm_r:sysadm_mplayer_t tcontext=phantom:staff_r:staff_t
> tclass=fd
> audit(1112568874.222:0): avc:  denied  { use } for  pid=22870
> exe=/usr/bin/tvtime path=/dev/pts/2 dev=devpts ino=4
> scontext=root:sysadm_r:sysadm_tvtime_t tcontext=phantom:staff_r:staff_t
> tclass=fd
> audit(1112568881.428:0): avc:  denied  { use } for  pid=22872
> exe=/bin/bash path=/dev/pts/2 dev=devpts ino=4
> scontext=root:sysadm_r:sysadm_mozilla_t tcontext=phantom:staff_r:staff_t
> tclass=fd

I don't see sysadm_tmp_t anywhere above. I do see staff_t fd's, but that
just shows that the descriptor was opened by a staff_t process and then
inherited across the su, nothing surprising there.  Earlier versions of
pam_selinux did try closing and re-opening descriptors 0-2 as newrole
does, but that proved problematic.  su likely just needs to be directly
patched rather than using pam_selinux.

-- 
Stephen Smalley <sds@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
