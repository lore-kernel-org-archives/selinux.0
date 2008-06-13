Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m5DCq1Nr019729
	for <selinux@tycho.nsa.gov>; Fri, 13 Jun 2008 08:52:01 -0400
Received: from goalkeeper.city-fan.org (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m5DCpxhG026819
	for <selinux@tycho.nsa.gov>; Fri, 13 Jun 2008 12:52:00 GMT
Received: from roary.intranet.virtensys.com (host90-152-25-158.ipv4.regusnet.com [90.152.25.158])
	(authenticated bits=0)
	by goalkeeper.city-fan.org (8.14.3/8.14.3) with ESMTP id m5DCpwV8002735
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <selinux@tycho.nsa.gov>; Fri, 13 Jun 2008 13:51:59 +0100
Message-ID: <48526D68.1040807@city-fan.org>
Date: Fri, 13 Jun 2008 13:51:52 +0100
From: Paul Howarth <paul@city-fan.org>
MIME-Version: 1.0
To: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: [refpolicy] Milter Mail Filters
References: <484D4B53.5020006@city-fan.org>
In-Reply-To: <484D4B53.5020006@city-fan.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Paul Howarth wrote:
> attached is a patch based on local policy I'm using on Fedora 9 to 
> support two "milter" mail filter daemons in conjunction with sendmail, 
> namely spamass-milter and milter-regex (I maintain the packages for both 
> of these in Fedora).
> 
> I've taken the view that most milter applications will have similar 
> requirements and so I've created a milter_template interface that 
> contains most of what's needed, and then added the specifics that are 
> needed on top of the generic stuff for each application.
> 
> However, as I'm by no means an selinux expert, there are a number of 
> things I'm unsure about:
> 
> 1. In a situation where sendmail is the running MTA on a system, what is 
> the difference between sendmail_t and system_mail_t?
> 
> 2. MTAs other than sendmail (postfix comes to mind) can also use 
> milters, but as I don't have any boxes running postfix, I don't know 
> what I'd need to add to postfix policy to support milters.
> 
> 3. Fedora 9 has an interface spamassassin_domtrans_spamc that I used in 
> my local policy. It doesn't appear to be present in refpolicy; what 
> would be the right thing to use for a daemon calling spamc?
> 
> 4. I cribbed the milter_port_t stuff from the only example I could find, 
> and it's probably wrong. What would be the correct way of defining this?
> 
> 5. Does the use of a template for these applications a sane way to do it?

Should I have raised this somewhere else, or in a different way? I've 
had no responses either here or on fedora-selinux-list. The 
spamass-milter is currently broken with SELinux enforcing on Fedora 9 
and I'd like to be able to make at least a little progress towards 
fixing that.

Paul.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
