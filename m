Subject: Re: java threads
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Jeremiah Jahn <jeremiah@goodinassociates.com>
Cc: selinux <selinux@tycho.nsa.gov>
In-Reply-To: <1202396529.2801.457.camel@bluejay.goodinassociates.com>
References: <1202338588.2801.400.camel@bluejay.goodinassociates.com>
	 <1202391931.27371.190.camel@moss-spartans.epoch.ncsc.mil>
	 <1202396529.2801.457.camel@bluejay.goodinassociates.com>
Content-Type: text/plain
Date: Thu, 07 Feb 2008 10:12:49 -0500
Message-Id: <1202397169.27371.243.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Thu, 2008-02-07 at 09:02 -0600, Jeremiah Jahn wrote:
> On Thu, 2008-02-07 at 08:45 -0500, Stephen Smalley wrote:
> > On Wed, 2008-02-06 at 16:56 -0600, Jeremiah Jahn wrote:
> > > what allows java to create a new thread? execmem? execstack? 	
> > 
> > execmem/execstack are memory controls, not thread controls.
> 
> That's what I was thinking, but without allowing execmem, java can't
> seem to start up a new thread. I know for the longest time, java on
> Linux didn't use the standard thread API, so I thought that might be the
> cause. I'm just curious to see if anyone knows why this seems to be
> required for java to do it's thing with regards to threads. 

BTW, java does require execmem in order to do runtime code generation
regardless of the threads issue.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
