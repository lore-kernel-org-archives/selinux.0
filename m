Subject: Re: mv and cp behavior.
From: Colin Walters <walters@redhat.com>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: Daniel J Walsh <dwalsh@redhat.com>, SELinux <SELinux@tycho.nsa.gov>
In-Reply-To: <1098119648.27895.150.camel@moss-spartans.epoch.ncsc.mil>
References: <41712EEF.9090402@redhat.com>
	 <1098105487.27895.40.camel@moss-spartans.epoch.ncsc.mil>
	 <1098115678.6101.30.camel@decepticon.boston.redhat.com>
	 <1098119648.27895.150.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Mon, 18 Oct 2004 13:43:56 -0400
Message-Id: <1098121436.6101.56.camel@decepticon.boston.redhat.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2004-10-18 at 13:14 -0400, Stephen Smalley wrote:

> Ok, but if you were able to use chcon to set the type in the first
> place, then you presumably are able to use it after moving files there
> in Dan's example scenario.

Right; this was just a related issue, not quite the same thing as Dan's
2).

> I still don't like using the user namespace for that purpose.  I'd
> prefer an attribute in the security namespace, with corresponding DAC
> and MAC checks applied to the ability to set it or remove it.

Ok, right.

> True, under strict policy.  But the installed file_contexts
> configuration is already being used for other purposes, e.g. rpm, udev,
> restorecon invocations from scripts and rpm %post scriptlets.

I think RPM counts as "system initialization".  udev is kind of a
special case.

> > Dan and I talked about this for a bit today, and one problem he brought
> > up with mv doing prompting is that it has a large potential to break
> > scripts.  
> > 
> > For Dan's scenario 1), I just don't see any good solutions right now.
> > At least short of changing every script and program that invokes 'mv' to
> > do 'mv -f'.  I guess you could argue they're already buggy since mv can
> > potentially prompt in the DAC case too though...
> 
> I suppose it would be interesting to see how many of these mv's are
> crossing type boundaries anyway...

Yeah.  I'm kind of curious why Dan wrote the dhcp.conf in /tmp and later
moved it to /etc; I'd imagine most admins would just
$EDITOR /etc/dhcp.conf.

Anyways, for FC3 I think we are not going to be able to do a prompting
mv.  However I'd be interested in turning on mv prompting in FC4, and
seeing how much from the collection of shell scripts on the system
actually breaks.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
