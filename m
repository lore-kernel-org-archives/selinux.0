Subject: Re: SELinux Policy in OpenSUSE 11.2
From: Stephen Smalley <sds@tycho.nsa.gov>
To: "Justin P. mattock" <justinmattock@gmail.com>
Cc: Alan Rouse <alan.rouse@ericsson.com>, Dominick Grift <domg472@gmail.com>,
        "'selinux@tycho.nsa.gov'" <selinux@tycho.nsa.gov>
In-Reply-To: <4B7DB3B4.2070409@gmail.com>
References: 
	 <5A5E55DF96F73844AF7DFB0F48721F0F529A558532@EUSAACMS0703.eamcs.ericsson.se>
	 <1266347411.5252.107.camel@moss-pluto.epoch.ncsc.mil>
	 <5A5E55DF96F73844AF7DFB0F48721F0F529A5587DD@EUSAACMS0703.eamcs.ericsson.se>
	 <1266349121.5252.131.camel@moss-pluto.epoch.ncsc.mil>
	 <5A5E55DF96F73844AF7DFB0F48721F0F529A5588F8@EUSAACMS0703.eamcs.ericsson.se>
	 <4B7B21A2.3080006@gmail.com> <4B7B97D4.7020005@gmail.com>
	 <5A5E55DF96F73844AF7DFB0F48721F0F529A558C9F@EUSAACMS0703.eamcs.ericsson.se>
	 <1266425895.4945.105.camel@moss-pluto.epoch.ncsc.mil>
	 <5A5E55DF96F73844AF7DFB0F48721F0F529A780180@EUSAACMS0703.eamcs.ericsson.se>
	 <1266433081.4945.112.camel@moss-pluto.epoch.ncsc.mil>
	 <4B7C47DB.40602@gmail.com>
	 <1266436827.4945.123.camel@moss-pluto.epoch.ncsc.mil>
	 <5A5E55DF96F73844AF7DFB0F48721F0F529A78028F@EUSAACMS0703.eamcs.ericsson.se>
	 <4B7DB3B4.2070409@gmail.com>
Content-Type: text/plain
Date: Fri, 19 Feb 2010 09:28:34 -0500
Message-Id: <1266589714.32011.14.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2010-02-18 at 13:40 -0800, Justin P. mattock wrote:
> alright... policy is up and running
> in full enforcement mode:
> 
> SELinux status:                 enabled
> SELinuxfs mount:                /selinux
> Current mode:                   enforcing
> Mode from config file:          error (Permission denied)
> Policy version:                 24
> Policy from config file:        targeted
> 
> Process contexts:
> Current context:                name:user_r:user_t
> Init context:                   unknown (Permission denied)

Since you ran it from user_t, you weren't allowed to see the context of
init.  Can you run pstree -Z as sysadm_t and confirm that processes are
running in the correct context (i.e. that they are not left in sysadm_t
as they were for Alan)?

> I tried to enable poly-instantiation support(pam_namespace), but
> need to look more into that because I never really set it up
> with gdm.

You don't really need that unless you want multi-level directories.

> Anyways I'm able to boot up, able to
> use firefox and evolution. as for anything
> else I'm sure just need to define the allow rules.
> 
> 
> Now the only real area of interest is
> the dbus message pointing to targeted.
> 
> I'm guessing dbus was built with a hard wire,
> if so this would require rebuilding dbus,
> or using anther rpm package built correctly.
> (if possible without breaking the system dependencies).
> 
> but then again it could be just a boolean.
> In any case main thing is full enforcement works
> gdm works, nice system I'd have to say.

dbus should just be including whatever path your /etc/dbus-1/system.conf
says to include, and  it should be relative to /etc/selinux/$SELINUXTYPE
from /etc/selinux/config if it has selinux_root_relative="yes" there.

On Fedora, /etc/dbus-1/system.conf says:
 <include if_selinux_enabled="yes"
selinux_root_relative="yes">contexts/dbus_contexts</include>

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
