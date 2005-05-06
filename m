Subject: Re: [Fwd: Latest Diff]
From: Ivan Gyurdiev <ivg2@cornell.edu>
Reply-To: ivg2@cornell.edu
To: russell@coker.com.au
Cc: Daniel J Walsh <dwalsh@redhat.com>, SELinux <SELinux@tycho.nsa.gov>
In-Reply-To: <1115344683.15149.11.camel@localhost.localdomain>
References: <427A757F.9040009@redhat.com>
	 <1115329465.13097.23.camel@localhost.localdomain>
	 <200505061134.27455.russell@coker.com.au>
	 <1115344683.15149.11.camel@localhost.localdomain>
Content-Type: text/plain
Date: Fri, 06 May 2005 11:39:51 -0400
Message-Id: <1115393991.17301.18.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> ...but orbit-$USER needs to be labeled properly, and it can be created
> by anything that interfaces w/ libORBit-2, I think...which means
> that either it has to be created by a startup script, or
> the library should be modified to use matchpathcon() 
> when it creates the folder. I don't know which. 
> I also thought perhaps there should be a skeleton for /tmp
> (https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=156452)
> but I'm now starting to think that's may be a bad idea, and I should
> close the bug.

...and does tmpwatch need to be allowed to erase those folders?
If so, startup script is not an option... because right now tmpwatch
goes and tries to erase all of this..

-- 
Ivan Gyurdiev <ivg2@cornell.edu>
Cornell University


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
