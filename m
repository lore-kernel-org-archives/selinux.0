Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h91DQesJ024950
	for <selinux@tycho.nsa.gov>; Wed, 1 Oct 2003 09:26:40 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h91DOqZt028412
	for <selinux@tycho.nsa.gov>; Wed, 1 Oct 2003 13:24:52 GMT
Received: from tsv.sws.net.au ([61.95.69.2])
	by jazzswing.ncsc.mil  with ESMTP id h91DOpM3028405
	for <selinux@tycho.nsa.gov>; Wed, 1 Oct 2003 13:24:51 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Stephen Smalley <sds@epoch.ncsc.mil>
Subject: Re: makemap
Date: Wed, 1 Oct 2003 23:26:30 +1000
Cc: SE Linux <selinux@tycho.nsa.gov>
References: <200310012113.44940.russell@coker.com.au> <1065014251.350.20.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1065014251.350.20.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200310012326.30906.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 1 Oct 2003 23:17, Stephen Smalley wrote:
> On Wed, 2003-10-01 at 07:13, Russell Coker wrote:
> > /usr/bin/makemap                system_u:object_r:sbin_t
> >
> > What is the above entry in types.fc about?  Is there a hard-link between
> > a file in /usr/sbin and /usr/bin?
>
> IIRC, this was a hard link to /usr/sbin/makemap in an older version of
> RH, but it appears to now be a symlink, so this isn't really necessary
> anymore.

Great.  I've deleted it from my tree.

If anyone knows of any other file_contexts entries that are now obsolete 
because of newer versions of Linux distributions then please let me know.  
setfiles time is directly proportional to the size of the file_contexts file, 
so anything we can remove will make setfiles faster.

For those of you who were wondering, even with my recent patch setfiles is 
much slower than it used to be.  We have added lots of new policy, and the 
policy that is there has been made more complete.  This meant adding lots of 
new file_contexts entries.  I am not trying to get it to the situation where 
disk IO speed is the bottleneck.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
