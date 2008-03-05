Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m25Gjrvt027910
	for <selinux@tycho.nsa.gov>; Wed, 5 Mar 2008 11:45:53 -0500
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with SMTP id m25GjqUA025197
	for <selinux@tycho.nsa.gov>; Wed, 5 Mar 2008 16:45:52 GMT
Subject: Re: Unreserved portnumbers in corenetwork
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Ronald van den Blink <selinux@a61.nl>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <DE51A2D4-4153-4E12-BAA8-0D2711553ECF@a61.nl>
References: <37866.80.95.164.250.1204712494.squirrel@www.a61.nl>
	 <1204730645.14217.39.camel@gorn>
	 <51324.80.95.164.250.1204732077.squirrel@www.a61.nl>
	 <1204733123.14217.48.camel@gorn>
	 <DE51A2D4-4153-4E12-BAA8-0D2711553ECF@a61.nl>
Content-Type: text/plain
Date: Wed, 05 Mar 2008 11:43:00 -0500
Message-Id: <1204735380.14217.60.camel@gorn>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2008-03-05 at 17:16 +0100, Ronald van den Blink wrote:
> On Mar 5, 2008, at 5:05 PM, Christopher J. PeBenito wrote:
> 
> > On Wed, 2008-03-05 at 16:47 +0100, selinux@a61.nl wrote:
> >>> Unfortunately there are 3 forces at work.  The first is that for the
> >>> most part, ports should always be labeled, because, for example,  
> >>> port 80
> >>> is always going to be regarded as the http port.  The second is that
> >>> thats not always the case for non well-defined ports (your  
> >>> situation).
> >>> The third is that portcons (the port labeling statements) only  
> >>> work in
> >>> the base module.  So, though we want to make a happy medium  
> >>> between the
> >>> first two, we can't overcome the final one within the constraints  
> >>> of the
> >>> current toolchain.
> >>>
> >>
> >> Agree with that. But wouldn't the situation be a little less  
> >> complicated
> >> if you decide not to define any ports above 1024 in the reference  
> >> policy?
> >
> > That breaks people that just want to use reference policy.
> >
> Does this mean that any module in the refpol that needs (for instance)  
> port 8080 but isn't a http-cache-daemon uses corenetwork_httpd_cache  
> and get's all the other ports defined there as well? Isn't that  
> breaking the least priviliges idea? Because you're opening up more  
> ports then needed?

It depends on how far you want/need to take least privilege.  By this
argument, having all of the shared libraries in /lib and /usr/lib being
the same label would be bad.  You have to evaluate the impact on your
security goals.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
