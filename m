Message-ID: <530B4C2B.3060902@tycho.nsa.gov>
Date: Mon, 24 Feb 2014 08:42:03 -0500
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: work3231 work3231 <work3231@mail.ru>, selinux@tycho.nsa.gov
Subject: Re: doesnt work MLS in ssh X-forwarding on the client's X windows
References: <1393243622.357229894@f81.i.mail.ru>
In-Reply-To: <1393243622.357229894@f81.i.mail.ru>
Content-Type: text/plain; charset=ISO-8859-1
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 02/24/2014 07:07 AM, work3231 work3231 wrote:
>  Hello!
> 
> I'm working on enhancing SELinux for thin clients (booting from the netcard)
> The problem: during the connection to the "server" from "client" by ssh with parameter -X I dont see correct context of window properties (X_PROP for ex.), it is NNN:s0, but not NNN:s1
> 
> More detally algorythm:  
> 
> xinit /usr/bin/terminal -- :1  ------ new X
> ssh user@IP -X
> xfce-session &
> xauth list    ------ to repair DISPLAY in the new security level
> newrole -l s1
> xauth add DISPLAY   ------ repair it
> leafpad&
> -------------------
> 
> in xorg-server-1.12.0/Xext/xselinux_hooks.c      inserted logs on X_PROP right after rc=SELinuxDoCheck()  just input some text in "leafpad" and look to the /var/log/Xorg.1.log)
> On the other hand int /proc we have correct context of tested application (leafpad), but internally not.
> Resulting context of obj(PROP): user_u:object_t:xproperty_t:s0   but it must be NNN:s1   like on local X-session on the server or on the client.
> 
> Files /etc/ssh/sshd_config and ssh_config set up correctly: ForwardX11Trusted=yes
> 
> 
> 
> How to do it working, or there is not such fuctnionality in SELinux?

Is the property labeled as a poly_property in your x_contexts configuration?
