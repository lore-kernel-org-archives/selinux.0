Date: Mon, 12 Aug 2002 14:16:15 +1000
From: Brian May <bam@snoopy.apana.org.au>
To: SELinux <SELinux@tycho.nsa.gov>
Subject: Re: security context for temporalily mounted filesystems
Message-ID: <20020812041615.GA2149@snoopy.apana.org.au>
References: <200208091352.NAA00864@jazzband.ncsc.mil> <20020810235352.GC13384@snoopy.apana.org.au> <200208110935.JAA23009@jazzband.ncsc.mil> <20020811145503.0E4C68654@lyta.coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20020811145503.0E4C68654@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, Aug 11, 2002 at 04:55:02PM +0200, Russell Coker wrote:
> I am not recommending root_t for everything, and I am not certain that it's 
> the best thing to do.  However as I haven't had a better idea and it's a lot 
> better than file_t I can't suggest anything else.

You don't normally want mount to be able to mount over / do you?

However, if you give both the same type you will not be able to
distinguish the two cases.

I would suggest:

If /usr is mounted:
Give /usr on the root filesystem a type that allows mount to mount a
filesystem on it, and / on that file system should be root_t.

If /usr is not mounted:
/usr should be root_t.
-- 
Brian May <bam@snoopy.apana.org.au>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
