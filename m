Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j2PHOXDo010459
	for <selinux@tycho.nsa.gov>; Fri, 25 Mar 2005 12:24:33 -0500 (EST)
Subject: Re: New policy for pyzor
From: David Hampton <hampton-rh@rainbolthampton.net>
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Cc: jwcart2@epoch.ncsc.mil, SELinux <selinux@tycho.nsa.gov>,
   fedora-selinux-list@redhat.com
In-Reply-To: <20050324103556.GD7999@lkcl.net>
References: <1111454594.18940.54.camel@hampton-pc.rainbolthampton.net>
	 <1111605242.3856.24.camel@moss-lions.epoch.ncsc.mil>
	 <1111610253.26996.16.camel@hampton-pc.rainbolthampton.net>
	 <20050324103556.GD7999@lkcl.net>
Content-Type: text/plain
Date: Fri, 25 Mar 2005 12:24:05 -0500
Message-Id: <1111771445.26996.31.camel@hampton-pc.rainbolthampton.net>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2005-03-24 at 10:35 +0000, Luke Kenneth Casson Leighton wrote:

>  ... btw just as an aside, what the heck is razor doing
>  attempting to create /razor.log and /root/razor.log?

The first time you run razor it can't find a config file telling it
where to put its log, so it drops the log into the current working
directory.  It then attempts to create a ~/.razor home directory and
default config file.  All subsequent invocations of razor will find the
just created config file and put the log where it specifies (which is
~/.razor by default).

The /razor.log is probably from the first invocation by a system daemon,
and the /root/razor.log from the first time you tested it as root.

David



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
