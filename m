Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Carsten Grohmann <carstengrohmann@gmx.de>, SELinux <SELinux@tycho.nsa.gov>
Subject: Re: can_exec_read macro
Date: Tue, 3 Sep 2002 19:27:48 +0200
References: <200209031647.QAA25434@jazzband.ncsc.mil>
In-Reply-To: <200209031647.QAA25434@jazzband.ncsc.mil>
MIME-Version: 1.0
Message-Id: <200209031927.48216.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 3 Sep 2002 18:45, Carsten Grohmann wrote:
> What is the difference between this tow macros: can_exec and
> can_exec_read? I see none.
> Both use the rx_file_perms macro. And in my opinion is the second read in
> can_exec_read unnecessary. The rx_file_perms macro contains it.
>
> We should change it. Or?

You are correct, the second "read" does not seem necessary.

When I added can_exec_read() it was necessary and fixed some problems where 
can_exec() didn't do what was needed.  I guess that in the mean time 
rx_file_perms has changed, I suggest checking the CVS (unfortunately I 
haven't got time to track it down as I'm preparing for my L-K tutorial).

-- 
I do not get viruses because I do not use MS software.
If you use Outlook then please do not put my email address in your
address-book so that WHEN you get a virus it won't use my address in the
>From field.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
