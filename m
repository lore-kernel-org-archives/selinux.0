From: lonnie@outstep.com
To: Stephen Smalley <sds@tislabs.com>
Subject: Re: User Policy Setup
Message-ID: <1008619768.3c1e50f833db3@mail.outstep.com>
Date: Mon, 17 Dec 2001 15:09:28 -0500 (EST)
Cc: SELinux Mailing <SELinux@tycho.nsa.gov>
References: <Pine.GSO.4.33.0112171501191.10304-100000@raven>
In-Reply-To: <Pine.GSO.4.33.0112171501191.10304-100000@raven>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello Stephen,

Thanks for all of you responses to this problem.

My choices were very limited in that I really need to be able to do this, but 
had as my options tht were possible, either SELinux or a security application 
called VXE. (http://www.intes.odessa.ua/vxe/)

The problem is that VXE does not seem to be able to do the job completely and I 
am sure that SELinux might be of greater benefit to the project is it can be 
made to do this.

Actually we have a seperate specialized server set up for SELinux whose sole 
job will be to to handle the task that I have described to you. In this regard, 
then I can modify the entire system as only the special locked down users will 
be on this server and they will only be running the applications from the 
OpenOffice suite.(ie...swriter, simpress, scalc, sweb...)

With this in mind then I am willing to make any modifications to this 
particular server that you, or the group, might suggest.

My biggest problem is really that I am still very new to using SELinux and am 
unclear on many of the things that will need to be done.

Best Regards,
Lonnie
Quoting Stephen Smalley <sds@tislabs.com>:

> 
> On Mon, 17 Dec 2001 lonnie@outstep.com wrote:
> 
> > I am still trying to work out my issues with getting the network
> working as I
> > am getting messages like "cannot send dump request" and "Error adding
> address
> > 192.168.1.5 for eth0".
> 
> Check your kernel configuration for your network driver and your
> network
> options.  Did you enable the Netlink support?  This seems to be
> necessary
> on RH7.2.
> 
> > My question is really about setting up the user policies. I have a
> special
> > project in which I need to confile the users to their HOME directories
> so that
> > they can NEVER navigate out of them. I also need to allow them to run
> just a
> > single application such as StarOffice, but still not let them navigate
> out of
> > their HOME directories even through the application.
> 
> I raised concerns about the practical feasibility of this kind of
> policy
> in my previous response to you.  However, if you really want to go
> down
> this road, you'll need to significantly pare down the example policy.
> You'll want to have a kernel with the Development Module option running
> in
> permissive mode so that you can easily experiment with policy changes
> without breaking your system.
> 
> You'll need to remove many of the file-related rules in
> policy/domains/every.te.  This file contains rules that are applied to
> every domain and assumes a relatively open environment with regard to
> read/search access to standard filesystem locations.  When you remove
> those rules, you'll find that many of the system domains will no
> longer
> have permissions that they need, so you will need to add back more
> specific rules to the individual files in policy/domains/system/*.te
> and
> policy/domains/program/*.te that grant these permissions to just the
> domains that need them.  Then you can work on pruning the user_domain
> macro in policy/domains/user/user.te to something more minimal.
> 
> --
> Stephen D. Smalley, NAI Labs
> ssmalley@nai.com
> 
> 
> 

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
