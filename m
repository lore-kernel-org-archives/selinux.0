Message-ID: <20050112170231.39090.qmail@web51502.mail.yahoo.com>
Date: Wed, 12 Jan 2005 09:02:31 -0800 (PST)
From: Park Lee <parklee_sel@yahoo.com>
Subject: Re: SELinux with IPSec - something going on ?
To: petre rodan <kaiowas@gentoo.org>
Cc: SELinux@tycho.nsa.gov
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 2004-10-25 at 15:51, petre rodan wrote:
> Hi,
> here is a fresh ipsec-tools [1] policy made for 
> gentoo. works flawlessly with my setup [2] (the doc 
> is work in progress).
> 
> [1] http://ipsec-tools.sourceforge.net/
> [2] http://dev.gentoo.org/~kaiowas/doc/wifi_ipsec-
> howto.html
>
> is this usable for any of you?

In racoon.fc, you wrote:

  ... ...
/var/run/pluto\.ctl	-s
system_u:object_r:racoon_var_run_t
  ... ...

But, when we use IPsec-Tools, it seems that there is
no such a file (i.e. /var/run/pluto.ctl). Then, Why
should we write this rule for it?

Thank you.





=====
Best Regards,
Park Lee


		
__________________________________ 
Do you Yahoo!? 
Yahoo! Mail - Helps protect you from nasty viruses. 
http://promotions.yahoo.com/new_mail

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
