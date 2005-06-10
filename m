Date: Fri, 10 Jun 2005 21:23:39 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Ivan Gyurdiev <gyurdiev@redhat.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, Daniel J Walsh <dwalsh@redhat.com>,
   SELinux <selinux@tycho.nsa.gov>
Subject: Re: Restorecon script
Message-ID: <20050610202339.GD8525@lkcl.net>
References: <1118328119.29360.4.camel@dhcp83-8.boston.redhat.com> <1118416713.3774.108.camel@moss-spartans.epoch.ncsc.mil> <1118425944.3720.7.camel@dhcp83-8.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1118425944.3720.7.camel@dhcp83-8.boston.redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, Jun 10, 2005 at 01:52:24PM -0400, Ivan Gyurdiev wrote:

> since that transition takes precedence. Perhaps the ICEauth
> files should be moved to a subdirectory?

 definitely.  however, as described in my other post just now,
 /tmp/.ICE-unix has "legacy" apps that need to be transitioned over
 to utilise a new directory.

 l.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
