Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i52C50rT003655
	for <selinux@tycho.nsa.gov>; Wed, 2 Jun 2004 08:05:00 -0400 (EDT)
Received: from smtp802.mail.ukl.yahoo.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with SMTP id i53C4ieD029809
	for <selinux@tycho.nsa.gov>; Thu, 3 Jun 2004 08:04:45 -0400 (EDT)
Received: from unknown (HELO hyd) (selinux@tycho.nsa.gov@81.155.76.36 with poptime)
  by smtp802.mail.ukl.yahoo.com with SMTP; 2 Jun 2004 12:04:59 -0000
Date: Wed, 2 Jun 2004 12:02:25 +0000
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Russell Coker <russell@coker.com.au>, SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: exim4 / selinux (passwd) clash
Message-ID: <20040602120225.GH2960@lkcl.net>
References: <20040601100649.GV8312@lkcl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20040601100649.GV8312@lkcl.net>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

btw i solved this one by applying the NSA patch to passwd (actually
the shadow package) latest debian unstable source, and it applied
cleanly, and rebuilt cleanly.

in case anyone's interested in keeping up-to-date.

l.

On Tue, Jun 01, 2004 at 10:06:49AM +0000, Luke Kenneth Casson Leighton wrote:
> drat!
> 
> hm, what happens if i back out of passwd...
> 
> sez:/etc/selinux# apt-get install exim4-base
> Reading Package Lists... Done
> Building Dependency Tree... Done
> Some packages could not be installed. This may mean that you have
> requested an impossible situation or if you are using the unstable
> distribution that some required packages have not yet been created
> or been moved out of Incoming.
> 
> Since you only requested a single operation it is extremely likely that
> the package is simply not installable and a bug report against
> that package should be filed.
> The following information may help to resolve the situation:
> 
> The following packages have unmet dependencies:
>   exim4-base: Depends: exim4-config (>= 4.30) but it is not going to be installed or
>                        exim4-config-2
>               Depends: passwd (>= 1:4.0.3-9) but 1:4.0.3-8.selinux.1 is to be installed or
>                        passwd (< 1:4.0.3-1) but 1:4.0.3-8.selinux.1 is to be installed
> E: Broken packages

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
