Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i0KAXhRb023723
	for <selinux@tycho.nsa.gov>; Tue, 20 Jan 2004 05:33:46 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i0KAXaiV024646
	for <selinux@tycho.nsa.gov>; Tue, 20 Jan 2004 10:33:36 GMT
Received: from ns.sws.net.au ([61.95.69.3])
        by jazzband.ncsc.mil  with ESMTP id i0KAXH06024558 for <selinux@tycho.nsa.gov>; Tue, 20 Jan 2004 10:33:28 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Brian May <bam@snoopy.apana.org.au>, selinux@tycho.nsa.gov
Subject: Re: Samba and NFSv4 user-space server
Date: Tue, 20 Jan 2004 21:29:39 +1100
References: <200401131419.23834.russell@coker.com.au> <200401151619.58669.russell@coker.com.au> <84ptdft265.fsf@snoopy.apana.org.au>
In-Reply-To: <84ptdft265.fsf@snoopy.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200401202129.39951.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 20 Jan 2004 20:11, Brian May <bam@snoopy.apana.org.au> wrote:
>     Russell> That won't work.  Samba supports having multiple
>     Russell> identities on a single TCP connection, and NFSv4 supports
>     Russell> similar things.
>
> I may not have been very clear.
>
> I am assuming that while the connection can have multiple identities,
> each request can only have on identity. I think this is the case for
> Samba, I could be mistaken.

You are correct.

> My suggestion was to have one connection go to one process, which
> redirects the individual requests to other processes depending on the
> identity of that request.

Yes, this can be done, but requires proxying the operation to another process.  
It's something that we can look into, of course it will significantly 
increase the number of processes, and unless some trickery with shared file 
handles is done it will prevent using sendfile().

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
