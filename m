Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o3SHrERq026223
	for <selinux@tycho.nsa.gov>; Wed, 28 Apr 2010 13:53:17 -0400
Received: from mail-yw0-f186.google.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id o3SHsIdF012002
	for <selinux@tycho.nsa.gov>; Wed, 28 Apr 2010 17:54:18 GMT
Received: by ywh16 with SMTP id 16so3036066ywh.32
        for <selinux@tycho.nsa.gov>; Wed, 28 Apr 2010 10:53:16 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4BD85592.10201@redhat.com>
References: <4BCC69C0.5040502@redhat.com>
	 <l2s10143821004200737t683832efu28214c95b3e156c@mail.gmail.com>
	 <4BCF05D3.5090700@redhat.com>
	 <u2q10143821004211853jea20406bz355fc111cd449c47@mail.gmail.com>
	 <4BD0513C.40403@redhat.com>
	 <q2s10143821004220729z2e39b1fdqe16997df0cee0574@mail.gmail.com>
	 <w2q10143821004221216j96faf709w8b702c67835197d6@mail.gmail.com>
	 <4BD1B843.1030805@redhat.com>
	 <n2g10143821004280725qcf3ebaf8n44eb53504aa32feb@mail.gmail.com>
	 <4BD85592.10201@redhat.com>
Date: Wed, 28 Apr 2010 13:53:15 -0400
Message-ID: <g2r10143821004281053vdc0263bfh605a3e3cc19f7571@mail.gmail.com>
Subject: Re: refpolicy is missing on lots of hits with audit2allow -R.
From: Karl MacMillan <kmacmillan@tresys.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SELinux <selinux@tycho.nsa.gov>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, Apr 28, 2010 at 11:34 AM, Daniel J Walsh <dwalsh@redhat.com> wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> On 04/28/2010 10:25 AM, Karl MacMillan wrote:
>> On Fri, Apr 23, 2010 at 11:09 AM, Daniel J Walsh <dwalsh@redhat.com> wrote:
>>> -----BEGIN PGP SIGNED MESSAGE-----
>>> Hash: SHA1
>>>
>>> I do not totally understand your matching, but I thought if you looked for
>>>
>>> allow TYPE etc_t:file getattr;
>>>
>>> You could get extra matches.
>>>
>>
>> That's essentially what I do.
>>
>>> I was thinking in terms of sepolgen-ifgen would take every type and
>>> expand the attributes for the type then if you find attribute that
>>> matches, not add weight.
>>>
>>
>> I think you are missing what the core problem is - it's easy to find
>> interfaces that match this access. Many interfaces (including
>> files_read_etc_files) include a rule that directly matches getattr on
>> etc_t files. So I don't really need to do attribute expansion to get
>> enough matches.
>>
>> The key problem is finding the _best_ match, which I define as the
>> interface that allows the requested access with the least amount of
>> "extra" access. That's what the distance measure is for - it is a
>> measure of extra access. So I add extra distance for access to
>> unrelated types, extra permissions, returning a write interface when a
>> read was requested, etc. So when you add access to a broad attribute
>> in files_read_etc_files the distance measure - as currently shipped -
>> adds more distance for 1 type (the attribute). However, when I expand
>> the attribute the distance goes up because it becomes clear that the
>> interface is in fact allowing a _lot_ of access.
>>
>> This seems correct to me, hence my request to return what was intended
>> to be a narrow interface back to that narrow definition.
>>
>> However, there are some things that I can do to make this distance
>> algorithm better:
>>
>> 1. Don't penalize as much for access that involves container object
>> classes, such as directory, in an attempt to not penalize for access
>> that is actually related.
>>
>> 2. Detect execute and add a big penalty for interfaces that allow
>> execute when it wasn't requested (similar to what I do with write).
>>
>> I'm also open to other suggestions. I don't think that what I have is
>> perfect. However, none of this will fix the fact that the
>> files_read_etc_files shipped in Fedora grants broad access. If
>> everyone agrees that we want that interface to match regardless then I
>> think we are going to have to add some other mechanism to the matching
>> algorithm. Perhaps some "hinting" mechanism to let the policy author
>> to tell sepolgen to prefer certain interfaces. I might even be able to
>> automatically derive this from how popular the interface is in current
>> policies.
>>
>> Karl
>
> I understand, although I don't agree with penalizying because you match
> on an attribute,   Currently if I wrote this interface the way I want,
> with just the attribute your algorithm would not find it at all.
>

I'm not penalizing because it's an attribute, it's just that the
penalty is for every extra type so attributes are going to tend to add
a lot of weight.

> files_read_etc_files to me means match all config files in the /etc
> directory, just because some random application decides to change the
> context of /etc/hostname to etc_runtime_t or net_conf_t, we should not
> need to change all domains that are supposed to read generic files in
> /etc.  Especially when I don't even need to read them.
>
>
> I would argue that
>
> allow X etc_t:file read;
> allow X configfile:file read;
>
> Should be weighted equivalently if etc_t is a configfile or only
> slightly heavier, and just because etc_runtime_t or some other random
> types are configfile does not mean we need to add weight.
>

This seems like mostly a policy design question and I'd be curious to
hear what others think as well. I agree that broad read access to
configuration files is not much of a risk for general Linux systems.
However, if I change the weighting algorithm to not worry about broad
read access my concern is for matching interfaces that allow broad
read access to files when the concern is confidentiality. Currently
there is no clear way to infer security goals beyond read, write, and
maybe exec so there is no way to categorize types as mainly for
integrity vs. confidentiality.

Thoughts? What about creating some hints based upon attributes? Or
what about favoring the most commonly used interfaces?

> But when the attribute adds more weight then "write" does, I think the
> algorithm is broken.

I can certainly try to greatly reduce the weighting from extraneous
types and increase the weighting for write or execute vs. read. I'll
try to experiment a bit and see what I can come up with.

What would really help me the most is if you could start collecting
audit messages that give both good and bad results from audit2allow. I
need some well known test cases to tune the weighting algorithm.

Karl

> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v2.0.14 (GNU/Linux)
> Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/
>
> iEYEARECAAYFAkvYVZEACgkQrlYvE4MpobPf6QCfY6wAi3VqF9s3do7QwAoQ8UrA
> PZwAoN5L0WvquabGFHNfINoJq4MkOy8S
> =l2u0
> -----END PGP SIGNATURE-----
>
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
>


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
