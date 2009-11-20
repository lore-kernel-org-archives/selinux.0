Message-ID: <4B070384.3020908@redhat.com>
Date: Fri, 20 Nov 2009 16:00:52 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Paul Nuzzi <pjnuzzi@tycho.ncsc.mil>
CC: selinux@tycho.nsa.gov, jmorris@namei.org,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Eamon Walsh <ewalsh@tycho.nsa.gov>,
        "George S. Coker, II" <gscoker@alpha.ncsc.mil>
Subject: Re: [PATCH] kernel: Dynamic port labeling
References: <1258657635.2753.8.camel@moss-stripedbass.epoch.ncsc.mil>	 <4B05C148.2080605@redhat.com> <1258734127.2606.49.camel@moss-stripedbass.epoch.ncsc.mil>
In-Reply-To: <1258734127.2606.49.camel@moss-stripedbass.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 11/20/2009 11:22 AM, Paul Nuzzi wrote:
> On Thu, 2009-11-19 at 17:06 -0500, Daniel J Walsh wrote: 
>> On 11/19/2009 02:07 PM, Paul Nuzzi wrote:
>>> Added a mechanism to add/delete/update port labels with an interface in 
>>> the selinuxfs filesystem.  This will give administrators the ability to
>>> update port labels faster than reloading the entire policy with
>>> semanage.  The administrator will also need less privilege since they
>>> don't have to be authorized to reload the full policy. Let me know what
>>> you think of the patch.  Not sure if the policy_rwlock semaphore needs
>>> to be taken before modifying the ocontext list. 
>>>
>>> A listing of all port labels will be output if the file /selinux/rw_port
>>> is read.  Labels could be added or deleted with the following commands 
>>>
>>> echo -n "del system_u:object_r:ssh_port_t:s0 6 22" > /selinux/rw_port
>>> echo -n "add system_u:object_r:telnetd_port_t:s0 6 22" > /selinux/rw_port
>>>
>>>
>> The problem with this type of interface is that it effects
>> name_connect and name_bind.
>>
>> If I had client policy written to allow ssh_t to connect to port
>> ssh_port_t (22), but I wanted sshd_t to listen on port 23,
>> Your change blows up one or the other app.
>>
>> What we really need is port labels based on direction. Or label every
>> port and allow me to define attributes that group ports.
>>
>> inbount_ssh_port and outbound_ssh_port
> 
> I'm not sure I fully understand the problem you might have with your
> policy.  Portcon doesn't have inbound or outbound labeling
> functionality.  If an admin used this interface to relabel the ports to
> what you described above, would this functionality still break your
> project?
> 
>>
>>> Signed-off-by: Paul Nuzzi <pjnuzzi@tycho.ncsc.mil>
>>>
>>> ---
>>>  security/selinux/hooks.c            |    1
>>>  security/selinux/include/classmap.h |    2
>>>  security/selinux/include/security.h |    9 ++
>>>  security/selinux/selinuxfs.c        |   96 +++++++++++++++++++++
>>>  security/selinux/ss/services.c      |  159 ++++++++++++++++++++++++++++++++++++
>>>  5 files changed, 265 insertions(+), 2 deletions(-)
>>>
> 
> 
Well there is nothing specific about this patch.  We control control most of the network access in SELinux based on wheat ports and
application can bind to, and which ports it can connect to, based on the type of the port.

So you have a rule like 

allow httpd_t http_port_t:tcp_socket name_bind;
allow mozilla_t http_port_t:tcp_socket name_connect;

So if I decide I want apache to only be allowed to bind to port 80, I end up only allowing firefox to connect to port 80.  Which is not what I want.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
