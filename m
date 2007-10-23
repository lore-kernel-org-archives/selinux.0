Message-ID: <471E1387.40100@redhat.com>
Date: Tue, 23 Oct 2007 11:30:15 -0400
From: Colin Walters <walters@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        SELinux Mail List <selinux@tycho.nsa.gov>
Subject: Re: SE-DBUS policy
References: <1193143580.9466.47.camel@gorn> <1193145875.2179.21.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1193145875.2179.21.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> On Tue, 2007-10-23 at 12:46 +0000, Christopher J. PeBenito wrote:
>   
>> Is there any documentation on the SELinux behavior on dbus?  From some
>> discussion in the IRC channel, the policy templates (which is still
>> basically the NSA example policy stuff) don't match the code.
>>
>> The templates creates a type:
>>
>> type [connector domain prefix]_dbusd_[bus owner prefix]_t;
>>
>> so if you have staff_r's connection to the system bus, you get
>> staff_dbusd_system_t.  Then there is a type_change so dbus knows what
>> label to give the connection:
>>
>> type_change [domain] [bus owner prefix]_dbusd_t:dbus [connector type];
>>
>> which results in something like this:
>>
>> type user_mozilla_dbusd_system_t;
>> type_change user_mozilla_t system_dbusd_t:dbus user_mozilla_dbusd_system_t;
>>
>> Then based on the template, I believe the premise was that the dbus
>> permissions would be between these derived types.  However, in the
>> policy there are no dbus:send_msg rules for these types (except for the
>> ones given in the templates), and instead rules are against the real
>> domains, (e.g. allow NetworkManager_t dhcpd_t:dbus send_msg;).  So I
>> looked in the dbus code, and I didn't see any calls to
>> security_compute_relabel().  It looks like this bit of policy is dead,
>> and the templates need to be revised.
>>     
>
> Hmm...I see a post by Colin Walters back in Oct 2004 to add such logic
> to dbusd along with the corresponding policy patches, but no evidence
> that the code was ever merged.  I also see at least one other patch from
> Colin that added further dbus permissions, again with no evidence that
> it was ever merged.
>
> As far as I know, the dbus-daemon man page is the best documentation on
> the SELinux behavior in dbus - it has a description of the configuration
> for dbus contexts as well as the checks applied by SELinux.  Hopefully
> it is still up to date.
>
>   
I vaguely recall that at the time I was prototyping things out, and 
seeing what interest there was in the patches.  It could probably be 
revived if there was sufficient interest; we should step through the use 
cases for them.  The current :dbus object class is coarse but you can do 
quite a bit with it.

I think you're right though that the policy should probably drop the 
macros until support for it is included in D-BUS and widely distributed.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
