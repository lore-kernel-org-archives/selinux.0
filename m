Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l62FUZd2010374
	for <selinux@tycho.nsa.gov>; Mon, 2 Jul 2007 11:30:35 -0400
Received: from smtp-bedford.mitre.org (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l62FUW49012419
	for <selinux@tycho.nsa.gov>; Mon, 2 Jul 2007 15:30:32 GMT
Received: from smtp-bedford.mitre.org (localhost.localdomain [127.0.0.1])
	by smtp-bedford.mitre.org (8.12.11.20060308/8.12.11) with SMTP id l62FUUKi004960
	for <selinux@tycho.nsa.gov>; Mon, 2 Jul 2007 11:30:30 -0400
Received: from smtp-bedford.mitre.org (localhost.localdomain [127.0.0.1])
	by smtp-bedford.mitre.org (Postfix) with ESMTP id E6EF7BF00
	for <selinux@tycho.nsa.gov>; Mon,  2 Jul 2007 11:30:29 -0400 (EDT)
To: Karl MacMillan <kmacmillan@mentalrootkit.com>
Cc: russell@coker.com.au, selinux@tycho.nsa.gov
Subject: Re: GPLv3
References: <200707021930.00649.russell@coker.com.au>
	<1183386470.16330.5.camel@localhost.localdomain>
From: ramsdell@mitre.org (John D. Ramsdell)
Date: 02 Jul 2007 11:30:28 -0400
In-Reply-To: <1183386470.16330.5.camel@localhost.localdomain>
Message-ID: <ogtk5tilt63.fsf@oolong.mitre.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Karl MacMillan <kmacmillan@mentalrootkit.com> writes:

> On Mon, 2007-07-02 at 19:29 +1000, Russell Coker wrote:
> > What are we going to do regarding GPLv3?

> I think it is too soon to do this. ...

I notice FSF already has cute Buttons available for projects to
promote their switch to GPLv3 at http://gplv3.fsf.org/.

Seriously though, in Richard Stallman's page titled "Why Upgrade to
GPLv3", you can find this quote:

   When we say that GPLv2 and GPLv3 are incompatible, it means there
   is no legal way to combine code under GPLv2 with code under GPLv3
   in a single program.

This means a GPLv2 library cannot be linked with a GPLv3 program, as I
read it.  I think Karl's call for careful planning before any switch
is wise.

http://www.gnu.org/licenses/rms-why-gplv3.html

John

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
