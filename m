Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o3SEPMTa013462
	for <selinux@tycho.nsa.gov>; Wed, 28 Apr 2010 10:25:22 -0400
Received: from mail-yw0-f186.google.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id o3SEQPMk027979
	for <selinux@tycho.nsa.gov>; Wed, 28 Apr 2010 14:26:25 GMT
Received: by ywh16 with SMTP id 16so2903539ywh.32
        for <selinux@tycho.nsa.gov>; Wed, 28 Apr 2010 07:25:21 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4BD1B843.1030805@redhat.com>
References: <4BCC69C0.5040502@redhat.com>
	 <t2s10143821004190853r1a114b33q7c9416e43b8b5433@mail.gmail.com>
	 <l2s10143821004200737t683832efu28214c95b3e156c@mail.gmail.com>
	 <4BCF05D3.5090700@redhat.com>
	 <u2q10143821004211853jea20406bz355fc111cd449c47@mail.gmail.com>
	 <4BD0513C.40403@redhat.com>
	 <q2s10143821004220729z2e39b1fdqe16997df0cee0574@mail.gmail.com>
	 <w2q10143821004221216j96faf709w8b702c67835197d6@mail.gmail.com>
	 <4BD1B843.1030805@redhat.com>
Date: Wed, 28 Apr 2010 10:25:21 -0400
Message-ID: <n2g10143821004280725qcf3ebaf8n44eb53504aa32feb@mail.gmail.com>
Subject: Re: refpolicy is missing on lots of hits with audit2allow -R.
From: Karl MacMillan <kmacmillan@tresys.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SELinux <selinux@tycho.nsa.gov>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, Apr 23, 2010 at 11:09 AM, Daniel J Walsh <dwalsh@redhat.com> wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> I do not totally understand your matching, but I thought if you looked for
>
> allow TYPE etc_t:file getattr;
>
> You could get extra matches.
>

That's essentially what I do.

> I was thinking in terms of sepolgen-ifgen would take every type and
> expand the attributes for the type then if you find attribute that
> matches, not add weight.
>

I think you are missing what the core problem is - it's easy to find
interfaces that match this access. Many interfaces (including
files_read_etc_files) include a rule that directly matches getattr on
etc_t files. So I don't really need to do attribute expansion to get
enough matches.

The key problem is finding the _best_ match, which I define as the
interface that allows the requested access with the least amount of
"extra" access. That's what the distance measure is for - it is a
measure of extra access. So I add extra distance for access to
unrelated types, extra permissions, returning a write interface when a
read was requested, etc. So when you add access to a broad attribute
in files_read_etc_files the distance measure - as currently shipped -
adds more distance for 1 type (the attribute). However, when I expand
the attribute the distance goes up because it becomes clear that the
interface is in fact allowing a _lot_ of access.

This seems correct to me, hence my request to return what was intended
to be a narrow interface back to that narrow definition.

However, there are some things that I can do to make this distance
algorithm better:

1. Don't penalize as much for access that involves container object
classes, such as directory, in an attempt to not penalize for access
that is actually related.

2. Detect execute and add a big penalty for interfaces that allow
execute when it wasn't requested (similar to what I do with write).

I'm also open to other suggestions. I don't think that what I have is
perfect. However, none of this will fix the fact that the
files_read_etc_files shipped in Fedora grants broad access. If
everyone agrees that we want that interface to match regardless then I
think we are going to have to add some other mechanism to the matching
algorithm. Perhaps some "hinting" mechanism to let the policy author
to tell sepolgen to prefer certain interfaces. I might even be able to
automatically derive this from how popular the interface is in current
policies.

Karl

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
