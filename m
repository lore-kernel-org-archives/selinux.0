Subject: Re: More patches
From: Ivan Gyurdiev <gyurdiev@redhat.com>
Reply-To: gyurdiev@redhat.com
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <1121697080.32546.32.camel@moss-spartans.epoch.ncsc.mil>
References: <1121455871.10134.21.camel@celtics.boston.redhat.com>
	 <1121697080.32546.32.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Mon, 18 Jul 2005 10:54:59 -0400
Message-Id: <1121698499.3432.0.camel@celtics.boston.redhat.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> > The following patch makes restorecon use standard output 
> > for displaying status information, which will make it
> > easier to handle failure in our startup script.
> > 
> > policycoreutils-restorecon-stdout.diff
> 
> Hmm...why not just use printf then?

...okay.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
