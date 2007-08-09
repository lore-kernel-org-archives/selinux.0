Message-ID: <46BB3C01.9040905@trustedcs.com>
From: Darrel Goeddel <DGoeddel@TrustedCS.com>
To: Paul Moore <paul.moore@hp.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov,
        kaigai@ak.jp.nec.com, joe@nall.com, James Morris <jmorris@namei.org>,
        Eric Paris <eparis@parisplace.org>
Subject: Re: [RFC 0/5] Static/fallback external labels for NetLabel
Date: Thu, 9 Aug 2007 12:08:33 -0400 
MIME-Version: 1.0
in-reply-to: <200708091053.33776.paul.moore@hp.com>
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Paul Moore wrote:
> On Thursday 09 August 2007 10:09:14 am Darrel Goeddel wrote:
>> Because of the position I am in (needing to find something workable for
>> actual
>> users), I have been trying to get my head around the state of SELinux
>> networking,
>> the ideas that have been talked about in the past, and how we can prevent
>> the
>> SELinux networking infrastructure from resembling a Rube-Goldberg
machine.
>> I'll
>> be presenting some of the problems I perceive along with some very high
>> level
>> ideas early next week.
> 
> Such a tease! ;)

Sorry, I'm getting slow as I age, and I'm going out of town tomorrow.

> I assume from other, previous discussions you are currently using the 
> secid-reconciliation patches?

Yes and no - we've evolved a bit from them.  We implemented a completely
orthogonal peer context mechanism - basically the "reconciled" sid and we
have that in an *cough*expanded*cough* skb.  We kept the idea of external
and internal labels (which, BTW, I find to be really unwieldy and confusing
in
practice - anyone else actually use this stuff?).  We have a hodgepodge that
keeps the standard RHEL5 idea in place and adds loopback labeling and flow
control.  It works but it is a bear to figure out and I wouldn't suggest it
for an upstream implementation.  Our constraint (self-imposed) for this
was "meet our needs without modifying already-in-place controls".  We need
to look at the big picture to get something sensible from the ground up
and not just tack more stuff on.  Our current implementation is not the
desired end goal - the community needs to come up with that somehow.

-- 

Darrel

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
