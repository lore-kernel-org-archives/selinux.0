Subject: Re: [PATCH] refpolicy: add X object classes to unconfined_t
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: ewalsh@tycho.nsa.gov
Cc: Joshua Brindle <jbrindle@tresys.com>, selinux@tycho.nsa.gov
In-Reply-To: <1158355183.7554.268.camel@moss-huskies.epoch.ncsc.mil>
References: <1158088282.7554.95.camel@moss-huskies.epoch.ncsc.mil>
	 <450962DB.7050107@tresys.com>
	 <1158324416.8680.5.camel@twoface.columbia.tresys.com>
	 <1158355183.7554.268.camel@moss-huskies.epoch.ncsc.mil>
Content-Type: text/plain
Date: Mon, 18 Sep 2006 10:43:03 -0400
Message-Id: <1158590583.26420.159.camel@sgc>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2006-09-15 at 17:19 -0400, Eamon Walsh wrote:
> On Fri, 2006-09-15 at 08:46 -0400, Joshua Brindle wrote:
> > On Thu, 2006-09-14 at 10:10 -0400, Joshua Brindle wrote:
> [snip]
> > It also seems that the XSELinuxConfig in the git repository doesn't have
> > all the necessary entries, one for root_window_context needs to be added
> > to start the X server up.
> 
> I've been using the attached config file, however, without the
> unconfined_t patch for targeted, it still won't work unless in
> permissive mode.

I'm not convinced the original patch should go in refpolicy.  What we
need to do is reestablish all the types for the X server properties,
extensions, etc.  Then the unconfined rules would use all the the above,
and then have access to all domains' windows, etc.  Its hard for me to
articulate, since I don't know how all the X object classes work.  What
I'd really like to see would be an example policy.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
