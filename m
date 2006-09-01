Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k81IWgoH018766
	for <selinux@tycho.nsa.gov>; Fri, 1 Sep 2006 14:32:42 -0400
Received: from ug-out-f131.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k81IWMIk006178
	for <selinux@tycho.nsa.gov>; Fri, 1 Sep 2006 18:32:22 GMT
Received: by ug-out-f131.google.com with SMTP id 2so14722ugc
        for <selinux@tycho.nsa.gov>; Fri, 01 Sep 2006 11:32:41 -0700 (PDT)
Message-ID: <59ad41340609011132l7ea204cfp575dd6c14df67f5d@mail.gmail.com>
Date: Fri, 1 Sep 2006 20:32:40 +0200
From: "=?ISO-8859-1?Q?Lorenzo_Hern=E1ndez_Garc=EDa-Hierro?=" <lorenzohgh@tuxedo-es.org>
Reply-To: lorenzo@tuxedo-es.org
To: "Aleks Kissinger" <aleks0@gmail.com>
Subject: Re: Using scripting languages to "macro" policy
Cc: selinux@tycho.nsa.gov
In-Reply-To: <46ffa45f0609010930h403bf000k6cbf561c1334dfef@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <46ffa45f0609010930h403bf000k6cbf561c1334dfef@mail.gmail.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 9/1/06, Aleks Kissinger <aleks0@gmail.com> wrote:
> I've been poking around with the idea of using Ruby and some
> meta-programming to specify policy.  The complaint I've heard voiced
> by a couple of people is that while many of the m4-based abstractions
> present in refpolicy are pretty intuitive and useful, the limitation
> of m4 as a language is that you cannot maintain relationships and
> resolve conflicts automatically.  Therefore, in many cases you need to
> result to naming conventions to do that work.
>
> The idea I put forward here is to create a set of base objects in
> Ruby, Python, or something of that ilk that can be extended and used
> to define policy in an organized, error-checking, and namespaced
> manner.  Heres a quick little example:
>
> class LogDir < FileType
>   pattern '/var/log/.*'
> end
>
> class SomeProgam < Application
>   executable '/usr/bin/someprog'
>   allow_role SysadminRole
>   allow self, LogDir, File, File.perms(:r, :w)
> end
>
> This expands to all the relevant TE & FC statements.  'executable'
> generates the someprogram_exec_t type and all needed type transitions
> and allows, 'allow_role' looks up types associated with the role and
> generates relevant allows and transitions.  The 'allow' statement
> works pretty much as expected, except that the FLASK class File is an
> actual Ruby class, with the ability to filter on permission
> categories, etc.
>
> This system isn't meant to replace all the work thats gone in to
> existing policies, nor does it set out to be a policy language of its
> own like existing high-level lanaguage work, but I think it would make
> an interesting little project.  Ideas, comments, suggestions,
> criticisms, etc. would be appreciated.

Ruby is great for text processing, hence it can be a good option to
write policy-related tools, say, policy browsers, an IDE, etc. I'm
working myself on such stuff but using it to define the policy itself,
while "fun" as a prototype it turns to be non scalable at all.

Why? Check out the Ruby VMs out there.

It will lower the performance dramatically. Think about loading
hundreds of objects on kernel land... it's just insane. As an
exercise, initialize 200-300 instances of something else similar to an
existing profile of the current refpolicy. Add all the properties (or
accessors/attributes now that we are on Ruby coding), etc. Then
calculate the size on memory and access times (ex. when reading,
writing, sorting, etc).

You would have to translate everything for using a much lower level
instruction set.
Also, such a solution has itself way more dependencies than the
current one. And in the end you would have to develop and invest much
more time on something just to find it's not usable.

Disclaimer: I'm a Ruby guy, so to speak. Now I rarely code something
in other language, except C.

A collaborative policy development tool might be in the works. If you
are familiar with Rails and interested about it, drop me a line.

Cheers.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
