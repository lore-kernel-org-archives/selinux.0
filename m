Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Carsten Grohmann <carstengrohmann@gmx.de>
Subject: Re: cups
Date: Sat, 3 Aug 2002 19:52:19 +0200
Cc: SELinux <SELinux@tycho.nsa.gov>
References: <20020803172415.CE921FA93@ivanova.coker.com.au>
In-Reply-To: <20020803172415.CE921FA93@ivanova.coker.com.au>
MIME-Version: 1.0
Message-Id: <20020803180200.923331F53@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 3 Aug 2002 19:21, Carsten Grohmann wrote:
> I think, you can /usr/lib/cups/filter/.* labelling as cupsd_exec_t too.
> Then all filter runs automatic in the cupsd_t domain.

True it could be labelled as cupsd_exec_t, but then you couldn't run the 
filter from the command line.  I think it's an advantage to be able to run 
them from the command line, and can't think of any real benefit to do it 
otherwise.

Steve, what do you think?

-- 
I do not get viruses because I do not use MS software.
If you use Outlook then please do not put my email address in your
address-book so that WHEN you get a virus it won't use my address in the
>From field.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
