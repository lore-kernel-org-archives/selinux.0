Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h4JCbbI4002935
	for <selinux@tycho.nsa.gov>; Mon, 19 May 2003 08:37:37 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h4JCbDQj026544
	for <selinux@tycho.nsa.gov>; Mon, 19 May 2003 12:37:13 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id h4JCbCxS026538
	for <selinux@tycho.nsa.gov>; Mon, 19 May 2003 12:37:13 GMT
Subject: Re: slow application of contexts in devfs?
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Russell Coker <russell@coker.com.au>
Cc: "Christopher J. PeBenito" <pebenito@ieee.org>,
   SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <200305180511.19269.russell@coker.com.au>
References: <3EC2792D.1020209@yahoo.it>
	 <1053085242.4729.786.camel@moss-huskers.epoch.ncsc.mil>
	 <1053191138.4322.33.camel@chris.pebenito.net>
	 <200305180511.19269.russell@coker.com.au>
Content-Type: text/plain
Message-Id: <1053347836.4729.970.camel@moss-huskers.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 19 May 2003 08:37:16 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 2003-05-17 at 15:11, Russell Coker wrote:
> I have been considering merging the two domains for smaller systems.  Maybe it 
> would be worth doing for the general case?  The difference between them is 
> that klogd can read system_map_t (*), and the kernel message log, while 
> syslogd is permitted network access, can write files to disk under /var/log, 
> and can create /dev/log.
> 
> By merging the two we allow syslogd to read system map files under /boot which 
> isn't that important and we allow syslogd to read the kernel message log 
> directly (as it gets all the same data indirectly anyway that does not seem a 
> problem).  klogd gets to write files under /var/log and to create a socket 
> under /dev.  Is this enough of a problem to need a separate domain?

klogd can be redirected to a particular file rather than going through
syslogd, and syslogd may be set up to accept remote logging requests as
well as local ones.  Hence, it may be worthwhile to keep them as
separate domains in the example policy, even if people choose to fold
them in certain environments.
  
-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
