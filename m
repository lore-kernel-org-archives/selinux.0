Subject: Re: inaddr_any_node_t?
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Larry Ross <selinux.larry@gmail.com>
Cc: Selinux <selinux@tycho.nsa.gov>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>,
        Daniel J Walsh <dwalsh@redhat.com>
In-Reply-To: <AANLkTiluWvZ2tS_FMYXMbi-D9TPTnM4Q65fOaI93Lg9T@mail.gmail.com>
References: <AANLkTinACSXGyYqwI-cBkQki1PoaKUHK1sDxkKwRHGCE@mail.gmail.com>
	 <1275499819.9475.157.camel@moss-pluto.epoch.ncsc.mil>
	 <AANLkTiluWvZ2tS_FMYXMbi-D9TPTnM4Q65fOaI93Lg9T@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 02 Jun 2010 15:40:01 -0400
Message-ID: <1275507601.9475.189.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2010-06-02 at 11:23 -0700, Larry Ross wrote:
> On Wed, Jun 2, 2010 at 10:30 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> Stephen,
>   Thank you for your response.  I see this in corenetwork.te in the
> RHEL5.3 policy:
> nodecon 0.0.0.0 255.255.255.255
> gen_context(system_u:object_r:inaddr_any_node_t,s0)
> 
>   But I can't see any equivalent in the RHEL5.4 policy, instead it has:
> corenetwork.fc
> corenetwork.if.in
> corenetwork.if.m4
> corenetwork.te.in
> corenetwork.te.m4
>   What are the .in and .m4 files for?  Are these being dynamically
> generated at policy build?

corenetwork is special.  The .in and .m4 files are the actual source
files; the .te and .if files are generated when you run make conf.

> corenetwork.te.in contains:
> network_node(inaddr_any, s0, 0.0.0.0, 255.255.255.255)
> and what looks like some code to label and define the ports.
> 
>   I am also wondering how selinux controls access to ports, I am
> seeing applications trying to use the "high-numbered" ports for
> connections, and somehow policy exists that allows them in some cases,
> but not in others, that I can't seem to identify.

apol may help you.

>   From what I see it looks like any of the ports above 1024 are port_t
> unless specifically labeled.  Is that correct?

If there is no matching portcon entry for a given port, then the kernel
defaults to using the context associated with the "port" initial SID as
specified by the "sid port" line in corenetwork.te.in.  Which happens to
be port_t.  So, yes.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
