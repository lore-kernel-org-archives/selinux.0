Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k222m2sq031359
	for <selinux@tycho.nsa.gov>; Wed, 1 Mar 2006 21:48:02 -0500
Received: from gotham.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k222kW1o011215
	for <selinux@tycho.nsa.gov>; Thu, 2 Mar 2006 02:46:32 GMT
Message-ID: <44065CB2.5080500@tresys.com>
Date: Wed, 01 Mar 2006 21:47:14 -0500
From: Chad Sellers <csellers@tresys.com>
MIME-Version: 1.0
To: Erich Schubert <erich@debian.org>
CC: SE Linux <selinux@tycho.nsa.gov>, Kevin Carr <kcarr@tresys.com>,
        selinux-dev@tresys.com
Subject: Re: FYI SELinux/AppArmor press
References: <43FF7418.90205@redhat.com>	 <1141138934.29803.2.camel@wintermute.xmldesign.de>	 <1141183226.8475.22.camel@localhost.localdomain>	 <1141222338.2834.33.camel@wintermute.xmldesign.de>	 <d82d6db50603011259s3fe0e80duca501a9c7925c661@mail.gmail.com> <1141250441.2834.62.camel@wintermute.xmldesign.de>
In-Reply-To: <1141250441.2834.62.camel@wintermute.xmldesign.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Erich Schubert wrote:
> Hi Benjy,
> 
>>How do these new IDEs that Tresys put out in the last week or so fit
>>into the picture?  Haven't used them, but they appear to be the start
>>of a higher-level approach to developing policy and perhaps more
>>intuitive.  I'm talking about SLIDE (SELinux policy IDE) and the CDS
>>framework IDE tool. 
> 
> 
Erich,

I'm sorry you're having trouble with reference policy and libsemanage.
They're still a work in progress, and will continue to improve in the
near future. We definitely appreciate your efforts to get this working
on Debian, as we want to see this used in as many distributions as
possible. Fedora and Gentoo are a good start, but we'd like to see it
keep spreading.

> They replace vim, if you are developing your policy on a system with
> eclipse installed...
> 
> SLIDE IMHO does not address the issues with the policy language, but it
> just tries to make it a little bit less painful, by basically giving you
> tab completion, reference (like the website did) and a couple of
> templates (like policygentool did). So it likely is a nice tool for
> people who _already_ know how to write policy by heart.
> 
> Have a look for example at
> http://selinux-ide.sourceforge.net/images/screenshots/completion.png
> well, it's nice syntax highlighting, and you have a dropdown to select
> the macros. But that doesn't really help you finding the appropriate
> macros, or explain what ever "generic files in library directories"
> might be. Or help you finding out whether you might need it.
> There are approximately 1600 interfaces, not counting the generated
> network port and interface macros. Even given the hierarchy represented
> by {admin,services,...} and convetions like files_ etc. names this is
> probably more than most people can handle.
> 
Reference policy is less painful, but the mechanisms it provides are the
real power that will allow us to make things easier. We've been trying
to make policy development easier for some time, and we eventually
realized that we couldn't do it without better structure in the policy.
Now that we're starting to have that structure, we can use that to build
higher-level abstractions. These can be as simple as more abstract
interfaces or as complex as higher-level languages and tools. The CDS
Framework is one early example of this which is fairly specific to a
given environment.

SLIDE is a very early version of a reference policy IDE (that's why it's
version 0.1). We're hoping to make it much easier to use over time, but
we wanted to develop it in the open-source so that we could at least get
continuous feedback on it. Even at 0.1, we've gotten some very positive
feedback regarding the features that it does provide.

> I can't say much about CDS: the website gives so few details, you can
> barely tell what it is _meant_ to be, not to say what it's capable of. I
> just don't have the time to download the sourcecode and try it. The
> screenshot appears pretty at first sight, but there is nothing on it how
> this interfaces with other parts of the system and other services -
> which is exactly where it gets messy and complicated... Stuff like
> allowing DNS usage, access to locales. Using the perl interpreter, or
> python. Reading /etc/resolv.conf. Some of this has matching interfaces
> already, some has not.
> 
Just to fill in some of the details here, CDS Framework does have
provisions for linking to the base system. I'm sorry that it is
currently not very well documented. There is actually a paper being
presented at the SELinux Symposium tomorrow on our experiences
implementing the CDS Framework language, including the difficulties with
linking to a base system. I'll make sure at least the presentation makes
it to the web.

Thanks,
Chad

-- 

----------------------
Chad Sellers
Tresys Technology, LLC
http://www.tresys.com


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
