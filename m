Subject: Re: writing rules to disallow a domain to read particular files
From: Colin Walters <walters@verbum.org>
To: jsingh@ensim.com
Cc: SELinux@tycho.nsa.gov
In-Reply-To: <1097940101.2569.5.camel@jsingh.india.ensim.com>
References: <1097940101.2569.5.camel@jsingh.india.ensim.com>
Content-Type: text/plain
Date: Sat, 16 Oct 2004 13:40:13 -0400
Message-Id: <1097948413.3872.3.camel@x-infinity.verbum.private>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 2004-10-16 at 20:51 +0530, Jaspreet Singh wrote:
> Hi,
> 
> can someone help me with writing policy rules such that -
> 
> A domain (say apache_d) cannot access files beyond a directory
> /home/jaspreet/

Look at the label on /home/jaspreet.  It should be user_home_dir_t.  The
labels on contained files are user_home_t.  If you allow httpd_t access
to user_home_dir_t, but not user_home_t, that should achieve your goal.

What is your higher level goal though?

> Also if anyone could explain the behavior of "newrole" how can that be
> used here.

It's not really relevant to your previous problem.  Do you have a
specific question about newrole?


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
