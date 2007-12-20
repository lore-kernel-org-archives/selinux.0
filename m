Message-ID: <4769F731.6050002@ak.jp.nec.com>
Date: Thu, 20 Dec 2007 14:01:37 +0900
From: KaiGai Kohei <kaigai@ak.jp.nec.com>
MIME-Version: 1.0
To: Eamon Walsh <ewalsh@tycho.nsa.gov>
CC: SELinux List <selinux@tycho.nsa.gov>, Stephen Smalley <sds@tycho.nsa.gov>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>,
        Joshua Brindle <jbrindle@tresys.com>
Subject: Re: RFC: Per-object manager controls in /selinux/config
References: <4769A947.1030403@tycho.nsa.gov>
In-Reply-To: <4769A947.1030403@tycho.nsa.gov>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Eamon Walsh wrote:
> I am proposing adding a separate config line for each userspace object 
> manager, as follows:
> 
> #    permissive - SELinux prints warnings instead of enforcing.
> #    disabled - SELinux is fully disabled.
> SELINUX=enforcing
> +
> +# SELINUX_MANAGER= can take one of these four values
> +#    enforcing - SELinux security policy is enforced by this object 
> manager.
> +#    permissive - The object manager prints warnings instead of enforcing.
> +#    disabled - SELinux is fully disabled by this object manager.
> +#    default - The object manager will track the system setting.
> +SELINUX_DBUS=default
> +SELINUX_XSERVER=permissive
> +
> # SELINUXTYPE= type of policy in use. Possible values are:
> #    targeted - Only targeted network daemons are protected.
> #    strict - Full SELinux protection.

Eamon,

Could you tell me the purpose of this new feature?

It seems to me this new feature prevents to keep consistency of
the SELinux state. I think the internal state of userspace object
managers should be just a copy from the in-kernel reference monitor...

Thanks,

> However, I am a little unclear on how runtime setenforce calls should be 
> dealt with.  The way it currently works is if the userspace object 
> manager is initialized without an enforcing mode specified in the call 
> to avc_open(), it will track the system setting and conform to netlink 
> "setenforce" messages.  However, if avc_open() is called with an 
> enforcing mode specified, it will stay in that mode and not respond to 
> the netlink messages.  Users might thus be confused if they issue a 
> "setenforce 0" and the X server stays in enforcing mode because it was 
> specified that way in the config file.  But I'm of the opinion that 
> runtime setenforcing is an abnormal event, and anyone who edits the 
> config file away from "default" and then runs setenforce will understand 
> how it works.

-- 
OSS Platform Development Division, NEC
KaiGai Kohei <kaigai@ak.jp.nec.com>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
