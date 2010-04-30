MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: Security Context after SSH-ing in...
Date: Fri, 30 Apr 2010 16:32:29 -0400
Message-ID: <D06FE0A2807BC145B0D38744789D4F5D08A07A11@de01exm68.ds.mot.com>
In-Reply-To: <D06FE0A2807BC145B0D38744789D4F5D04BAFAC2@de01exm68.ds.mot.com>
References: <4c63b15c0807151517t5c126030q1d80a5c4c4685a4b@mail.gmail.com> <1216209375.17602.77.camel@moss-spartans.epoch.ncsc.mil> <dd18b0c30807160803q7b34551cl567cf9d787db75e8@mail.gmail.com> <1216221492.17602.131.camel@moss-spartans.epoch.ncsc.mil> <D06FE0A2807BC145B0D38744789D4F5D04BAFA1E@de01exm68.ds.mot.com> <487F9610.6010104@redhat.com> <D06FE0A2807BC145B0D38744789D4F5D04BAFAC2@de01exm68.ds.mot.com>
From: "Hasan Rezaul-CHR010" <CHR010@motorola.com>
To: "Stephen Smalley" <sds@tycho.nsa.gov>
Cc: <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi All,

I have employed SELinux on our Linux product for a few years now and
have written some simple custom policies on top of the base Fedora Core
7 'strict' policy. 

I am using Standard Linux 2.6.14.  And the SELinux related packages I am
using are:

checkpolicy     1.34.1
libselinux      1.34.7
libsemanage     1.10.3
libsepol        1.16.1
policycoreutils 1.34.6

I have the following user mappings and login mappings defined:

root@hapWibbSc2:/var# semanage login -l

Login Name                SELinux User              MLS/MCS Range


__default__               user_u                    s0

admin                     staff_u                   s0

root                      root                      s0-s0:c0.c1023

system_u                  system_u                  s0-s0:c0.c1023



root@hapWibbSc2:/var# semanage user -l

                Labeling   MLS/       MLS/                          
SELinux User    Prefix     MCS Level  MCS Range
SELinux Roles

root            sysadm     s0         s0-s0:c0.c1023
system_r sysadm_r staff_r
staff_u         staff      s0         s0-s0:c0.c1023
sysadm_r staff_r
sysadm_u        sysadm     s0         s0-s0:c0.c1023
sysadm_r
system_u        user       s0         s0-s0:c0.c1023
system_r
user_u          user       s0         s0
user_r


Question
========
Most of the time, when I SSH into the system as Linux User "admin", I
get a security context of  "staff_u:staff_r:staff_t". Which is what I
actually want, given how I have configured policy and everything.

While the system runs over weeks at customer sites, (don't know exactly
what sequence of events transpire on the system, but possibly does
include several reboots), SOMETIMES, given the mappings described above,
when we SSH in as "admin", we get a security context of:

user_u:user_r:user_t  ?!?  This is obviously NOT desired, and causes my
strict policies to complain about things that should have ideally been
allowed as staff_t.

In these strange situations: I have tried restarting sshd. I have tried
rebooting the system. It doesn't seem to correct the problem !!

1. What could be causing this change all of a sudden ? How does this
happen given the semanage mappings above ??
2. What can I do to force the security_context for Linux user "admin" to
be reset back to "staff_u:staff_r:staff:t" manually ?
3.What can I do to make sure that the security context remains
staff_u:staff_r:staff_t  always !

Any other useful pointers or things to check would be appreciated.
Thanks as always.

R.H.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
