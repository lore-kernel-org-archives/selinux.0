Subject: Re: Restorecon script
From: Ivan Gyurdiev <gyurdiev@redhat.com>
Reply-To: gyurdiev@redhat.com
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, Daniel J Walsh <dwalsh@redhat.com>,
   SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <20050610202339.GD8525@lkcl.net>
References: <1118328119.29360.4.camel@dhcp83-8.boston.redhat.com>
	 <1118416713.3774.108.camel@moss-spartans.epoch.ncsc.mil>
	 <1118425944.3720.7.camel@dhcp83-8.boston.redhat.com>
	 <20050610202339.GD8525@lkcl.net>
Content-Type: text/plain
Date: Fri, 10 Jun 2005 17:59:08 -0400
Message-Id: <1118440748.4812.71.camel@dhcp83-8.boston.redhat.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2005-06-10 at 21:23 +0100, Luke Kenneth Casson Leighton wrote:
> On Fri, Jun 10, 2005 at 01:52:24PM -0400, Ivan Gyurdiev wrote:
> 
> > since that transition takes precedence. Perhaps the ICEauth
> > files should be moved to a subdirectory?
> 
>  definitely.  however, as described in my other post just now,
>  /tmp/.ICE-unix has "legacy" apps that need to be transitioned over
>  to utilise a new directory.

Do you know which applications exactly use ICE?
I've only seen gnome-session and dcop so far (and
then a lot of applications that talk to 
gnome-session/dcop over ICE)




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
