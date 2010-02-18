Message-ID: <4B7DCA8D.8010708@gmail.com>
Date: Thu, 18 Feb 2010 15:17:33 -0800
From: "Justin P. mattock" <justinmattock@gmail.com>
MIME-Version: 1.0
To: Alan Rouse <alan.rouse@ericsson.com>
CC: Stephen Smalley <sds@tycho.nsa.gov>, Dominick Grift <domg472@gmail.com>,
        "'selinux@tycho.nsa.gov'" <selinux@tycho.nsa.gov>
Subject: Re: SELinux Policy in OpenSUSE 11.2
References: <5A5E55DF96F73844AF7DFB0F48721F0F529A558532@EUSAACMS0703.eamcs.ericsson.se>	 <1266347411.5252.107.camel@moss-pluto.epoch.ncsc.mil>	 <5A5E55DF96F73844AF7DFB0F48721F0F529A5587DD@EUSAACMS0703.eamcs.ericsson.se>	 <1266349121.5252.131.camel@moss-pluto.epoch.ncsc.mil>	 <5A5E55DF96F73844AF7DFB0F48721F0F529A5588F8@EUSAACMS0703.eamcs.ericsson.se>	 <4B7B21A2.3080006@gmail.com> <4B7B97D4.7020005@gmail.com>	 <5A5E55DF96F73844AF7DFB0F48721F0F529A558C9F@EUSAACMS0703.eamcs.ericsson.se>	 <1266425895.4945.105.camel@moss-pluto.epoch.ncsc.mil>	 <5A5E55DF96F73844AF7DFB0F48721F0F529A780180@EUSAACMS0703.eamcs.ericsson.se>	 <1266433081.4945.112.camel@moss-pluto.epoch.ncsc.mil>	 <4B7C47DB.40602@gmail.com> <1266436827.4945.123.camel@moss-pluto.epoch.ncsc.mil> <5A5E55DF96F73844AF7DFB0F48721F0F529A78028F@EUSAACMS0703.eamcs.ericsson.se> <4B7DB3B4.2070409@gmail.com> <5A5E55DF96F73844AF7DFB0F48721F0F529A780AEE@EUSAACMS0703.eamcs.ericsson.se>
In-Reply-To: <5A5E55DF96F73844AF7DFB0F48721F0F529A780AEE@EUSAACMS0703.eamcs.ericsson.se>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 02/18/2010 01:53 PM, Alan Rouse wrote:
> Justin, could you share what you did to reach that state?  Your last email yesterday left me with the impression that you were rebuilding some tools from source...  What tools, what versions?  What booleans did you disable?
>


sure.. (hopefully I don't get you confused)
from looking at the policy suse gives,
a monolithic policy. While running the one that they provide I noticed
the system is running as system_u:system_r:system_t
(or whatever it is)
I'm sure you can use this, but for me
I like to either run in staff_r, sysadm_r or user_r(roles).
(if under a corporate environment user_r would be the safest).

If wanting to run under these roles you would need to define these 
roles, and users under policy/users, or if using a binary policy you 
would use /usr/sbin/semanage user * and so forth.

I couldn't find the source from suse(although I'm sure its there), so I 
just grabbed a copy from tresys.(if the source is available then you 
just need to add the user and the roles in policy/users or if using a 
binary policy use semanage(in this case I wanted the system to run as
name:user_r:user_t.)

while building the source from tresys I sometimes will hit a syntex 
error(this time I did) with checkpolicy and/or checkmodule(something 
with flex-2.35*) so downgrading flex to 2.5.4a and building checkpolicy 
with this version for some reason or another fixes the syntax error(keep 
in mind I only used that flex version for checkpolicy/checkmodule, then 
removed that version and put back the original, after checkpolicy was 
built).
keep in mind this error seems to be random so if you don't hit this
then you don't need to rebuild chekpolicy/checkmodule.

then after being able to build and install the policy  then I focused in 
on the booleans, I set(although am not sure if they fixed the errors 
with avahi)where these:

allow_polyinstantiation=on
init_upstart=on(although I think they use sysvinit(notsure))
xdm_sysadm_login=on(this is for sysadm_r role(if I wanted the main 
context as name:sysadm_r:sysadm_t))
xserver_object_manager=on (although I dont see the SELinux
extension in Xorg.0.log)

keep in mind I don't think these booleans fixed the errors I think after
I had relabeled then the errors were fixed(but could be wrong).
(NOTE: relabeling with older versions of refpolicy will break, because 
there is no ext4 support so just use fixfiles)

then once I was able to get a clean boot(even with the "targeted" dbus 
issue)
I focused in on the login context:
name:user_r:user_t

this can be done in:
/etc/pam.d/{login,gdm,xdm}

adding:
session required pam_selinux.so close
session required pam_selinux.so open
(suse has nothing of this in there files,
or atleast I didn't see them)

gets me to login as:
name:user_r:user_t
(with monolithic you can change your login/user context
by adjust default_contexts to what context you want,
binary policy you would have to use semanage)

now after being able to have a clean boot,
and login context I then started to define the allow rules
(with binary policy you use audit2allow -dM modulename
then semodule -i modulename to install)

with monolithic because I'm lazy I just stick all allow rules in 
xserver.te in a real production environment you would have to
individually place each allow rule in it's appropriate *.te file
i.g. all hal allow rules goe into hal.te etc...
(with selinux_policy_default you have a file called local.te where all
of these go into).

so after adding all allow rules from dmesg/messages(audit2allow)
I then added all allow rules from /var/log/audit/audit.log
(there probably is a tool, but haven't figured what it is yet)

then after no more denials(with booting, and the apps I wanted to use) I 
was able to boot in full enforcement.
(keep in mind you might need to do a make enableaudit to grab some
noaudit rules that are preventing the system from running).

hope this helps, and hope I didn't get you confused
if you need any info let me know either me, or somebody else
will help you out.

Justin P. Mattock





















--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
