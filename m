Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id VAA25984
	for <selinux@tycho.nsa.gov>; Fri, 3 Jan 2003 21:36:06 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id CAA21198
	for <selinux@tycho.nsa.gov>; Sat, 4 Jan 2003 02:33:27 GMT
Received: from snoopy.apana.org.au (snoopy.apana.org.au [203.12.237.97])
	by jazzswing.ncsc.mil  with ESMTP id CAA21193
	for <selinux@tycho.nsa.gov>; Sat, 4 Jan 2003 02:33:25 GMT
Date: Sat, 4 Jan 2003 13:35:45 +1100
From: Brian May <bam@snoopy.apana.org.au>
To: Mark Westerman <mark.westerman@westcam.com>
Cc: selinux@tycho.nsa.gov
Subject: Re: XML Policy Files
Message-ID: <20030104023545.GA30318@snoopy.apana.org.au>
References: <862636C39A8D56448223B94D19757133015EB5@server.westcam.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <862636C39A8D56448223B94D19757133015EB5@server.westcam.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, Dec 23, 2002 at 03:30:45PM -0600, Mark Westerman wrote:
> This is the xml policy work that has been completed so far by Westcam. The real examination of outside parties needs to be in the selinux-schema.xsd 
> this will be the basis of our work. Any policy xml file that conforms to the
> selinux-schema should work with any xml policy enabled program.

Sorry I have been so long to reply, I have been
meaning to look at your XML policy for a while.

This policy looks interesting.

Unlike my XML format, this is very low level, and doesn't (yet) have
support for things like macros. This isn't necessarily a bad thing,
there are lots of XML formats which are designed to be low level, and
not intended to be read by humans (eg GNUmeric file format). Its major
benifit over my format is that you can convert it, automatically, in
both directions.

It might be an interesting idea to write a program or something that
will convert my higher level format to your lower level format.

Also your schema seems to be very verbose in places, I am not conviced
this is really required, eg. when defining sids and attributes. It also
seems to overuse the "identifier" element, I suspect at least in some
instances "identifier-reference" or just "reference" might be better.

(in my mind I think of "identifier" to define the ID of the current
object getting defined, and "reference" to point to other objects").

Is there any reason you have decided to use all elements, instead of XML
attributes? Not complaining here, just curious, there are pros/cons
either way.

I would consider using "id="/"identifier=" or "ref="/"references="
attributes rather then the "identifier" element (I think it maks it look
cleaner (just my opinion though, I am use to seeing all IDs as
attributes).

Anyway, I hope you find this feedback some use.
--
Brian May <Brian May <bam@snoopy.apana.org.au>>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
