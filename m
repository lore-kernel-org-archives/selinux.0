Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Stephen Smalley <sds@tislabs.com>, Warren Lerner <wdl@zai.com>
Subject: Re: AVC Messages
Date: Mon, 17 Jun 2002 21:28:08 +0200
Cc: <SELinux@tycho.nsa.gov>
References: <Pine.GSO.4.33.0206171445000.12900-100000@raven>
In-Reply-To: <Pine.GSO.4.33.0206171445000.12900-100000@raven>
MIME-Version: 1.0
Message-Id: <20020617192808.5C8791665@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 17 Jun 2002 21:01, Stephen Smalley wrote:
> > 2.  Can I write my own policy file from scratch and use only the
> > functions necessary for my purpose?
>
> Of course.  But writing a policy from scratch is nontrivial.  As with the
> prior question, please read the aforementioned report.

Writing a policy starting from the sample policy is not trivial either.  Even 
starting from my sample policy (the NSA sample tree plus quite a number of 
things I've written) it still takes a bit of work.

I spent about 3 hours configuring the policy for the SE Debian machine at 
LinuxTag.  3 hours for an expert to configure a shell server with hostile 
users which is also a FTP server is not very good.

Things are being improved though, my latest sample policy tree is much more 
complete, and before OLS I aim to get all the features of the LinuxTag setup 
in my standard default policy and submitted to Stephen.

At that time a typical box with no unusual daemons could be setup by an 
expert in 10 minutes, and by a novice in a few hours.

-- 
I do not get viruses because I do not use MS software.
If you use Outlook then please do not put my email address in your
address-book so that WHEN you get a virus it won't use my address in the
>From field.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
