Date: Sun, 11 Aug 2002 09:53:52 +1000
From: Brian May <bam@snoopy.apana.org.au>
To: SELinux <SELinux@tycho.nsa.gov>
Subject: Re: security context for temporalily mounted filesystems
Message-ID: <20020810235352.GC13384@snoopy.apana.org.au>
References: <200208091352.NAA00864@jazzband.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200208091352.NAA00864@jazzband.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, Aug 09, 2002 at 03:51:34PM +0200, Carsten Grohmann wrote:
> last days I labelling the mount point (/floppy, /cdrom, ..) and the 
> correspond links as root_t.
> I think, it is good to add this to the standard distribution.

What is the justification in doing this?

That is, what benefit do you get?

Also, when you say /floppy, I assume you mean the directory on / called
"floppy", and not the root directory on the mounted floppy disk drive?
-- 
Brian May <bam@snoopy.apana.org.au>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
