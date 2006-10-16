Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k9GHkcPP029145
	for <selinux@tycho.nsa.gov>; Mon, 16 Oct 2006 13:46:39 -0400
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id k9GHju3d024933
	for <selinux@tycho.nsa.gov>; Mon, 16 Oct 2006 17:45:57 GMT
Subject: Re: New MLS constraint?
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Matt Anderson <mra@hp.com>
Cc: selinux@tycho.nsa.gov, redhat-lspp@redhat.com
In-Reply-To: <4533B60E.8010802@hp.com>
References: <4533B60E.8010802@hp.com>
Content-Type: text/plain
Date: Mon, 16 Oct 2006 13:47:33 -0400
Message-Id: <1161020854.26428.32.camel@sgc>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2006-10-16 at 12:40 -0400, Matt Anderson wrote:
> With the removal of TCS's dev-allocator the solution for multi-level
> printers that came out of the LSPP calls was to set a range on the
> printer device, using chcon, and use SELinux to verify that the print
> job was inside that range.
> 
> I've since added checking code to the server which does not allow jobs
> to be enqueued into the spool or queued and printed unless an
> avc_has_perm() check passes.  The current check uses SECCLASS_FILE, and
> checks FILE__WRITE;

Why are you using file?  The printer device chr_file.

> The subject is something like user_u:user_r:user_lpr_t:s2:A
> The object is: system_u:object_r:printer_device_t:s2-s15:c0.c1023
> 
> When I do this check however, I get denied whenever the user's context
> does not equal the lower level.

Here is the current (abbreviated) constraint:

mlsconstrain { file chr_file ... } { write ... }
	(( l1 eq l2 ) or
	 (( t1 == mlsfilewritetoclr ) and ( h1 dom l2 ) and ( l1 domby l2 )) or
	 ( t1 == mlsfilewrite ) or
	 ( t2 == mlstrustedobject ));

The first line of the expression explains why you needed write equality
on the level.

> Is there a constraint that I can apply,
> preferably to the object's type (printer_device_t as opposed to *_lpr_t,
> ) that would allow the above check to succeed?

We could add another 'or' on the above constraint:

or ( (t2 == mlsfilewrite_in_range) and (l1 dom l2) and (h1 domby h2) )

I believe that would be the constraint you were looking for.  I don't
like the name of that attribute, but I couldn't come up with a better
one off the top of my head. :)

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
