Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Carsten Grohmann <carstengrohmann@gmx.de>
Subject: Re: redhat.te and suse.te (was Re: pppd with ipppd)
Date: Thu, 12 Sep 2002 16:32:39 +0200
References: <200209082234.38885.russell@coker.com.au> <200209101826.30237.russell@coker.com.au> <20020911090849.84828FA8D@ivanova.coker.com.au>
In-Reply-To: <20020911090849.84828FA8D@ivanova.coker.com.au>
Cc: SELinux <SELinux@tycho.nsa.gov>
MIME-Version: 1.0
Message-Id: <200209121632.39393.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 11 Sep 2002 11:07, Carsten Grohmann wrote:
> Am Dienstag, 10. September 2002 18:26 schrieb Russell Coker:
> > Now that we have shown that the .fc file per application scheme works
> > well I doubt that there is a real need to use M4 for the .fc files (it's
> > adding extra complexity for little benefit that I can see).
> >
> > > And it will by possible to remove unused single rules (like dhcpd_t)
> > > without get an error ( Unkown type ...).
> >
> > What do you mean?
>
> I am sorry about my bad english.
> Without the m4 macros specially ifdef, I would not create a single suse
> rule. Because with an monolithic suse.fc file it isn't possible to strip
> down the policy. But the possiblity to remove unused rules is ( in my eyes
> ) good feature of selinux. Because of that I don't see a disadvantage in
> the use of ifdef's also in the fc files.

It's taken me some time to reply to this message, because it's very difficult 
to understand.

I think that you are saying "we already use m4 for policy so therefore there 
is no reason for not using it in the file contexts".

The fact is that I proposed using M4 in the file contexts before, Steve 
rejected the idea, and we now have an alternate solution.

If we need a redhat.fc or suse.fc then we may need to use M4, however I think 
that we will not need such entries.  I don't expect different distributions 
to need different types for the same file, and therefore we can put all 
definitions needed by all distributions in the main files.

I suggest that we keep the current method in place until we have a concrete 
example of something failing with it.


Russell Coker


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
