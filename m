Message-ID: <3B7D75C0.23A2B9C9@earthlink.net>
Date: Fri, 17 Aug 2001 12:51:28 -0700
From: John Scroggins <dataefx@earthlink.net>
MIME-Version: 1.0
To: Conan Callen <ccallen@windowpane.com>
CC: "SELinux@tycho.nsa.gov" <SELinux@tycho.nsa.gov>,
        Christopher Mahmood <ckm@suse.com>
Subject: Re: Partial TOC for Comment]
References: <3B7C7C69.E7B84C68@earthlink.net> <003f01c12746$e02faf60$3a8314d1@nwlink.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> Conan Callen wrote:
> 
> More on supported scenarios -
> 
> As an example of the "Supported Scenario" idea is this:

hmm.. sounds interesting.. good idea, I'll add that as a heading
9hopefully we will be able to fill it out ..;) 
> 
> The Redhat 7.1 Linux installer gives you the following choices:
> Workstation
> Server
> Laptop
> Custom System

I can leave a placeholder for laptops, but the primary focus will start
like this: servers --> workstations --> custom deployments 

> It also allows you to choose your firewall settings.
> Of coursed, depending upon what you select, the installer will place
> different components onto your system. A list of supported scenarios
> would also helps to limit the scope of customer support. When
> contacting redhat for support, I would imagine that the first thing
> they ask you is which sku you selected.

This sounds close to a distro specific guide, e.g. SELinux for RedHat
7.x Administrator Guide.. since the NSA has provided a source package, I
tend toward staying with a generic application. I would not want to box
some one into a distro descision.  


> These represent what most people will be interested in over the next
> year or so. Supporting just this set would help to limit the scope of
> SELinux,

agreed ..  

> and the amount of work that the dev's need to do. I dont know
> if there is an installer for SELinux (just finished the redhat install
> at last night) but if would be convienent if there was an install had
> a selection menu like the above list.

This is something I would like to do, but I am not skilled in this area
.. this is your chance to volunteer....  :)

 Has anyone considered wraping
> selinux into an rpm package?

Due to the fact SELinux is supposed to be secure, I will not support
.rpm installation documeentation in the guide. :( 
I am suggesting the package be built with installer which runs from a
shell (i.e., installSEL.sh)..I find no confidence in deploying a binary
type kernel package in a secure environ. Building from source is not an
option, at least in my mind.. I could be wrong .... let me know 

-- Cheers 

--JS  

> 
> Transactions on Software Engineering (Dec 1998, V24, N12) This is a
> special issue on the topic of using scenarios to determine
> requirements.
> 
> Conan

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
