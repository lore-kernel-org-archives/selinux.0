Message-ID: <005501c12758$95f6cf70$3a8314d1@nwlink.com>
Reply-To: "Conan Callen" <ccallen@windowpane.com>
From: "Conan Callen" <ccallen@windowpane.com>
To: "John Scroggins" <dataefx@earthlink.net>
Cc: <SELinux@tycho.nsa.gov>, "\"Christopher Mahmood\"" <ckm@suse.com>
References: <3B7C7C69.E7B84C68@earthlink.net> <003f01c12746$e02faf60$3a8314d1@nwlink.com> <3B7D75C0.23A2B9C9@earthlink.net>
Subject: Re: Partial TOC for Comment]
Date: Fri, 17 Aug 2001 13:09:56 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

.. this is your chance to volunteer....  :)

In the early 90's, I maintained a kornshell based installer for a unix
product (cim21 by Industrial Systems, bought up by AspenTech). That was a
while ago, but after I get my server up and running (and get SELinux
installed :) It had two parts, one would pull all the required files out of
the build tree and tar them up, and second part was the actual installer. I
rember much of how it was written, I think the key was the configuration
files. Once I get the fires under control I can play around with it.

On a different topic (installing linux and immediatly getting cracked):
An interesting note. As soon as I finished installing Linux lastnight, I
noticed the hard drive start whirling like someone was there doing searches
of my hard drive. This morning I got the same thing. I ran ps -aux and could
see a process as root running a something like ls | awk ... looking for
different things. I didnt take time to write it down, I just shut the
machine down.

It appears that as soon as I was done installing the system it was
compromised. It made me think that there must be hundreds / thousands of
people installing linux everyday and have the same thing happen and dont
even realize it. Its like the machine puts out a message to the internet as
soon as you turn it on "please, come hack me!"

Im in the process of locking the machine down now. I stared by pulling the
ethernet cable. Does SELinux help to make it tougher for the crackers to
gain access like this? Know of any good webpages / books on how to get
started (steps) on locking down a system, and creating scripts to monitor
the system?

Conan

----- Original Message -----
From: "John Scroggins" <dataefx@earthlink.net>
To: "Conan Callen" <ccallen@windowpane.com>
Cc: <SELinux@tycho.nsa.gov>; "Christopher Mahmood" <ckm@suse.com>
Sent: Friday, August 17, 2001 12:51 PM
Subject: Re: Partial TOC for Comment]


> > Conan Callen wrote:
> >
> > More on supported scenarios -
> >
> > As an example of the "Supported Scenario" idea is this:
>
> hmm.. sounds interesting.. good idea, I'll add that as a heading
> 9hopefully we will be able to fill it out ..;)
> >
> > The Redhat 7.1 Linux installer gives you the following choices:
> > Workstation
> > Server
> > Laptop
> > Custom System
>
> I can leave a placeholder for laptops, but the primary focus will start
> like this: servers --> workstations --> custom deployments
>
> > It also allows you to choose your firewall settings.
> > Of coursed, depending upon what you select, the installer will place
> > different components onto your system. A list of supported scenarios
> > would also helps to limit the scope of customer support. When
> > contacting redhat for support, I would imagine that the first thing
> > they ask you is which sku you selected.
>
> This sounds close to a distro specific guide, e.g. SELinux for RedHat
> 7.x Administrator Guide.. since the NSA has provided a source package, I
> tend toward staying with a generic application. I would not want to box
> some one into a distro descision.
>
>
> > These represent what most people will be interested in over the next
> > year or so. Supporting just this set would help to limit the scope of
> > SELinux,
>
> agreed ..
>
> > and the amount of work that the dev's need to do. I dont know
> > if there is an installer for SELinux (just finished the redhat install
> > at last night) but if would be convienent if there was an install had
> > a selection menu like the above list.
>
> This is something I would like to do, but I am not skilled in this area
> .. this is your chance to volunteer....  :)
>
>  Has anyone considered wraping
> > selinux into an rpm package?
>
> Due to the fact SELinux is supposed to be secure, I will not support
> .rpm installation documeentation in the guide. :(
> I am suggesting the package be built with installer which runs from a
> shell (i.e., installSEL.sh)..I find no confidence in deploying a binary
> type kernel package in a secure environ. Building from source is not an
> option, at least in my mind.. I could be wrong .... let me know
>
> -- Cheers
>
> --JS
>
> >
> > Transactions on Software Engineering (Dec 1998, V24, N12) This is a
> > special issue on the topic of using scenarios to determine
> > requirements.
> >
> > Conan
>


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
