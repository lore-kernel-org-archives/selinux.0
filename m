Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i8UGoarT024621
	for <selinux@tycho.nsa.gov>; Thu, 30 Sep 2004 12:50:37 -0400 (EDT)
Received: from gotham.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i8UGnRng022844
	for <selinux@tycho.nsa.gov>; Thu, 30 Sep 2004 16:49:31 GMT
Message-Id: <200409301650.i8UGo4Sf029987@gotham.columbia.tresys.com>
From: "Karl MacMillan" <kmacmillan@tresys.com>
To: <russell@coker.com.au>, "'SE Linux'" <selinux@tycho.nsa.gov>
Cc: "'Selinux-Dev'" <selinux-dev@tresys.com>
Subject: RE: apol suggestions
Date: Thu, 30 Sep 2004 12:50:04 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <200409300928.28618.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> -----Original Message-----
> From: owner-selinux@tycho.nsa.gov [mailto:owner-selinux@tycho.nsa.gov] On
> Behalf Of Russell Coker
> Sent: Wednesday, September 29, 2004 7:28 PM
> To: SE Linux
> Subject: apol suggestions
> 
> I've just done a search to discover what can get read or write access
> to /etc/shadow.  For such a search it would be good if I didn't have to
> click
> on each of create read write setattr relabelfrom, etc.  I would like to
> have
> groupings of access such as the following:
> 
> read_group: read ioctl relabelfrom execute execute_no_trans
> 
> write_group: write append create relabelfrom relabelto ioctl link rename
> setattr unlink
> 
> Note that I didn't put getattr in the read group because often getattr
> access
> is granted just to quiet ls or to satisfy other checks when no other read
> access is granted.  We can't rely on people selecting 10 items correctly
> from
> a list if performing repetitive operations.
> 

The best interface might be to allow users to create their own groupings of
permissions named whatever they want, because as you point out the semantics
are not always clear or universally applicable. For the overt information
flow search you are doing, excluding getattr certainly seems appropriate
because you are only concerned about the flow of the data contained in the
file. For other situations that might be less appropriate, and providing a
canned grouping for users might lead them to inappropriate conclusions. I'll
add this to the todo list.

It seems that you are using the plain rule search - any reason you are not
using one of the information flow analysis modules? The query you seem to be
doing is really a direct information flow analysis, which has a very nice
interface (the permission map editor) for specifying what is a read or
write. It even allows you to specify a minimum "weight" so that you can, for
example, exclude covert channel types of permissions if you are only
interested in overt information flow. We have a bug report about the weight
exclusions not working that we are still tracking down, so if it doesn't
work for you expect the next release to include a fix.

> Also is a batch interface to apol planned?  I would like to have
> #!/usr/sbin/apol at the start of scripts...
> 

I agree and this is something that we are actively working on. The first
step will be the creation of a higher level language for stating information
flow properties and checking whether a policy exhibits those properties.
This is useful for regression testing a policy for example.

As far a general scripting interface, I'm not certain if or when that might
happen. For the time being it is possible to write fairly short C programs
that link to libapol. The libapol interface, though not well documented,
will allow you to do any of the analysis that is possible with apol. See the
test directory in the setools package to get some ideas.

> 
> My search of shadow_t access showed that there are 12 domains granted
> access
> directly and 9 granted through posession of the "auth" attribute.  Even
> when
> two lists are so small it's difficult to determine which entries overlap
> (especially when they can't both be fully displayed on the screen at the
> same
> time).  If the "Type Enforcement Rules Display" box could be made to fill
> the
> entire screen then it would be a little easier for some analysis tasks.

It is not entirely obvious so I'm not certain whether you noticed, but you
can resize the display, though not to take up the entire display. I think
the best option might be allow the result tabs to be detached. We'll see
about doing something on this, but unfortunately these types of gui
enhancements are lower priority than the functional enhancements we have in
the works.

> Also
> if there was some way of displaying the domains that can do the access
> through the auth attribute as well as through direct policy rules in the
> one
> list then it would solve this entire problem for me.
> 

Checking "include indirect matches" will do this and the information flow
analysis does this by default.

> Another thing, the "Type Enforcement Rules Display" box is sorted by line
> number in policy.conf.  This is usually OK as we try to group things in
> the
> policy source.  But it would be nice if we could change the ordering to
> sort
> by source domain or target domain.
> 

That's a good idea. We'll add it to the todo list.

Thanks for the feedback,

Karl


Karl MacMillan
Tresys Technology
http://www.tresys.com
(410)290-1411 ext 134

> --
> http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
> http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
> http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
> http://www.coker.com.au/~russell/  My home page
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov
> with
> the words "unsubscribe selinux" without quotes as the message.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
