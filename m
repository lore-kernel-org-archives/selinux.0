Subject: Re: selinux-policy-mls is now available for your testing pleasure.
From: Stephen Smalley <sds@tycho.nsa.gov>
To: James Morris <jmorris@redhat.com>
Cc: Paul Moore <paul.moore@hp.com>, SELinux <SELinux@tycho.nsa.gov>,
   Daniel J Walsh <dwalsh@redhat.com>
In-Reply-To: <Xine.LNX.4.44.0504191827130.17819-100000@thoron.boston.redhat.com>
References: 
	 <Xine.LNX.4.44.0504191827130.17819-100000@thoron.boston.redhat.com>
Content-Type: text/plain
Date: Wed, 20 Apr 2005 08:07:25 -0400
Message-Id: <1113998845.1028.37.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2005-04-19 at 18:29 -0400, James Morris wrote:
> > 12 Rebooted normally, i.e. 'rhgb quiet 5', and X failed to start
> 
> Haven't tried X yet, not sure it's supposed to work.

Works for me.  Of course, you do need to have the allow_execmem=1
boolean enabled for X to run, but that is independent of
MLS.  /usr/sbin/setsebool -P allow_execmem=1.  Did the RPM include a
booleans file?

-- 
Stephen Smalley <sds@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
