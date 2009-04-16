Date: Thu, 16 Apr 2009 15:54:31 -0400
Subject: Re: access(2) vs. SELinux
From: Chad Sellers <csellers@tresys.com>
To: Eric Paris <eparis@redhat.com>, Stephen Smalley <sds@tycho.nsa.gov>
CC: <selinux@tycho.nsa.gov>, James Morris <jmorris@namei.org>,
        Eric Paris <eparis@parisplace.org>, Daniel J Walsh <dwalsh@redhat.com>
Message-ID: <C60D0537.A684E%csellers@tresys.com>
In-Reply-To: <1239905439.3722.11.camel@localhost.localdomain>
Mime-version: 1.0
Content-type: text/plain;
	charset="US-ASCII"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 4/16/09 2:10 PM, "Eric Paris" <eparis@redhat.com> wrote:
> 
> He's some concerns/thoughts.
> 
> domain_t calls access(W_OK) on file_t.
> 
> This generates a denial
> 
> denied  { access_write } scontext=domain_t tcontext=file_t tclass=file
> 
> Which audit2allow will gladly turn into:
> 
> allow domain_t file_t:file { access_write }
> 
> Load that module and then, POP the next time
> 
> denied { write } scontext=domain_t tcontext=file_t tclass=file
> 
> So somewhere we need some sort of synchronization.
> 
> ---
> 
> I suggested to Dan that audit2allow should should, given the above
> access_write denial output:
> allow domain_t file_t:file { write }
> 
> and the tool chain just automatically maps all write rule to both allow
> bits for BOTH write and access_write.
> 
> ---
> 
> We could also have the tool chain just run in both directions and leave
> audit2allow alone.  Any rule with access_write would cause the tool
> chain to add write and any rule with write would cause us to add
> access_write.
> 
>> From the point of view of policy analysis I think think that makes
> things worse.  Now the access_write rule really means something.  That's
> fine with me, but I have a feeling the people who care about policy
> analysis might not like that idea.....
> 
I think these issues point to how inelegant this solution is. Relying on the
toolchain to special case this and modify all results is going to be
painful. Another example of this comes up when applying analysis tools to
the policy. SETools will now show rules in a binary policy that can only be
traced back to the source policy if you understand how the compiler mangling
works. Managed policy has allowed us to decrease the amount of policy
mangling we do, and this strategy seems to be going the other direction.

I'd like to put in a vote for having access call the _noaudit interface to
suppress the audit record. I agree with Alexey though that it would need to
have something in /selinux to toggle this on/off. Then, when debugging a
policy and not getting denials, you'd throw this switch when to the point of
disabling dontaudits. We could even have semodule -D toggle this as well, if
we really want to bake this into the toolchain somewhere. As far as probing
attacks go, systems with more stringent security requirements that want to
see all possible probing attacks could turn this flag on all the time.

Thanks,
Chad




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
