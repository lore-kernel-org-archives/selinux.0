Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Carsten Grohmann <carstengrohmann@gmx.de>, SELinux <SELinux@tycho.nsa.gov>
Subject: Re: run_init
Date: Sat, 27 Jul 2002 13:30:35 +0200
References: <200207271043.KAA05992@jazzband.ncsc.mil>
In-Reply-To: <200207271043.KAA05992@jazzband.ncsc.mil>
MIME-Version: 1.0
Message-Id: <20020727113036.F0BD2305@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 27 Jul 2002 12:45, Carsten Grohmann wrote:
> The run_init program on my SuSE need follow rule
> allow run_init_t initrc_exec_t:file { execute };
> to correct.
> I think it should need this rule. After this I read rule set and found
> this
> # Execute the init scripts
> domain_auto_trans(run_init_t, etc_t, initrc_t)
>
> Now my question:
> The init scripts are labled with initrc_exec_t and so etc_t should be
> initrc_exec_t to run correct. Or?

run_init is designed to run scripts such as /etc/init.d/ssh (or 
/etc/rc.d/init.d/ssh for some Red Hat based distributions).  Such scripts 
should be labeled etc_t.

So you want something like the following in a file_contexts file:
/etc/rc.d/init.d(|/.*)                    system_u:object_r:etc_t

-- 
I do not get viruses because I do not use MS software.
If you use Outlook then please do not put my email address in your
address-book so that WHEN you get a virus it won't use my address in the
>From field.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
