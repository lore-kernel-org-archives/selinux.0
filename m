Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id IAA24209
	for <selinux@tycho.nsa.gov>; Fri, 9 Feb 2001 08:19:11 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id NAA10826
	for <selinux@tycho.nsa.gov>; Fri, 9 Feb 2001 13:19:09 GMT
Received: from angusbay.vnl.com ([194.46.8.33])
	by jazzband.ncsc.mil  with ESMTP id NAA10822
	for <selinux@tycho.nsa.gov>; Fri, 9 Feb 2001 13:19:07 GMT
Date: Fri, 9 Feb 2001 13:19:50 +0000
From: Dale Amon <amon@vnl.com>
To: Dustin Reyes <crusader@linuxgames.com>
Cc: selinux@tycho.nsa.gov
Subject: Re: Crypto FS
Message-ID: <20010209131949.O13451@vnl.com>
References: <20010208155329.A1383@linuxgames.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20010208155329.A1383@linuxgames.com>; from crusader@linuxgames.com on Thu, Feb 08, 2001 at 03:53:29PM -0600
Sender: owner-selinux@tycho.nsa.gov
List-ID: <selinux@tycho.nsa.gov>

On Thu, Feb 08, 2001 at 03:53:29PM -0600, Dustin Reyes wrote:
> Re: Integrate existing publicly available file cryptography
> with file mandatory controls 
> 
> Will the SE Linux team (NAI Labs, NSA, etc.) be conducting
> an extensive security audit of current Linux disk encryption?
> 

I doubt they could step into that area. I also doubt they would
want to take on the grief because no one would believe them
anyway.

> Finally, I'm not a professional coder or cryptologist, so this question
> may be completely invalidated by encrypted filesystems are
> already implemented... if so, I apologize in advance.
> 

The linux crypt tree is managed by a lot of very fine people
spread all over the world and anyone who found a hole would
gain instant fame in their esoteric coterie. If you were a 
young math wizard, what better way to gain notoriety that to 
find a backdoor in a popular cipher? I'd say that
there are probably more people pounding on codes outside
government circles now than the total of all the ones who
were ever *inside*. Some people even think its fun. :-)

In any case, there are also standards like AES that are
well trusted. And everyone knows you shouldn't trust DES
for anything more serious than a teen love letter.

In short, I think the people doing the hard work here
should make sure they don't break the international
patches, but it is perhaps not wise for them to step into
quicksand.

And I would in fact be happy to test the interoperability of
the two sets of patches and report any problems. At the
end of the day, its' my customers data that I need to 
protect, and that means a full systemic approach.

-- 
------------------------------------------------------
Use Linux: A computer        Dale Amon, CEO/MD
is a terrible thing          Village Networking Ltd
to waste.                    Belfast, Northern Ireland
------------------------------------------------------

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
