Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r3HGt1Z4007896
	for <selinux@tycho.nsa.gov>; Wed, 17 Apr 2013 12:55:01 -0400
Received: by mail-ee0-f48.google.com with SMTP id b15so881166eek.21
        for <selinux@tycho.nsa.gov>; Wed, 17 Apr 2013 09:54:57 -0700 (PDT)
Message-ID: <1366217693.2803.53.camel@x220.localdomain>
Subject: Re: Not sending AVC denials to audit.log
From: Dominick Grift <dominick.grift@gmail.com>
To: Rodney Simioni <rodney.simioni@verio.net>
Cc: selinux@tycho.nsa.gov
Date: Wed, 17 Apr 2013 18:54:53 +0200
In-Reply-To: <0971982CF6B9AB418FFD5FEF7F50CB9F05E09E0C@IAD-WPRD-XCHB03.corp.verio.net>
References: 
	<0971982CF6B9AB418FFD5FEF7F50CB9F05E09E0C@IAD-WPRD-XCHB03.corp.verio.net>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2013-04-17 at 10:16 -0400, Rodney Simioni wrote:
> Hi,
> 
>  
> 
> I have a few development tests that are failing when I put the server
> in ‘enforcing` mode; however, it’s not sending AVC denials to the
> audit.log.

Is auditd running?



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
