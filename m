Subject: Re: Restorecon script
From: Ivan Gyurdiev <gyurdiev@redhat.com>
Reply-To: gyurdiev@redhat.com
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Daniel J Walsh <dwalsh@redhat.com>, SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <1118416713.3774.108.camel@moss-spartans.epoch.ncsc.mil>
References: <1118328119.29360.4.camel@dhcp83-8.boston.redhat.com>
	 <1118416713.3774.108.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Fri, 10 Jun 2005 13:52:24 -0400
Message-Id: <1118425944.3720.7.camel@dhcp83-8.boston.redhat.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2005-06-10 at 11:18 -0400, Stephen Smalley wrote:
> On Thu, 2005-06-09 at 10:41 -0400, Ivan Gyurdiev wrote:
> > Any comments on the following script?
> > It's a profile script, to be shipped with selinux-policy-strict, 
> > executed per login shell. It hardcodes the applications, 
> > unfortunately, but does what we want for right now 
> > (at least a temp. solution, unless someone has a better one?)
> > Also, user needs to start a login shell to get it to run.
> 
> There are a number of other directories under $HOME that likewise have
> derived types, e.g.
> $HOME/.ssh
> $HOME/.gnupg
> $HOME/.gconf
> $HOME/.gconfd
> $HOME/public_html

file_type_auto_trans is sufficient to handle those at this time. 
We can add them one at a time, when transition conflicts arise.

> and some individual files like $HOME/.Xauthority.

Is .Xauthority created in a library, other than xauth?
It hasn't created any problems so far, so I've ignored it.

On the other hand, I know ICEauthority is created in libICE,
and that's currently broken, since I set its context to
ROLE_iceauth_home_t - for example gnome_session (one of
the two apps that appear to be relying on ICE), stores
files there, using libICE, and they're set to ROLE_home_t,
since that transition takes precedence. Perhaps the ICEauth
files should be moved to a subdirectory?



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
