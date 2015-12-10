Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id tBAHrA6q021926
 for <selinux@tycho.nsa.gov>; Thu, 10 Dec 2015 12:53:17 -0500
Subject: Re: Wrong audit message type when policy is reloaded
References: <563CD0E4.4060105@debian.org> <563CD57E.8090004@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov
To: linux-audit@redhat.com
From: Laurent Bigonville <bigon@debian.org>
Message-ID: <5669BBFD.6080505@debian.org>
Date: Thu, 10 Dec 2015 18:53:01 +0100
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
In-Reply-To: <563CD57E.8090004@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

I guess I should have CCed the linux-audit mailing list from the start.

As said in my initial mail (see bellow) wheb SELinux user object manager 
are reloading the policy, an audit message with a wrong type is logged 
USER_AVC vs USER_MAC_POLICY_LOAD.

Le 06/11/15 17:29, Stephen Smalley a écrit :
> On 11/06/2015 11:10 AM, Laurent Bigonville wrote:
>> Hi,
>>
>> When the policy is reloaded, systemd and dbus are sending a USER_AVC
>> audit event instead of a USER_MAC_POLICY_LOAD one.
>>
>> Looking at an other object manager (the xserver) it uses the following
>> code:
>> http://cgit.freedesktop.org/xorg/xserver/tree/Xext/xselinux_hooks.c#n300
>>
>> Can we really link SELINUX_INFO to AUDIT_USER_MAC_POLICY_LOAD? Is there
>> a better way to achieve this?
>>
>> An downstream bug has been opened:
>> https://bugzilla.redhat.com/show_bug.cgi?id=1195330
>
> I think when they introduced the audit support, they should have added 
> a new type value in libselinux for MAC_POLICY_LOAD, and then they 
> could have handled this cleanly in their callback functions. That is 
> what I would do.  I guess now we have to figure out how to do so 
> compatibly...
>
>
