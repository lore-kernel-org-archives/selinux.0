MIME-Version: 1.0
In-Reply-To: <1275499819.9475.157.camel@moss-pluto.epoch.ncsc.mil>
References: <AANLkTinACSXGyYqwI-cBkQki1PoaKUHK1sDxkKwRHGCE@mail.gmail.com>
	<1275499819.9475.157.camel@moss-pluto.epoch.ncsc.mil>
Date: Wed, 2 Jun 2010 11:23:52 -0700
Message-ID: <AANLkTiluWvZ2tS_FMYXMbi-D9TPTnM4Q65fOaI93Lg9T@mail.gmail.com>
Subject: Re: inaddr_any_node_t?
From: Larry Ross <selinux.larry@gmail.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Selinux <selinux@tycho.nsa.gov>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>,
        Daniel J Walsh <dwalsh@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, Jun 2, 2010 at 10:30 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On Wed, 2010-06-02 at 08:32 -0700, Larry Ross wrote:
>> Where can I find the definition and purpose of "inaddr_any_node_t"?
>>
>> It looks like it matches any port for networking rules but I can't
>> find where it is defined or any documentation on it.  The only place I
>> see it (other than my policy, where it came as the output from
>> audit2allow) is in tmp/all_interfaces.conf
>>
>> Where is it defined?
>>
>> How can I find out what its purpose is and how it works?
>>
>> I am using a customized RHEL5.4 strict policy.
>
> At one time node_inaddr_any_t was defined to be the type for address
> 0.0.0.0 (INADDR_ANY as defined by netinet/in.h and used in bind(2) calls
> to bind to all interfaces), and showed up in node_bind permission checks
> when a process attempted to bind to all interfaces.
>
> I think that modern policy ships without any node context definitions by
> default, deferring that entirely to the admin to configure via semanage
> node or the like, so the type may just be a residual type alias for
> node_t at this point for compatibility.  You should be able to tell by
> looking at the policy sources or by examining the binary policy via apol
> or the like.

Stephen,
  Thank you for your response.  I see this in corenetwork.te in the
RHEL5.3 policy:
nodecon 0.0.0.0 255.255.255.255
gen_context(system_u:object_r:inaddr_any_node_t,s0)

  But I can't see any equivalent in the RHEL5.4 policy, instead it has:
corenetwork.fc
corenetwork.if.in
corenetwork.if.m4
corenetwork.te.in
corenetwork.te.m4
  What are the .in and .m4 files for?  Are these being dynamically
generated at policy build?

corenetwork.te.in contains:
network_node(inaddr_any, s0, 0.0.0.0, 255.255.255.255)
and what looks like some code to label and define the ports.

  I am also wondering how selinux controls access to ports, I am
seeing applications trying to use the "high-numbered" ports for
connections, and somehow policy exists that allows them in some cases,
but not in others, that I can't seem to identify.

  From what I see it looks like any of the ports above 1024 are port_t
unless specifically labeled.  Is that correct?

  Thank you,
  Larry

>
> --
> Stephen Smalley
> National Security Agency
>
>


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
