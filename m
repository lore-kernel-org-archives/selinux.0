Subject: Re: Wrong audit message type when policy is reloaded
To: Laurent Bigonville <bigon@debian.org>, selinux@tycho.nsa.gov
References: <563CD0E4.4060105@debian.org>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <563CD57E.8090004@tycho.nsa.gov>
Date: Fri, 6 Nov 2015 11:29:50 -0500
MIME-Version: 1.0
In-Reply-To: <563CD0E4.4060105@debian.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 11/06/2015 11:10 AM, Laurent Bigonville wrote:
> Hi,
>
> When the policy is reloaded, systemd and dbus are sending a USER_AVC
> audit event instead of a USER_MAC_POLICY_LOAD one.
>
> Looking at an other object manager (the xserver) it uses the following
> code:
> http://cgit.freedesktop.org/xorg/xserver/tree/Xext/xselinux_hooks.c#n300
>
> Can we really link SELINUX_INFO to AUDIT_USER_MAC_POLICY_LOAD? Is there
> a better way to achieve this?
>
> An downstream bug has been opened:
> https://bugzilla.redhat.com/show_bug.cgi?id=1195330

I think when they introduced the audit support, they should have added a 
new type value in libselinux for MAC_POLICY_LOAD, and then they could 
have handled this cleanly in their callback functions.  That is what I 
would do.  I guess now we have to figure out how to do so compatibly...
