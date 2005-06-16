Subject: Re: Making libselinux depend on libsepol
From: Ivan Gyurdiev <gyurdiev@redhat.com>
Reply-To: gyurdiev@redhat.com
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Daniel J Walsh <dwalsh@redhat.com>, SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <1118947036.30202.81.camel@moss-spartans.epoch.ncsc.mil>
References: <1118944064.28244.4.camel@celtics.boston.redhat.com>
	 <1118944751.30202.62.camel@moss-spartans.epoch.ncsc.mil>
	 <1118945030.28244.8.camel@celtics.boston.redhat.com>
	 <1118947036.30202.81.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Thu, 16 Jun 2005 14:39:42 -0400
Message-Id: <1118947182.28244.10.camel@celtics.boston.redhat.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> In the common case, no.  For /sbin/init and most existing usage of
> load_policy, it seems fine to have the library function internally
> handle the path determination, the open and mmap of the binary policy
> file, the runtime manipulation of the binary policy image for booleans,
> users, and whatever,

Ok..

>  and the call to security_load_policy; 

That part I want to leave out. I'm thinking of the useradd case,
where useradd will construct the map, using this new function,
and then invoke sepol functions to add users to it (and the file),
and then load it separately.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
