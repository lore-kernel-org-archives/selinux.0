Subject: Re: [PATCH 1/4] libselinux flask definition update for context
	class
From: Eric Paris <eparis@parisplace.org>
To: Darrel Goeddel <dgoeddel@TrustedCS.com>
Cc: Joshua Brindle <jbrindle@tresys.com>, SELinux List <selinux@tycho.nsa.gov>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>,
        Linda Knippers <linda.knippers@hp.com>,
        Daniel Walsh <dwalsh@redhat.com>
In-Reply-To: <45351ABE.3050006@trustedcs.com>
References: <4534FDF8.2000609@trustedcs.com> <453518AB.4020303@tresys.com>
	 <45351ABE.3050006@trustedcs.com>
Content-Type: text/plain
Date: Tue, 17 Oct 2006 14:19:28 -0400
Message-Id: <1161109169.3163.2.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2006-10-17 at 13:02 -0500, Darrel Goeddel wrote:
> Joshua Brindle wrote:
> > Darrel Goeddel wrote:
> > 
> >> Update SELinux flask definition to include the context security class.
> >> This also adds the "process setsockcreate" and "association polmatch" 
> >> string
> >> definitions that have been missing.
> >>
> >> Signed-off-by: Darrel Goeddel <dgoeddel@trustedcs.com>
> >>
> >> ---
> >>
> >> include/selinux/av_permissions.h |   76 
> >> ---------------------------------------
> > 
> > 
> > Why all the whitespace changes?
> 
> Those are the files created by using the tolib target in the flask directory
> of the references policy (with Lindent changes...).  The same is true for the
> kernel patch (except for the Lindent).  I asked about that earlier and was
> guided to go with the generated files.

The generators were creating an blank line at the very end of the file.
Kernel people didn't like that white space (and it had been 'fixed up'
by hand).  I believe Dan fixed that issue.  Did you actually remove all
of the blank lines instead of just the very last blank line?


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
