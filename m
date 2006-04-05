Message-ID: <44341AE0.9040201@redhat.com>
Date: Wed, 05 Apr 2006 15:30:40 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>, SE Linux <selinux@tycho.nsa.gov>,
        Steve Grubb <sgrubb@redhat.com>, John Dennis <jdennis@redhat.com>,
        Jonathan Blandford <jrb@redhat.com>
Subject: AVC to Usable messages
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I am adding the capability to analyze AVC messages and allow policy 
developers to write a few lines of python that would then "translate" 
AVC messages into a human readable sentences.  The end goal would be then to
Alert users either through Email for servers or a bugbuddy type 
application on the desktop when an AVC message gets delivered.

Each plugin will get called with a list of AVC messages,  When it finds 
one that it matches, it will strip off the AVC message and return the 
translated string.  Eventually the second parameter returned by the 
plugin, might be a script that the user could then push to rectify the 
situation.  So we notice that a zone transfer is being attempted to the 
system but SELinux is blocking it.  Does the user want to allow the zone 
transfer?  If yes then the "BugBuddy" application will set the boolean 
to allow this. (Of course this would all need to authorized).

Example:

time->Wed Apr  5 14:38:38 2006
type=AVC_PATH msg=audit(1144262318.922:237):  
path="/usr/lib/flash-plugin/libflashplayer.so"
type=SYSCALL msg=audit(1144262318.922:237): arch=40000003 syscall=125 
success=no exit=-13 a0=20f0000 a1=1fd000 a2=5 a3=bfca1260 items=0 
pid=2714 auid=3267 uid=3267 gid=3267 euid=3267 suid=3267 fsuid=3267 
egid=3267 sgid=3267 fsgid=3267 tty=(none) comm="firefox-bin" 
exe="/usr/lib/firefox-1.5.0.1/firefox-bin" 
subj=user_u:system_r:unconfined_t:s0-s0:c0.c255
type=AVC msg=audit(1144262318.922:237): avc:  denied  { execmod } for  
pid=2714 comm="firefox-bin" name="libflashplayer.so" dev=dm-0 
ino=2803062 scontext=user_u:system_r:unconfined_t:s0-s0:c0.c255 
tcontext=system_u:object_r:lib_t:s0 tclass=file

more /usr/share/selinux/plugins/execmod.py
from avc import *
from rhpl.translate import _

def analyze(AVCS):
    ret = []
    for i in  AVCS:
        if "execmod" in i["access"]:
            if "path" in i:
                path=i["path"].strip('"')
            else:
                path=i["name"].strip('"')

            action=(_('An application %s on your system attempted to 
load a library %s that needs execmod access. This is a potential 
security problem that should be reported as a bugzilla.  Most libraries 
should not need this access. Somtimes libraries are coded incorrectly 
and request this access.  You change SELinux to allow the application 
this access by executing the following command, "chcon -t 
textrel_shlib_t %s"' % (i["comm"], i["name"], path)), "");
            ret.append(action)
            AVCS.remove(i)
    return (ret, AVCS)

audit2allow --analyze  -i /var/log/audit/audit.log
An application "firefox-bin" on your system attempted to load a library 
"libflashplayer.so" that needs execmod access. This is a potential 
security problem that should be reported as a bugzilla.  Most libraries 
should not need this access. Somtimes libraries are coded incorrectly 
and request this access.  You change SELinux to allow the application 
this access by executing the following command, "chcon -t 
textrel_shlib_t /usr/lib/flash-plugin/libflashplayer.so"



Thoughts?

Dan

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
