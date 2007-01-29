From: Steve Grubb <sgrubb@redhat.com>
To: Karl MacMillan <kmacmill@redhat.com>
Subject: Re: missing avc message field names
Date: Mon, 29 Jan 2007 17:49:21 -0500
Cc: linux-audit@redhat.com, ewalsh@tycho.nsa.gov,
        Steve G <linux_4ever@yahoo.com>, selinux@tycho.nsa.gov
References: <20070129185542.32977.qmail@web51502.mail.yahoo.com> <200701291556.37235.sgrubb@redhat.com> <45BE6410.9050604@redhat.com>
In-Reply-To: <45BE6410.9050604@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200701291749.21897.sgrubb@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Monday 29 January 2007 16:16, Karl MacMillan wrote:
> Steve Grubb wrote:
> > On Monday 29 January 2007 14:22, Eamon Walsh wrote:
> >> Steve G wrote:
> >>> But back to the original question, any preference for non-conflicting
> >>> names? :)
> >>
> >> CC'ing linux-audit.
> >>
> >> Some comments regarding userspace object managers and the userspace AVC:
> >> in general userspace object managers will introduce new fields to the
> >> AVC messages.
> >
> > Which brings up the question of does everything have to be an AVC message
> > type?
>
> I don't know that it is necessary, but it is certainly preferable. 

I'd also like to make sure that all AVCs really are AVCs. I think there are 
some error messages that come out as AVCs when they should be SE_ERR or 
USER_SE_ERR.

> All of these messages serve exactly the same purpose - splitting them would
> be a pain for any app that wants to process them (not to mention dealing
> with backwards compatibility).

You already have that problem. AUDIT_AVC and AUDIT_USER_AVC.

> For example, the policy generation tools that I am working on could
> process these X messages because they are AVC messages and I only
> require the core fields to be present (i.e., source / target types,
> granted / denied, class, and permissions). If they were split out I
> would a) have to process more message types and b) track which versions
> of the audit subsystem contain which message types.

You already have them split out...or did you totally skip AUDIT_USER_AVC? So, 
you already have to solve the problem so why not generalize the solution? The 
parsing API should be able to help with this. If you tell it to get all the 
different types and they don't exist, you don't get a hit except the ones 
that do exist.

>   If we ever want to have binary audit records, we need to think of these
>
> > audit messages as if they were database tables - each type normalized.
> > This is, I think, where we are ultimately heading.
>
> What problems do binary audit records solve?

Speed and compression. People doing serious auditing have very large files. 
Compression is extremely important. Also when dealing with large files, any 
performance trick you can find helps immensely.

> The biggest issue, of course, is that it would prevent the use of any
> tools that process the files as text (grep, tail, awk, seaudit,
> setroubleshoot, etc., etc.). 

ausearch -m all --raw | grep anything you want

> Some can be moved over to the audit library, but it is still useful to use
> grep, tail, and other shell tools to search logs. I know that you discourage
> that practice, but I believe that it is (and will remain) useful.

What happens when the file format changes - zlib compression for example?

> >> If all of these keywords in the data dictionary have to be unique, I'm
> >> wondering if it might be useful to use a 3-tuple instead of a
> >> (name,value) pair.
> >
> > I just don't see audit growing that much bigger. Of course, I may be
> > wrong.
>
> Why? I hope there will be a growing list of selinux object managers

I doubt there very many security related pieces of information that is not 
already in the dictionary. There are a finite number of security objects and 
their attributes.

> And what about third-party tools that are security critical?

They have the TRUSTED_APP message type and they can put anything in that they 
want. I consider that one completely freestyle.

> I don't understand - Eamon is suggesting creating unique names across
> all message types by introducing a prefix, which seems like what you are
> saying is necessary.

Nearly all names are unique (and the problem should be solved when I code up 
seperm and seresults). Adding more letters to the name eats the diskspace. We 
only do it when necessary. That is what drives the choice of "res" instead 
of "results" for the audit system.

-Steve

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
