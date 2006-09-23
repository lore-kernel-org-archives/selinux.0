Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k8N2MwpV008353
	for <selinux@tycho.nsa.gov>; Fri, 22 Sep 2006 22:23:08 -0400
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k8N2LtYb017672
	for <selinux@tycho.nsa.gov>; Sat, 23 Sep 2006 02:21:58 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
Subject: Re: Latest diffs
Date: Sat, 23 Sep 2006 12:22:51 +1000
Cc: Daniel J Walsh <dwalsh@redhat.com>, SE Linux <selinux@tycho.nsa.gov>
References: <45116881.3060406@redhat.com> <1158945196.3920.131.camel@sgc.columbia.tresys.com>
In-Reply-To: <1158945196.3920.131.camel@sgc.columbia.tresys.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200609231222.54604.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Saturday 23 September 2006 03:13, "Christopher J. PeBenito" 
<cpebenito@tresys.com> wrote:
> On Wed, 2006-09-20 at 12:12 -0400, Daniel J Walsh wrote:
> > http://people.redhat.com/dwalsh/SELinux/policy.diff
> >
> > Changed to allow 1024 categories.
>
> Not adding this yet.  Waiting for concensus on how high we should go.

I think that the only solution for this is to allow semanage to configure it.

If you have 10,000 categories and a system that is run for 20 years that never 
re-uses categories (as previously described) then you have the scope for 41 
categories per month.  Assuming 20 working days per month that's two 
categories per day.

I find it easy to imagine organizations that are large enough to have two new 
projects started per day.

Based on the information in Casey's email I think you could justify 64K 
categories, or whatever the upper limit might be.

It seems to me that the ideal solution would be to default to 256 categories 
for regular users and allow people who need it to reconfigure their system 
for more.

-- 
russell@coker.com.au
http://etbe.blogspot.com/          My Blog

http://www.coker.com.au/sponsorship.html Sponsoring Free Software development

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
