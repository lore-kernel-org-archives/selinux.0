From: Steve Grubb <sgrubb@redhat.com>
To: Karl MacMillan <kmacmillan@mentalrootkit.com>
Subject: Re: missing avc message field names
Date: Tue, 30 Jan 2007 12:42:31 -0500
Cc: Karl MacMillan <kmacmill@redhat.com>, linux-audit@redhat.com,
        ewalsh@tycho.nsa.gov, Steve G <linux_4ever@yahoo.com>,
        selinux@tycho.nsa.gov
References: <20070129185542.32977.qmail@web51502.mail.yahoo.com> <200701291749.21897.sgrubb@redhat.com> <45BF5AE3.6030602@mentalrootkit.com>
In-Reply-To: <45BF5AE3.6030602@mentalrootkit.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200701301242.31909.sgrubb@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tuesday 30 January 2007 09:49, Karl MacMillan wrote:
> > You already have that problem. AUDIT_AVC and AUDIT_USER_AVC.
>
> Yes, but adding even more message types makes the problem worse. More
> importantly, what does splitting AVC messages even more accomplish?

It allows users to tune the audit system to the kinds of messages they want to 
keep in their logs, makes analysis of the kinds of problems being reported 
easier, and allows normalization of records for binary use.

> In fact, I would rather that AUDIT_AVC and AUDIT_USER_AVC were not split.

They have to be, ironically, because of SE Linux.  :)

> > Speed and compression. People doing serious auditing have very large
> > files. Compression is extremely important. Also when dealing with large
> > files, any performance trick you can find helps immensely.
>
> gzip or bzip2 compression is not sufficient?

No, its an intermediate solution on the way to a better more difficult 
solution.

> Is audit searching performance the most important consideration?

Storage size is the more important followed by speed. As soon as you allow 
more records, they will have more to search.

> Look, I'm not against binary logs, I'm just trying to point out that I
> think that the transition will not be as easy as you seem to suggest.

No, I'm sure it will be time consuming and done in phases. The first step is 
providing the insulating layer so that apps do not have to care.

> >> The biggest issue, of course, is that it would prevent the use of any
> >> tools that process the files as text (grep, tail, awk, seaudit,
> >> setroubleshoot, etc., etc.).
> >
> > ausearch -m all --raw | grep anything you want
>
> tail -f happens to be my favorite counter example, but I am certain
> there are other useful tricks for monitoring logs that will break.

You can still use this on your system. What will be happening in the audit 
system is that there will be choices as to how the information will be 
stored. Text will still be an option. However, the portable way will be 
ausearch based.

> >> And what about third-party tools that are security critical?
> >
> > They have the TRUSTED_APP message type and they can put anything in that
> > they want. I consider that one completely freestyle.
>
> Why is it acceptable to have arbitrary name/value pairs in that message
> type and not in others?

Because by definition third party means we don't have the source to review or 
fix.

-Steve

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
