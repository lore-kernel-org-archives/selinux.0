Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l7DKr7kj022885
	for <selinux@tycho.nsa.gov>; Mon, 13 Aug 2007 16:53:07 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id l7DKr3SY013725
	for <selinux@tycho.nsa.gov>; Mon, 13 Aug 2007 20:53:03 GMT
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: The new audit2allow.
Date: Mon, 13 Aug 2007 16:52:33 -0400
Message-ID: <6FE441CD9F0C0C479F2D88F959B01588EDEA2F@exchange.columbia.tresys.com>
From: "Brian M. Williams" <bwilliams@tresys.com>
To: <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I am having huge issues with the new audit2allow.  The new interface
matching is very hit or miss, the old audit2allow -R matched the correct
interface about as often even if it wasn't the correct way of doing
things.  The formatting is a major step back IMO.  Below are the old and
new output formats of the call audit2allow -v.  Note that the old -v
flag actually gave extra information; it gave the type of denial, the
audit number and was well formatted.  I am at a loss to find anything
useful -v gives now.  Also now just getting the -R flag to work
correctly by finding and installing the correct headers, figuring out
the correct place to put them and running some program to parse the
header files was enough of a hassle for me to not use that feature.  The
addition of a newer python dependency (the python now required for the
toolchain is not in RHEL4 and required an update), the huge pain it is
just to get it to work was not worth these changes to me.  Does anyone
know why these changes were made?

Brian


Old verbose output:

allow staff_t auditd_log_t:dir search;
        #TYPE=AVC  MSG=audit(1174506807.550:79):  COMM="scp"
NAME="audit"   : search
        #TYPE=AVC  MSG=audit(1174506833.532:89):  COMM="scp"
NAME="audit"   : search
allow staff_t auditd_log_t:file read;
        #TYPE=AVC  MSG=audit(1174506833.532:89):  COMM="scp"
NAME="audit.log"   : read
allow staff_t sysadm_home_dir_t:dir write;
        #TYPE=AVC  MSG=audit(1174504050.162:101):  COMM="vim"
NAME="root"   : write
        #TYPE=AVC  MSG=audit(1174504050.172:102):  COMM="vim"
NAME="root"   : write
        #TYPE=AVC  MSG=audit(1174504050.174:103):  COMM="vim"
NAME="root"   : write
        #TYPE=AVC  MSG=audit(1174504746.733:106):  COMM="vim"
NAME="root"   : write
        #TYPE=AVC  MSG=audit(1174504746.745:108):  COMM="vim"
NAME="root"   : write
        #TYPE=AVC  MSG=audit(1174504746.748:109):  COMM="vim"
NAME="root"   : write
        #TYPE=AVC  MSG=audit(1174504746.749:110):  COMM="vim"
NAME="root"   : write
allow staff_t sysadm_home_t:file { append write };
        #TYPE=AVC  MSG=audit(1174504746.740:107):  COMM="bash"
NAME=".bash_history"   : append
        #TYPE=AVC  MSG=audit(1174504040.516:100):  COMM="vim"
NAME="context.h"   : write
        #TYPE=AVC  MSG=audit(1174504054.917:104):  COMM="vim"
NAME="selinux.h"   : write
allow staff_t sysadm_xauth_home_t:file read;
        #TYPE=AVC  MSG=audit(1174506416.735:39):  COMM="xsetroot"
NAME=".Xauthority"   : read
        #TYPE=AVC  MSG=audit(1174506416.746:40):  COMM="xrdb"
NAME=".Xauthority"   : read
        #TYPE=AVC  MSG=audit(1174506416.800:41):  COMM="xmodmap"
NAME=".Xauthority"   : read
        #TYPE=AVC  MSG=audit(1174506417.036:42):  COMM="xmbind"
NAME=".Xauthority"   : read
        #TYPE=AVC  MSG=audit(1174506417.381:45):  COMM="dbus-launch"
NAME=".Xauthority"   : read
        #TYPE=AVC  MSG=audit(1174506417.581:46):  COMM="gnome-session"
NAME=".Xauthority"   : read

new verbose output:

#============= staff_t ==============
# src="staff_t" tgt="auditd_log_t" class="dir", perms="search"
# comm="scp" exe="" path=""
allow staff_t auditd_log_t:dir search;
# src="staff_t" tgt="auditd_log_t" class="file", perms="{ read getattr
}"
# comm="scp" exe="" path=""
allow staff_t auditd_log_t:file { read getattr }; # src="staff_t"
tgt="sysadm_home_dir_t" class="dir", perms="write"
# comm="vim" exe="" path=""
allow staff_t sysadm_home_dir_t:dir write; # src="staff_t"
tgt="sysadm_home_t" class="file", perms="{ write append }"
# comm="vim" exe="" path=""
allow staff_t sysadm_home_t:file { write append }; # src="staff_t"
tgt="sysadm_xauth_home_t" class="file", perms="read"
# comm="xsetroot" exe="" path=""
allow staff_t sysadm_xauth_home_t:file read;




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
