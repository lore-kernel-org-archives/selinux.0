Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Stephen Smalley <sds@tislabs.com>
Subject: Re: macro for run_init etc
Date: Wed, 11 Sep 2002 22:09:09 +0200
References: <Pine.GSO.4.33.0209111427350.8813-100000@raven> <200209112152.36426.russell@coker.com.au>
In-Reply-To: <200209112152.36426.russell@coker.com.au>
Cc: SELinux <SELinux@tycho.nsa.gov>
MIME-Version: 1.0
Message-Id: <200209112209.09605.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 11 Sep 2002 21:52, Russell Coker wrote:
> > This change has been merged by Chris Vance and is available in
> > sourceforge CVS.
>
> It's in my tree now.

It made no sense to me to have two lines in run_deb.te, so I merged it with 
dpkg.te.  run_deb.te would never work without dpkg.te in any case, and 
dpkg.te makes no sense without run_deb.te

I originally had them in separate policy files because the run_deb policy was 
so big and complex, now it's two lines it should be in the same file.

I think that perhaps the same merging should be done with initrc.te and 
run_init.te.

-- 
I do not get viruses because I do not use MS software.
If you use Outlook then please do not put my email address in your
address-book so that WHEN you get a virus it won't use my address in the
>From field.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
