Subject: Re: strange memory use of mcstransd
From: Stephen Smalley <sds@tycho.nsa.gov>
To: russell@coker.com.au
Cc: SE-Linux <selinux@tycho.nsa.gov>
In-Reply-To: <200809111352.51371.russell@coker.com.au>
References: <200809111352.51371.russell@coker.com.au>
Content-Type: text/plain
Date: Thu, 11 Sep 2008 08:12:31 -0400
Message-Id: <1221135151.18396.15.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Thu, 2008-09-11 at 13:52 +1000, Russell Coker wrote:
> root      2307  0.2 21.5 408364 54784 ?        Ss   Aug21  90:08 mcstransd
> 
> 408M of RAM for mcstransd, over the course of 20 days.  The package is 
> mcstrans-0.2.7-1.el5 from CentOS 5.

Sounds like it is leaking memory on every context translation.
We obviously don't have anything to do with mcstrans, so you ought to
take those kinds of things to its upstream (if it has one) or to
bugzilla.redhat.com otherwise.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
