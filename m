Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k81NA8Hk026699
	for <selinux@tycho.nsa.gov>; Fri, 1 Sep 2006 19:10:08 -0400
Received: from wx-out-0506.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k81N9m5I006620
	for <selinux@tycho.nsa.gov>; Fri, 1 Sep 2006 23:09:48 GMT
Received: by wx-out-0506.google.com with SMTP id i26so1501989wxd
        for <selinux@tycho.nsa.gov>; Fri, 01 Sep 2006 16:10:08 -0700 (PDT)
Message-ID: <46ffa45f0609011610r1fc3885fp2204df9d6b45415e@mail.gmail.com>
Date: Fri, 1 Sep 2006 18:10:07 -0500
From: "Aleks Kissinger" <aleks0@gmail.com>
To: selinux@tycho.nsa.gov
Subject: Re: Using scripting languages to "macro" policy
In-Reply-To: <1157137351.9799.23.camel@wintermute.xmldesign.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <46ffa45f0609010930h403bf000k6cbf561c1334dfef@mail.gmail.com>
	 <1157137351.9799.23.camel@wintermute.xmldesign.de>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Thanks for all your input.  First, I'd like to address Lorenzo's concerns...


> Ruby is great for text processing, hence it can be a good option to
> write policy-related tools, say, policy browsers, an IDE, etc. I'm
> working myself on such stuff but using it to define the policy itself,
> while "fun" as a prototype it turns to be non scalable at all.
>
> Why? Check out the Ruby VMs out there.
>
> It will lower the performance dramatically. Think about loading
> hundreds of objects on kernel land... it's just insane. As an
> exercise, initialize 200-300 instances of something else similar to an
> existing profile of the current refpolicy. Add all the properties (or
> accessors/attributes now that we are on Ruby coding), etc. Then
> calculate the size on memory and access times (ex. when reading,
> writing, sorting, etc).

I think this may be an overly-pessimistic view of the scalability.
With the current prototype of the system I'm working on, a policy with
about 2000 types and about 60000 AV directives takes a little over a
minute to compile, generating a 38 MB policy.conf.  This is pretty
high overhead for an iterative developement process, but some tweaking
and modularization of the compilation procedure could probably
mitigate these problems.

I'm not quite sure what you mean by objects in kernel land and 200-300
instances of refpolicy, but once the Ruby policy is compiled to FLASK,
the hard work is done.  Then it just remains to push it through
checkpolicy.



>
> You would have to translate everything for using a much lower level
> instruction set.
> Also, such a solution has itself way more dependencies than the
> current one. And in the end you would have to develop and invest much
> more time on something just to find it's not usable.
>

Just one more dep: Ruby.  The base objects are distributed with the
policy itself.

> Disclaimer: I'm a Ruby guy, so to speak. Now I rarely code something
> in other language, except C.
>
> A collaborative policy development tool might be in the works. If you
> are familiar with Rails and interested about it, drop me a line.
>

Sounds interesting.  I've had some (mixed) Rails experiences.  If you
want to shoot me an email about this or point me somewhere with more
information, I'd like that.


*******
Now, in response to Christopher:

> What you're talking about is what I would call policy patterns.  Policy

<snip>

Yes, I took some inspiration for the Ruby arch. by the way refpolicy
structures its abstractions into patterns.


>
> > The idea I put forward here is to create a set of base objects in
> > Ruby, Python, or something of that ilk that can be extended and used
> > to define policy in an organized, error-checking, and namespaced
> > manner.  Heres a quick little example:
> >
> > class LogDir < FileType
> >   pattern '/var/log/.*'
> > end
> >
> > class SomeProgam < Application
> >   executable '/usr/bin/someprog'
> >   allow_role SysadminRole
> >   allow self, LogDir, File, File.perms(:r, :w)
> > end
>
> I'm not sure that this is actually easier, in fact its confusing to me
> (what does :r and :w mean? just read and write?).  It seems like an
> unnecessary abstraction, for example allow_role.


A good point.  Here the semantics are less clear than they could be.
The Ruby policy organizes permissions in a class into permission
"categories".  The existance of these is reflected in some of the
existing macros like file_read_perms, etc. which expand to a list of
permissions that are "read-like".  The :r and :w filter on those
categories.  Or...you can spefify perms explicitly (the File.perms()
call just returns an array of perms), or you can do some array ops to
get the perm set you want. For example:

allow self, self, (Policy::CLASSES-[Security]), '*'
allow self, self, Security, (Security.perms-[:load_policy, :setenforce])


Determining which abstractions are and are not necessary is a hard
task, so I'm not really married to any that I've mentioned.


*******
And Erics comments...


> Hi Aleks,
> When you are planning a different system to write policy, please
> consider that people might want to use tools to edit or automatically
> the policy source. This is already a serious limitation of the current
> M4 policy.
> Russel Coker recently had the example on how to merge two domains into
> one.
> There are conflicts, so it can't be done fully automatic. But you can't
> automate too much with the current M4 policy. It basically boils down to
> doing it all manually. If you want it somewhat automated, you probably
> will have to process the two policy files with M4 and lose all the
> benefits of the macros since you can't go back into pre-M4-processed
> code.


I've had the use of tools in mind from the start.  In fact, as it
stands, you can load the policy up in an interactive, irb shell.  From
there, you can query relationships, alter the policy, and ask
individual components to produce TE/FC output.  For a more
sophisticated tool to leverage this, it would simply need to include a
Ruby interpreter.

>
> It would be very good to have a policy language which does NOT embed
> code.
> Like some XML files for the policy and a set of transformation utilities
> to process them. When done in a good way, the XML policy source files
> could then be processed with all kinds of XML-capable tools, that don't
> need extensive knowledge of the policy.
>

We went down the XML road a couple of years ago.  Hopefully someone
will have success at it, but what we found was that XML proved too
verbose and time-intensive to parse of the volume of policy in what
was available at the time ("strict").



*****
Again, thanks for all your comments.  If any of you are not too
discouraged yet and would like to contribute (or at least see some of
it in action) let me know.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
