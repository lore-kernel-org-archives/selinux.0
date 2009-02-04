MIME-Version: 1.0
In-Reply-To: <1232132620.13917.109.camel@localhost.localdomain>
References: <5ab9a20b0901160943o14c1d47csbc763ae31564b97b@mail.gmail.com>
	 <1232132620.13917.109.camel@localhost.localdomain>
Date: Wed, 4 Feb 2009 15:52:10 -0500
Message-ID: <5ab9a20b0902041252l7041062fqc7202db633bb2141@mail.gmail.com>
Subject: Re: Base module, modules.conf
From: Cheyenne Solo <ayla.cheyenne@gmail.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov, Daniel J Walsh <dwalsh@redhat.com>
Content-Type: multipart/alternative; boundary=001636283b0a2f5a5f04621df6c1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--001636283b0a2f5a5f04621df6c1
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

On Fri, Jan 16, 2009 at 2:03 PM, Stephen Smalley <sds@tycho.nsa.gov> wrote:

> On Fri, 2009-01-16 at 12:43 -0500, Cheyenne Solo wrote:
> > Hello list,
> >
> > This is my first time writing to the list, and I'm an SELinux newbie.
> >
> > I'm trying to do some experiments on SELinux that require me to
> > replace the base module.
>
> Can you explain why?  Often it turns out that people can in fact do what
> they want without replacing the base module these days (particularly
> given the merge of strict and targeted policies), so it would be good to
> first double check that you truly need to do this.


You're quite right; after more fiddling and thinking I've found I can do
what I want (and it's better to do so anyway) with the base policy intact.
I've started using Fedora 7 so I can use the strict policy and its user
mapping capabilities for my (A)RBAC experimentation. While I would still
like to be able to modify the base policy, I can do without.

I have hit a different roadblock, however, dealing with custom user
mappings: I cannot get users I've created to map to SELinux users I've
defined. I've declared the users and their roles and types in a module that
I have installed into the policy. When I added mappings to
/etc/selinux/strict/seusers , either by hand or with semanage, the user ends
up with the context system_u:system_r:xdm_t:SystemHigh-SystemLow. I have
files in the /etc/selinux/strict/contexts/users/ directory for each user and
have put the types and roles appropriately in the default_type file.

How does the login process really determine these mappings, and why would
all of my custom mappings be redirected to system_u:system_r:xdm_t? I am
quite puzzled.

Thanks,
Ayla

--001636283b0a2f5a5f04621df6c1
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br><br><div class=3D"gmail_quote">On Fri, Jan 16, 2009 at 2:03 PM, Stephen=
 Smalley <span dir=3D"ltr">&lt;<a href=3D"mailto:sds@tycho.nsa.gov" target=
=3D"_blank">sds@tycho.nsa.gov</a>&gt;</span> wrote:<br><blockquote class=3D=
"gmail_quote" style=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0=
pt 0pt 0pt 0.8ex; padding-left: 1ex;">

<div>On Fri, 2009-01-16 at 12:43 -0500, Cheyenne Solo wrote:<br>
&gt; Hello list,<br>
&gt;<br>
&gt; This is my first time writing to the list, and I&#39;m an SELinux newb=
ie.<br>
&gt;<br>
&gt; I&#39;m trying to do some experiments on SELinux that require me to<br=
>
&gt; replace the base module.<br>
<br>
</div>Can you explain why? &nbsp;Often it turns out that people can in fact=
 do what<br>
they want without replacing the base module these days (particularly<br>
given the merge of strict and targeted policies), so it would be good to<br=
>
first double check that you truly need to do this.</blockquote><div><br>You=
&#39;re quite right; after more fiddling and thinking I&#39;ve found I can =
do what I want (and it&#39;s better to do so anyway) with the base policy i=
ntact. I&#39;ve started using Fedora 7 so I can use the strict policy and i=
ts user mapping capabilities for my (A)RBAC experimentation. While I would =
still like to be able to modify the base policy, I can do without.<br>

<br>I have hit a different roadblock, however, dealing with custom user map=
pings: I cannot get users I&#39;ve created to map to SELinux users I&#39;ve=
 defined. I&#39;ve declared the users and their roles and types in a module=
 that I have installed into the policy. When I added mappings to /etc/selin=
ux/strict/seusers , either by hand or with semanage, the user ends up with =
the context system_u:system_r:xdm_t:SystemHigh-SystemLow. I have files in t=
he /etc/selinux/strict/contexts/users/ directory for each user and have put=
 the types and roles appropriately in the default_type file. <br>
<br>How does the login process really determine these mappings, and why wou=
ld all of my custom mappings be redirected to system_u:system_r:xdm_t? I am=
 quite puzzled.<br>
</div></div><br>Thanks,<br>Ayla<br>

--001636283b0a2f5a5f04621df6c1--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
