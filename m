Subject: Re: The new audit2allow.
From: Stephen Smalley <sds@tycho.nsa.gov>
To: "Brian M. Williams" <bwilliams@tresys.com>
Cc: selinux@tycho.nsa.gov, Karl MacMillan <kmacmillan@mentalrootkit.com>,
        Joshua Brindle <jbrindle@tresys.com>
In-Reply-To: <6FE441CD9F0C0C479F2D88F959B01588EDEA2F@exchange.columbia.tresys.com>
References: 
	 <6FE441CD9F0C0C479F2D88F959B01588EDEA2F@exchange.columbia.tresys.com>
Content-Type: text/plain
Date: Tue, 14 Aug 2007 08:30:27 -0400
Message-Id: <1187094627.26008.149.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2007-08-13 at 16:52 -0400, Brian M. Williams wrote:
> I am having huge issues with the new audit2allow.  The new interface
> matching is very hit or miss, the old audit2allow -R matched the correct
> interface about as often even if it wasn't the correct way of doing
> things.  The formatting is a major step back IMO.  Below are the old and
> new output formats of the call audit2allow -v.  Note that the old -v
> flag actually gave extra information; it gave the type of denial, the
> audit number and was well formatted.  I am at a loss to find anything
> useful -v gives now.  Also now just getting the -R flag to work
> correctly by finding and installing the correct headers, figuring out
> the correct place to put them and running some program to parse the
> header files was enough of a hassle for me to not use that feature.  The
> addition of a newer python dependency (the python now required for the
> toolchain is not in RHEL4 and required an update), the huge pain it is
> just to get it to work was not worth these changes to me.  Does anyone
> know why these changes were made?

First, the "new" audit2allow was less about audit2allow than about
sepolgen, i.e. introducing a python module that would be a basis going
forward for more advanced policy generation work.  audit2allow was then
just rewritten to use sepolgen.

Second, if there are specific regressions in the new audit2allow, then
yes, those should be corrected.  Can you provide specific examples where
interface matching is worse - those would be useful test cases going
forward.  The -v output was never rigorously defined (they were just
comment lines, after all, and just to help a human reader with
supplemental information so that he wouldn't have to go back to the
original audit message and correlate it), and I'm not sure how TYPE=AVC
is helpful.  Retaining the audit serial number would likely be useful.

Third, requiring preparsing of the headers isn't onerous; in Fedora,
invoking sepolgen-ifgen is handled automatically by the .spec files, and
it allows errors to be caught sooner, and it avoids the overhead of
parsing the full headers on every run of audit2allow.

Fourth, sepolgen and the new audit2allow were only introduced on the
trunk (2.x series), not on the stable branch (1.x) series, and we
explicitly warned that the trunk can break compatibility.

> Brian
> 
> 
> Old verbose output:
> 
> allow staff_t auditd_log_t:dir search;
>         #TYPE=AVC  MSG=audit(1174506807.550:79):  COMM="scp"
> NAME="audit"   : search
>         #TYPE=AVC  MSG=audit(1174506833.532:89):  COMM="scp"
> NAME="audit"   : search
> allow staff_t auditd_log_t:file read;
>         #TYPE=AVC  MSG=audit(1174506833.532:89):  COMM="scp"
> NAME="audit.log"   : read
> allow staff_t sysadm_home_dir_t:dir write;
>         #TYPE=AVC  MSG=audit(1174504050.162:101):  COMM="vim"
> NAME="root"   : write
>         #TYPE=AVC  MSG=audit(1174504050.172:102):  COMM="vim"
> NAME="root"   : write
>         #TYPE=AVC  MSG=audit(1174504050.174:103):  COMM="vim"
> NAME="root"   : write
>         #TYPE=AVC  MSG=audit(1174504746.733:106):  COMM="vim"
> NAME="root"   : write
>         #TYPE=AVC  MSG=audit(1174504746.745:108):  COMM="vim"
> NAME="root"   : write
>         #TYPE=AVC  MSG=audit(1174504746.748:109):  COMM="vim"
> NAME="root"   : write
>         #TYPE=AVC  MSG=audit(1174504746.749:110):  COMM="vim"
> NAME="root"   : write
> allow staff_t sysadm_home_t:file { append write };
>         #TYPE=AVC  MSG=audit(1174504746.740:107):  COMM="bash"
> NAME=".bash_history"   : append
>         #TYPE=AVC  MSG=audit(1174504040.516:100):  COMM="vim"
> NAME="context.h"   : write
>         #TYPE=AVC  MSG=audit(1174504054.917:104):  COMM="vim"
> NAME="selinux.h"   : write
> allow staff_t sysadm_xauth_home_t:file read;
>         #TYPE=AVC  MSG=audit(1174506416.735:39):  COMM="xsetroot"
> NAME=".Xauthority"   : read
>         #TYPE=AVC  MSG=audit(1174506416.746:40):  COMM="xrdb"
> NAME=".Xauthority"   : read
>         #TYPE=AVC  MSG=audit(1174506416.800:41):  COMM="xmodmap"
> NAME=".Xauthority"   : read
>         #TYPE=AVC  MSG=audit(1174506417.036:42):  COMM="xmbind"
> NAME=".Xauthority"   : read
>         #TYPE=AVC  MSG=audit(1174506417.381:45):  COMM="dbus-launch"
> NAME=".Xauthority"   : read
>         #TYPE=AVC  MSG=audit(1174506417.581:46):  COMM="gnome-session"
> NAME=".Xauthority"   : read
> 
> new verbose output:
> 
> #============= staff_t ==============
> # src="staff_t" tgt="auditd_log_t" class="dir", perms="search"
> # comm="scp" exe="" path=""
> allow staff_t auditd_log_t:dir search;
> # src="staff_t" tgt="auditd_log_t" class="file", perms="{ read getattr
> }"
> # comm="scp" exe="" path=""
> allow staff_t auditd_log_t:file { read getattr }; # src="staff_t"
> tgt="sysadm_home_dir_t" class="dir", perms="write"
> # comm="vim" exe="" path=""
> allow staff_t sysadm_home_dir_t:dir write; # src="staff_t"
> tgt="sysadm_home_t" class="file", perms="{ write append }"
> # comm="vim" exe="" path=""
> allow staff_t sysadm_home_t:file { write append }; # src="staff_t"
> tgt="sysadm_xauth_home_t" class="file", perms="read"
> # comm="xsetroot" exe="" path=""
> allow staff_t sysadm_xauth_home_t:file read;
> 
> 
> 
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
