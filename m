Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iA1Kb1XZ000033
	for <selinux@tycho.nsa.gov>; Mon, 1 Nov 2004 15:37:01 -0500 (EST)
Received: from open.hands.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id iA1KZeCC004081
	for <selinux@tycho.nsa.gov>; Mon, 1 Nov 2004 20:35:41 GMT
Date: Mon, 1 Nov 2004 20:47:47 +0000
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Chad Hanson <chanson@TrustedCS.com>
Cc: Stephen Smalley <sds@epoch.ncsc.mil>,
   Darrel Goeddel <DGoeddel@TrustedCS.com>, selinux@tycho.nsa.gov,
   Frank Mayer <mayerf@tresys.com>
Subject: Re: dynamic context transitions
Message-ID: <20041101204747.GK9643@lkcl.net>
References: <36282A1733C57546BE392885C06185924D9100@chaos.tcs.tcs-sec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <36282A1733C57546BE392885C06185924D9100@chaos.tcs.tcs-sec.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, Nov 01, 2004 at 01:28:57PM -0500, Chad Hanson wrote:
> > able to legitimately collapse multiple domains into a single 
> > equivalence
> > class for information flow analysis purposes, I don't see how this is
> > legitimate for levels.  If they were separate levels in the 
> > first place,
> > then they should be separate equivalence classes for 
> > information flow. 
> > Can you clarify?
> 
> Let me try to give some background.
> 
> The ability for a process to perform actions at multiple MLS labels exists
                             
 an equivalent to seteuid has been successfully resisted for
 some time (on the basis that applications should be redesigned
 to use exec, thereby gaining quite a large benefit in secure
 design irrespective of the use of selinux).

 surely the same principle / lesson should apply to MLS?

 namely that a process _should not_ be able to perform actions at
 multiple MLS labels - that a single process _should not_ be able to
 transition between MLS labels, and that the only boundary on which MLS
 label transitions should be allowed is on an exec()?

 so, the million dollar question is: what is it about MLS that
 make it _necessary_ for individual processes to do as you say?
 [perform actions at multiple MLS labels].

 l.

-- 
--
you don't have to BE MAD   | this space    | my brother wanted to join mensa,
  to work, but   IT HELPS  |   for rent    | for an ego trip - and get kicked 
 you feel better!  I AM    | can pay cash  | out for a even bigger one.
--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
