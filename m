Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: "Eric Gingras (LMC)" <Eric.Gingras@ericsson.ca>,
        "SELinux Mailing list (E-mail)" <SELinux@tycho.nsa.gov>
Subject: Re: Another newbie question...
Date: Fri, 13 Sep 2002 11:41:12 +0200
References: <7B2A7784F4B7F0409947481F3F3FEF8304ACC36A@eammlnt051.lmc.ericsson.se>
In-Reply-To: <7B2A7784F4B7F0409947481F3F3FEF8304ACC36A@eammlnt051.lmc.ericsson.se>
MIME-Version: 1.0
Message-Id: <200209131141.12457.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 12 Sep 2002 22:52, Eric Gingras (LMC) wrote:
> Once again, that's what I expected.  But when executing with sysadm_r role
> (I was expecting the same behaviour than when executed in permissive mode)
> no answer.  The process is existing (checked with ps --context) it as the
> desired type (HTTPServer_t) but not even "Starting..." (which is the result
> of 1st instruction) appeared.  Is that a strange behaviour caused by a bug,
> or did I missed something in the "HTTPServer.te"?
>
> Any hints will be apreciated... and sorry for my poor english.

I guess you haven't given it write access to the terminal and inherit access 
for the terminal file handle.

The following should do it:

define(`admin_tty_type', `{ sysadm_tty_device_t sysadm_devpts_t }')
allow HTTPServer_t privfd:fd use;
allow HTTPServer_t admin_tty_type:chr_file { read write };


-- 
I do not get viruses because I do not use MS software.
If you use Outlook then please do not put my email address in your
address-book so that WHEN you get a virus it won't use my address in the
>From field.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
