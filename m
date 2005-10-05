Subject: Re: matchpathcon regcomp return code
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Johan Fischer <jfischer@cmcrc.com>, SELinux-dev@tresys.com,
   SELinux@tycho.nsa.gov
In-Reply-To: <1128518379.24059.80.camel@moss-spartans.epoch.ncsc.mil>
References: <43436F35.4040204@cmcrc.com>
	 <1128518379.24059.80.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Wed, 05 Oct 2005 10:29:26 -0400
Message-Id: <1128522566.22129.20.camel@sgc.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2005-10-05 at 09:19 -0400, Stephen Smalley wrote:
> On Wed, 2005-10-05 at 16:14 +1000, Johan Fischer wrote:
> > Anyway, This configuration will not work as expected since the apache.fc
> > file is concatened after the types.fc, the lost+found will get the
> > httpd_sys_content_t type....
> 
> Yes, file contexts ordering/precedence is a known problem.  It is
> exacerbated by the new policy module support, and Tresys has introduced
> a sorting algorithm for their reference policy
> (http://serefpolicy.sf.net) based on fixed string vs. regex (already
> done by matchpathcon), stem length, string length, and presence of the
> file type specifier.  Possibly we should incorporate that sort into
> matchpathcon.  Chris, is there a reason you kept it as a separate helper
> specific to reference policy versus submitting it as a patch to
> matchpathcon itself?  I know that you mentioned that it does alter the
> order in some cases from what we have now, but I think we agreed that we
> can address those cases as needed.

We kept it separate because we were still working with the algorithm.
More importantly, we don't want to affect the example policy, since it
altered the order on at least one occasion, as discussed before.  If you
don't have a problem with this, we can certainly work on a patch for
matchpathcon.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
