Message-Id: <200209121702.RAA23558@jazzswing.ncsc.mil>
Content-Type: text/plain;
  charset="iso-8859-1"
From: Carsten Grohmann <carstengrohmann@gmx.de>
To: Russell Coker <russell@coker.com.au>
Subject: Re: redhat.te and suse.te (was Re: pppd with ipppd)
Date: Thu, 12 Sep 2002 18:56:58 +0200
Cc: SELinux <SELinux@tycho.nsa.gov>
References: <200209082234.38885.russell@coker.com.au> <20020911090849.84828FA8D@ivanova.coker.com.au> <200209121632.39393.russell@coker.com.au>
In-Reply-To: <200209121632.39393.russell@coker.com.au>
MIME-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Am Donnerstag, 12. September 2002 16:32 schrieb Russell Coker:
> On Wed, 11 Sep 2002 11:07, Carsten Grohmann wrote:
> > Am Dienstag, 10. September 2002 18:26 schrieb Russell Coker:
> > > Now that we have shown that the .fc file per application scheme works
> > > well I doubt that there is a real need to use M4 for the .fc files
> > > (it's adding extra complexity for little benefit that I can see).
> > >
> > > > And it will by possible to remove unused single rules (like
> > > > dhcpd_t) without get an error ( Unkown type ...).
> > >
> > > What do you mean?
> >
> > I am sorry about my bad english.
> > Without the m4 macros specially ifdef, I would not create a single suse
> > rule. Because with an monolithic suse.fc file it isn't possible to
> > strip down the policy. But the possiblity to remove unused rules is (
> > in my eyes ) good feature of selinux. Because of that I don't see a
> > disadvantage in the use of ifdef's also in the fc files.
>
> It's taken me some time to reply to this message, because it's very
> difficult to understand.
>
> I think that you are saying "we already use m4 for policy so therefore
> there is no reason for not using it in the file contexts".
>
> The fact is that I proposed using M4 in the file contexts before, Steve
> rejected the idea, and we now have an alternate solution.
>
> If we need a redhat.fc or suse.fc then we may need to use M4, however I
> think that we will not need such entries.  I don't expect different
> distributions to need different types for the same file, and therefore we
> can put all definitions needed by all distributions in the main files.
>
> I suggest that we keep the current method in place until we have a
> concrete example of something failing with it.

You have right. This little example shows the boundary of the current 
method.

<< suse.fc >>

ifdef(`cups.fc',`
....
dev/usb/lp*		system_u:object_r:printer_device_t
....
')

ifdef(`ntpd.fc',`
/var/log/ntp		system_u:object_r:var_log_ntp_t
')

<< EOF suse.fc >>

Advantage:
 - You can errase the single policy file without to edit the suse.fc file.

Disadvantage:
 - The Makefile is more complex
 - The fc file could be more complex, but we could only accept m4 
   commands only in one or two file. The other file have to work without
   m4 commands.

I see there are more disadvantages then advantages. But if we like to merge 
the single suse file (apmd_suse.(fc|te) crond_suse, cups_suse, inetd_suse) 
, we need an fc file like this example, I think. 
The suse fc file are not empty. SuSE use in some cases similar filenames or 
it uses new "devices" like /dev/blog. 

Carsten

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
