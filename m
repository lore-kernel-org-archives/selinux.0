Date: Tue, 21 Aug 2007 10:33:40 -0400 (EDT)
From: Josh <josh@globalherald.net>
To: Stephen Smalley <sds@tycho.nsa.gov>
cc: SELinux@tycho.nsa.gov, Daniel J Walsh <dwalsh@redhat.com>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>,
        Joshua Brindle <method@manicmethod.com>
Subject: Re: Method to assign MCS Category without login.
In-Reply-To: <1187698887.1451.52.camel@moss-spartans.epoch.ncsc.mil>
Message-ID: <Pine.LNX.4.64.0708211009490.15934@home-av-server.home-av>
References: <Pine.LNX.4.64.0708191603500.15934@home-av-server.home-av>
 <1187611079.24940.27.camel@moss-spartans.epoch.ncsc.mil>
 <Pine.LNX.4.64.0708201313150.21628@home-av-server.home-av>
 <1187698887.1451.52.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> I'd guess that you would want the root httpd process to perform the set
> up of the child's context, including switching it into the desired
> category set and into a different domain than the root httpd process.

So the question then becomes, does the root httpd process then need to be 
trusted, and does this trust break the domain/type enforcement that is 
applied to the httpd domain?  (For example: when I first set up a 
Python-based website, my connection to Postgres was denied because I 
hadn't yet defined a rule to allow it.  If I alow the root httpd instance 
to be trusted - in order to set the context - will that weaken the domain 
and type enforcement for httpd?

Being a newbie I am most likely missing something here.

> What is your real goal?

My goal is to protect Python-based sites from each other.  The OS is 
protected against rogue scripts by the domain and type enforcement of 
HTTPD; but I would like to use Category Access to protect the scripts 
against other rogue scripts.

Thanks,
-Josh


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
