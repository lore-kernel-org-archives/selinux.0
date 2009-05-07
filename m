Date: Thu, 7 May 2009 16:28:24 -0500
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: Eric Paris <eparis@redhat.com>
Cc: selinux@tycho.nsa.gov, linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org, viro@ZenIV.linux.org.uk,
        sds@tycho.nsa.gov
Subject: Re: SELinux and access(2), we want to know.
Message-ID: <20090507212824.GA23955@us.ibm.com>
References: <1241723924.2791.107.camel@localhost.localdomain> <20090507195729.GA21104@us.ibm.com> <1241729838.2791.127.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1241729838.2791.127.camel@localhost.localdomain>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Quoting Eric Paris (eparis@redhat.com):

...

> Your suggestion is the equivalent of knowing that your friend John might
> look in your window to see if you are home but shouldn't ever try to
> kick down the door.  In the current situation you can't tell the
> difference between the window and the door so you won't call the police
> even if John tries to kick down the door.

I don't buy this analogy, unless there a side effect to a failed open()
which I'm not thinking of?

> When in reality it would be a
> lot better to not call the police if John looks in the window even
> though you don't know his intent.  He might be looking in the window to
> see if you are home and if not he'll try to kick down the door.  But
> that situation of not knowing his intent and still not always calling
> the policy is a heck of a lot better than NEVER calling the police.  And
> I'm glad you see my side of the SELinux argument that this dontaudit
> needs to be per domain, not global for all access calls, since knowing

Yes.  It should be distinguishable per domain (and it is, using
dontaudit, right?).  But I don't yet see any reason why it's worth
distinguishing between access() and open().

> John might look in the window has nothing to do with Jake and we
> probably want to call the policy if he does either!
> 
> Often the right thing to do here is to fix the application to not
> request things it doesn't need, but at least in the case of Nautilus it
> needs to learn everything just so it can draw it's icons, not much we
> can do about that example.

If policy lets Nautilus poke around all under /usr without auditing,
then it (and anyone who attacks it) gets to do that...  catching opens
and not accesses doesn't imo buy you anything.

-serge

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
