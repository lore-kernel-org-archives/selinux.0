Subject: Re: continuation of systemd/SELinux discussion from Github
References: <20151202101801.GA1028@x250> <565F366E.3030403@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov
To: sds@tycho.nsa.gov
From: Laurent Bigonville <bigon@debian.org>
Message-ID: <566006D9.6040108@debian.org>
Date: Thu, 3 Dec 2015 10:09:45 +0100
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
In-Reply-To: <565F366E.3030403@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Le 02/12/15 19:20, Stephen Smalley a écrit :
> On 12/02/2015 05:18 AM, Dominick Grift wrote:
>> Let's continue the discussion here.
>>
>> The last answered questionnaire is below, any further questions or
>> comments?:
>>
>> ----------------------------------------
>>
>>          "systemd --user" concept is broken as we can see/read from this
>>          thread from SELinux point of view.
>>
>> It was working fine except that it was trying to log to the audit system
>> which unprivileged processes arent allowed to do.
>
> What's the dbus solution for this issue?
That one I can reply.

The dbus-daemon check if the AUDIT_CAP is set on its process an then 
open the audit netlink and then start logging. The idea was to set the 
file capability on the executable, but Simon (dbus-daemon upstream) was 
not sure he wanted that as dbus-daemon has not been audited and was 
afraid of some security issues (If somebody has an opinion on whether 
the file capability should be set by default or not, please tell me).

These are the "recent" patches involved in the auditing:
http://cgit.freedesktop.org/dbus/dbus/commit/?id=517c4685a8197498dea40918b308beea19155efd
http://cgit.freedesktop.org/dbus/dbus/commit/?id=992236f1c57a7a8930e4c8aeb21f30c2d8af21d3
http://cgit.freedesktop.org/dbus/dbus/commit/?id=983237258dc440419b863461fae15f31cce08639
http://cgit.freedesktop.org/dbus/dbus/commit/?id=a3a5935a0a038c3b44c61ce5719f0f7e647b96c6
